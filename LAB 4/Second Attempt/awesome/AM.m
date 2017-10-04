%% AM: Amplitude Modulates message signal
function [t_am, am] = AM(signal, time, Ac, fc)
	t_am = time;
	am = (signal + Ac).*cos(2*pi*fc*t_am);
end
