%% meanPSD: find the average PSD
function [freq, averagePSD] = meanPSD(numberOfSamples, samplingRate, dt = 1/1000, symbolTime = 1)

	symbols = randomArray(4);
	[t_message, message] = MSG(symbols, samplingRate, symbolTime);
	[freq, psd] = PSD(message, t_message, length(symbols), samplingRate, dt);

	averagePSD = psd./numberOfSamples;

	for i = 1:(numberOfSamples - 1)
		symbols = randomArray(4);
		[t_message, message] = MSG(symbols, samplingRate, symbolTime);
		[f_psd, psd] = PSD(message, t_message, length(symbols), samplingRate, dt);

		averagePSD = averagePSD + psd./numberOfSamples;
	end
end