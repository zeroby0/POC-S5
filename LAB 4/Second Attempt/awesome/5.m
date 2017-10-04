
samplingRate = 40;

symbolTime = 1;
dt = 1/1000;

Ac = 1;
fc = 10;


symbols = randomArray(4);
[t_message, message] = MSG(symbols, samplingRate, symbolTime); % m(t)
[t_am, am] = AM(message, t_message, Ac, fc); % u(t) = Am( m(t) )
[t_dsb, dsb] = DSB(am, t_am, 10/symbolTime); % DSB

subplot(3, 1, 1);
	plot(t_message, message);
	title(["Message signal. Symbols = ", mat2str(symbols)]);
	xlabel("Time (mS)");
	ylabel("Amplitude");

subplot(3, 1, 2);
	plot(t_am, am);
	title("Amplitude Modulated message signal");
	xlabel("Time (mS)");
	ylabel("Amplitude");

subplot(3, 1, 3);
	plot(t_dsb, dsb);
	title("DSB of message signal");
	xlabel("Time (mS)");
	ylabel("Amplitude");

print -dpng dsb_ac.png

[f_psd, psd] = PSD(dsb, t_dsb, length(symbols), samplingRate, dt);

plot(f_psd, psd);
title("PSD of DSB of AM signal");
xlabel("Frequency (kHz)");
ylabel("Magnitude");
xlim([-2, 2]);

print -dpng psd_dsb_am.png





numberOfSamples = 50;

symbols = randomArray(4);
[t_message, message] = MSG(symbols, samplingRate, symbolTime); % m(t)
[t_am, am] = AM(message, t_message, Ac, fc); % u(t) = Am( m(t) )
[t_dsb, dsb] = DSB(am, t_am, 10/symbolTime); % DSB
[freq, psd] = PSD(dsb, t_dsb, length(symbols), samplingRate, dt);

averagePSD = psd./numberOfSamples;

for i = 1:(numberOfSamples - 1)
	symbols = randomArray(4);
	[t_message, message] = MSG(symbols, samplingRate, symbolTime); % m(t)
	[t_am, am] = AM(message, t_message, Ac, fc); % u(t) = Am( m(t) )
	[t_dsb, dsb] = DSB(am, t_am, 10/symbolTime); % DSB
	[freq, psd] = PSD(dsb, t_dsb, length(symbols), samplingRate, dt);

	averagePSD = averagePSD + psd./numberOfSamples;
end


plot(freq, averagePSD);
title(["Mean PSD of ", int2str(numberOfSamples), " upconverted amplitude-modulated-signals"]);
xlabel("Frequency (kHz)");
ylabel("Magnitude");
% xlim([-22, 22]);
print -dpng mean_psd_dsb_am.png