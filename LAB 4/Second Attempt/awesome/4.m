symbols = randomArray(4);
samplingRate = 40;

symbolTime = 1;
dt = 1/1000;

[t_message, message] = MSG(symbols, samplingRate, symbolTime);
[t_dsb, dsb] = DSB(message, t_message, 10/symbolTime);

[f_psd, psd] = PSD(dsb, t_dsb, length(symbols), samplingRate, dt);

plot(f_psd, psd);
xlabel("Frequency (kHz)");
ylabel("Magnitude");
title("PSD of upconverted message signal");
xlim([-12, 12]);
print -dpng psd_dsb.png


numberOfSamples = 500;

symbols = randomArray(4);
[t_message, message] = MSG(symbols, samplingRate, symbolTime);
[t_dsb, dsb] = DSB(message, t_message, 10/symbolTime);
[freq, psd] = PSD(dsb, t_dsb, length(symbols), samplingRate, dt);

averagePSD = psd./numberOfSamples;

for i = 1:(numberOfSamples - 1)
	symbols = randomArray(4);
	[t_message, message] = MSG(symbols, samplingRate, symbolTime);
	[t_dsb, dsb] = DSB(message, t_message, 10/symbolTime);
	[f_psd, psd] = PSD(dsb, t_dsb, length(symbols), samplingRate, dt);

	averagePSD = averagePSD + psd./numberOfSamples;
end

plot(freq, averagePSD);
title(["Mean PSD of ", int2str(numberOfSamples), " upconverted signals"]);
xlabel("Frequency (kHz)");
ylabel("Magnitude");
xlim([-12, 12]);

print -dpng mean_psd_dsb.png