//
//  Predictor.swift
//  MLMacosPerf
//
//  Created by Peter Lin on 10/25/21.
//

import Foundation
import CoreML

// Predictor class follow CoreML MLModel API
// It is inspired by https://github.com/vladimir-chernykh/coreml-performance
// benchmark on github. The difference is this project is meant to test Apple
// M1 silicon performance instead of iPhone or iPad
class Predictor {
    var mlmodel: MLModel
    
    class func url(forResource fileName: String) -> URL {
        let bundle = Bundle(for: Predictor.self)
        return bundle.url(forResource: fileName, withExtension: "mlmodelc")!
    }
    
    init(contentsOf url: URL) throws {
        self.mlmodel = try MLModel(contentsOf: url)
    }
    
    init(contentsOf url: URL, configuration: MLModelConfiguration) throws {
        self.mlmodel = try MLModel(contentsOf: url, configuration: configuration)
    }
    
    convenience init(contentsOf fileName: String, configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of: self).url(forResource: fileName), configuration: configuration)
    }
    
    func predict(input: MLFeatureProvider) throws -> MLFeatureProvider {
        return try mlmodel.prediction(from: input)
    }
}
