symbols = randomArray(4);
samplingRate = 100;

symbolTime = 1;
dt = 1/1000;

[t_message, message] = MSG(symbols, samplingRate, symbolTime);

[f_psd, psd] = PSD(message, t_message, length(symbols), samplingRate, dt);

subplot(2, 1, 1);
	plot(t_message, message);
	title(["Message signal. Symbols = ", mat2str(symbols)]);
	xlabel("Time (mS)");
	ylabel("Amplitude");


subplot(2, 1, 2);
	plot(f_psd, psd);
	title("Power Spectral Density");
	xlabel("Frequency (kHz)");
	ylabel("Magnitude");
	xlim([-2, 2]);

print -dpng 1.png