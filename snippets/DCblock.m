%% DBblock: function description
function [time_dcblock, signal_dcblock] = DCblock(time, signal)

	meanSignal = mean(signal)

	time_dcblock = time;
	signal_dcblock = signal.-meanSignal;

end

