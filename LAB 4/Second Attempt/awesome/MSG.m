%% MSG: Returns modulated message signal from symbols
function [time, message] = MSG(symbols, samplingRate = 100, symbolTime = 1)
	t_ref = 0:symbolTime/samplingRate:symbolTime;
	ref = sin(pi*t_ref);

	% samplingRate => m
	% symbolTime => T

	nsymbols = length(symbols);

	nsymbols_upsampled = 1 + (nsymbols - 1)*samplingRate;
	nsymbols_upsampled = nsymbols_upsampled * symbolTime;

	symbols_upsampled = zeros(nsymbols_upsampled, 1);
	symbols_upsampled(1:samplingRate*symbolTime:nsymbols_upsampled) = symbols;

	message = conv(symbols_upsampled, ref)';
	time = 0:symbolTime/samplingRate:(length(message) - 1)*symbolTime/samplingRate;
end
	
