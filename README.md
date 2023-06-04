# ml-macos-performance

This project is inspired by Vladimir Chernykh coreml-performance project for iOS. I made changes so it works on MacOS to test M1 macbooks. You can find coreml-performnace at the URL below

[https://github.com/vladimir-chernykh/coreml-performance] coreml-performance

## Quick Start

1. clone the repository
2. open the project
3. select the project
4. Go to Signing and capabilities and select your personal account
5. Build the project
6. Run the project
7. Click the button to start the test

## Results

[https://github.com/woolfel/ml-macos-performance/blob/main/results.md] Results on M1 MBA, M1Max BMP, M2Max MBP

## Tips

If the project doesn't build for you, make sure you have the latest XCode.

## CoreML Docs

[https://developer.apple.com/documentation/coreml] apple coreml documentation page

# What does the benchmark do?

The benchmark loads densenet121 model in model folder. It uses an image from the data folder to run predict. The benchmark runs predict 1000 times and measures the elapsed time. The summary printout will show the performance for each type of device.

ANE - Apple Neural Engine

GPU - GPU cores on M1 / M1 Pro / M1 Max

CPU - CPU cores

You can see the utilization in activity monitor or use TG Pro. TG Pro is a paid app and you can download it here

[https://www.tunabellysoftware.com/tgpro/] - monitor heat and utilization
