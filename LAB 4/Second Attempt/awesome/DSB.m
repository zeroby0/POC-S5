%% DSB: DSB of signal
function [time, dsb] = DSB(message, time, fc = 10)
	dsb = message.*cos(2*pi*fc*time);
end
	
