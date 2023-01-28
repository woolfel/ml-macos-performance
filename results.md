# Summary

## M1 Macbook Air

* 4e / 4p CPU
* 8 GPU
* 16G memory
* 512 SSD

## M1 Max Macbook Pro

* 2e / 8p CPU
* 24 GPU
* 32G memory
* 2TB SSD

## M2 Max Macbook Pro
* 4e / 8p CPU
* 38 GPU
* 96G memory
* 2TB SSD

## Densenet 121

DenseNet121 model was originally converted from tensorflow keras. It has 8.1 million parameters and 121 layers. The model is bigger than M1 or M2 cache, which means a lot of time is spent shuttling data to the CPU.

## Results

### M1 Macbook Air
densenet121_keras_applications
Latency ANE : 0.001799683166667819
RPS ANE : 555.6533608365842

densenet121_keras_applications
Latency GPU : 0.01601039358333219
RPS GPU : 62.459426421662855

densenet121_keras_applications
Latency CPU : 0.01709440333333623
RPS CPU : 58.49867822235565

### M1 Max Macbook Pro
densenet121_keras_applications
Latency ANE : 0.0020508153333333324
RPS ANE : 487.610943679961

densenet121_keras_applications
Latency GPU : 0.010757046333333336
RPS GPU : 92.96232153442118

densenet121_keras_applications
Latency CPU : 0.01667717783333333
RPS CPU : 59.962183649637694

## Observations

For some odd reason, the results for Apple Neural Engine on M1 Max is slower than M1. I ran the test multiple times and macbookair ANE consistently beat the newer M1 Max. I'm guessing it's a bug in CoreML. When I run on MBP, XCode spits out this error.

Macbook Air does not get this error when I run it. I've compared the build settings on both systems and they are the same. Hopefully Apple will fix this bug soon and I can run the test again to get better resutls.

<pre>
2021-11-27 22:08:35.806852-0500 MLMacosPerf[628:7282] Metal API Validation Enabled
2021-11-27 22:08:35.978426-0500 MLMacosPerf[628:7282] H11ANEDevice::H11ANEDeviceOpen IOServiceOpen failed result= 0xe00002e2
2021-11-27 22:08:35.978460-0500 MLMacosPerf[628:7282] H11ANEDevice::H11ANEDeviceOpen kH11ANEUserClientCommand_DeviceOpen call failed result=0xe00002bc
2021-11-27 22:08:35.978472-0500 MLMacosPerf[628:7282] Error opening LB - status=0xe00002bc.. Skipping LB and retrying
2021-11-27 22:08:36.208392-0500 MLMacosPerf[628:7282] H11ANEDevice::H11ANEDeviceOpen IOServiceOpen failed result= 0xe00002e2
2021-11-27 22:08:36.208419-0500 MLMacosPerf[628:7282] H11ANEDevice::H11ANEDeviceOpen kH11ANEUserClientCommand_DeviceOpen call failed result=0xe00002bc
2021-11-27 22:08:36.208432-0500 MLMacosPerf[628:7282] Error opening LB - status=0xe00002bc.. Skipping LB and retrying
</pre>

# May 2, 2022 Update

It appears the latest version of XCode and MacOS fixed the Metal Validation error. I reran the test on M1Max Macbook Pro. ANE on MacbookAir is still a bit faster. The fix definitely improved ANE performance on M1Max.

densenet121_keras_applications
Latency ANE : 0.0018782001250000064
RPS ANE : 532.4246264758376

densenet121_keras_applications
Latency GPU : 0.00975093989583334
RPS GPU : 102.55421638146991

densenet121_keras_applications
Latency CPU : 0.016688692041666685
RPS CPU : 59.92081329700964

# Jan 17, 2023 Update

The latest version of XCode and Mac has improved the performance of ANE. It went from 532 > 670 for a 25% improvement.

densenet121_keras_applications
Latency   ANE : 0.0014909637291711988
RPS  ANE : 670.7071275006018 

densenet121_keras_applications
Latency   GPU : 0.009684643208333
RPS  GPU : 103.25625616641877 

densenet121_keras_applications
Latency   CPU : 0.01708390016666817
RPS  CPU : 58.53464315783504 

# Jan 27, 2023 Update - M2Max 38GPU/96G

densenet121_keras_applications
Latency ANE : 0.0012743692083333827
RPS ANE : 784.7019478034924

densenet121_keras_applications
Latency GPU : 0.008270947500000033
RPS GPU : 120.90513209036763

densenet121_keras_applications
Latency CPU : 0.015347813229166719
RPS CPU : 65.15586195039286

ChickenDetector
Latency ANE : 0.001355774541666733
RPS ANE : 737.5857631687355

ChickenDetector
Latency GPU : 0.0018289530104167397
RPS GPU : 546.7609032624316

ChickenDetector
Latency CPU : 0.011537113656250085
RPS CPU : 86.67679194252045

# Jan 28, 2023 Update - M1Max 24GPU/32G

densenet121_keras_applications
Latency ANE : 0.001407081708332953
RPS ANE : 710.6907822607935

densenet121_keras_applications
Latency GPU : 0.009703234135416097
RPS GPU : 103.05842217597048

densenet121_keras_applications
Latency CPU : 0.016863174791667008
RPS CPU : 59.30081448803776

ChickenDetector
Latency ANE : 0.0015873758541665665
RPS ANE : 629.9705248603763

ChickenDetector
Latency GPU : 0.002397619229166594
RPS GPU : 417.08040536011106

ChickenDetector
Latency CPU : 0.013234461333333456
RPS CPU : 75.56030992219637

## Software Versions

### Previous Versions

XCode 12.3.1 (12E500a)

MacOS Monterey 12.3.1

### Current Versions

XCode 14.2 (14C18)

MacOS Ventura 13.1
