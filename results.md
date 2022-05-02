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

## Software Versions

XCode 12.3.1 (12E500a)

MacOS Monterey 12.3.1
