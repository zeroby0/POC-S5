symbols = randomArray(4);
samplingRate = 40;

symbolTime = 1;
dt = 1/1000;

[t_message, message] = MSG(symbols, samplingRate, symbolTime);
[t_dsb, dsb] = DSB(message, t_message, 10/symbolTime);

subplot(2, 1, 1);
	plot(t_message, message);
	title(["Message signal. Symbols = ", mat2str(symbols)]);
	xlabel("Time (mS)");
	ylabel("Amplitude");

subplot(2, 1, 2);
	plot(t_dsb, dsb);
	title("DSB of message signal");
	xlabel("Time (mS)");
	ylabel("Amplitude");

print -dpng 3.png

