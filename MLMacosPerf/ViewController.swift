//
//  ViewController.swift
//  MLMacosPerf
//
//  Created by Peter Lin on 10/25/21.
//

import Cocoa
import CoreML
import Vision

class ViewController: NSViewController {

    var resultSummary:NSTextField?
    
    @IBOutlet var startButton:NSButton?
    
    @IBAction func startTestAction(_ sender: NSButton) {
        sender.title = "Running";
        if resultSummary != nil {
            resultSummary?.removeFromSuperview();
        }
        DispatchQueue.main.async {
            var summary = "";
            for modelName in [
                    "densenet121_keras_applications",
                ] {
                for device in ["ANE", "GPU", "CPU"] {
                    // warmup
                    _ = try! self.runPredictBenchmark(
                        modelName: modelName,
                        device: device,
                        numIter: 50
                    )
                    // real test
                    let latency = try! self.runPredictBenchmark(
                        modelName: modelName,
                        device: device,
                        numIter: 1000
                    )
                    print(modelName)
                    print("Latency \(device) : \(latency)")
                    print("RPS \(device) : \(1 / latency)")
                    print()
                    summary += "\(modelName)\n"
                    summary += "Latency   \(device) : \(latency)  \n"
                    summary += "Run/Sec  \(device) : \(1/latency) \n\n"
                }
                sender.title = "Done!";
            }
            self.resultSummary = NSTextField(string: summary);
            self.view.addSubview(self.resultSummary!);
            self.resultSummary?.translatesAutoresizingMaskIntoConstraints = false;
            let align = NSLayoutConstraint(item: self.resultSummary!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 1);
            let width = NSLayoutConstraint(item: self.resultSummary!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 400);
            let height = NSLayoutConstraint(item: self.resultSummary!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 245);
            self.view.addConstraints([align, width, height]);
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.startButton?.title = "Click to Start";
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func url(forResource fileName: String, withExtension ext: String) -> URL {
        let bundle = Bundle(for: ViewController.self)
        return bundle.url(forResource: fileName, withExtension: ext)!
    }

    func configureDevice(device: String) -> MLModelConfiguration {
        let mlconfig = MLModelConfiguration()
        if (device.lowercased() == "ane") {
            mlconfig.computeUnits = .all
        } else if (device.lowercased() == "gpu") {
            mlconfig.computeUnits = .cpuAndGPU
        } else {
            mlconfig.computeUnits = .cpuOnly
        }
        return mlconfig
    }
    
    // function will run the benchmark to train
    func runPredictBenchmark(modelName: String, device: String, numIter: Int = 100) throws -> Double {
        let mlconfig = configureDevice(device: device)
        
        let model = try Predictor(contentsOf: modelName, configuration: mlconfig)
        
        let imageFeatureValue = try MLFeatureValue (
            imageAt: url(forResource: "test09", withExtension: "jpg"),
            constraint: model.mlmodel.modelDescription.inputDescriptionsByName["input_1"]!.imageConstraint!,
            options: [.cropAndScale: VNImageCropAndScaleOption.centerCrop.rawValue]
        )
        let input = try MLDictionaryFeatureProvider(
            dictionary: ["input_1": imageFeatureValue.imageBufferValue!])
        
        let start = CACurrentMediaTime()
        for _ in 0..<numIter {
            _ = try! model.predict(input: input)
        }
        let end = CACurrentMediaTime()
        let elapsed = end - start
        return elapsed / Double(numIter)
    }
    
    func runTrainBenchmark(modelName: String, device: String, withExtension: String) throws {
        let mlconfig = configureDevice(device: device)

    }
}
