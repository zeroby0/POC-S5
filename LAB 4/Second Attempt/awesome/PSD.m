%% PSD: Returns the power spectral density of message signal
function [freq, psd] = PSD(message, time, ns, samplingrate = 100, dt = 1/1000)
	[U, freq, df_acquired] = contFT(message, time(1), 1/samplingrate, dt);

	psd = abs(U).^2.*(1/(ns*dt));
end
