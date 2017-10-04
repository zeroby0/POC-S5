numberOfSamples = 500;
samplingRate = 100;
dt = 1/1000;
symbolTime = 1;

[freq, averagePSD] = meanPSD(numberOfSamples, samplingRate, dt, symbolTime);

plot(freq, averagePSD);
title(["Mean PSD of ", int2str(numberOfSamples), " signals"]);
xlabel("Frequency (kHz)");
ylabel("Magnitude");
xlim([-2, 2]);

print -dpng 2.png