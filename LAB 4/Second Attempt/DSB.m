%% DSB: generates DSB of signal
function [time, dsb, time_m, message] = DSB(symbols, m = 100, fc = 10, t_plot = false)
	[_, _, time_m, message] = PSD(symbols, m, t_plot);
	dsb = message.*cos(2*pi*fc*time_m);
	time = time_m;
	if t_plot
		subplot(3, 1, 3);
		plot(time, dsb);
		title("DSB");
		xlabel("Time (mS)");
		ylabel("Amplitude");
		print -dpng dsb.png
	end

end
