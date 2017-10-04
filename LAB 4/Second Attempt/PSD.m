%% PSD: Returns the Power Spectral Density of a signal
function [freq_psd, psd] = PSD(symbols, m = 100, t_plot = false)
	% code fragment 2.3.2 - page 45
	s = 1; % Symbol time - in milli seconds

	% Reference Signal
	time_p = 0:1/m:s;
	p = sin(pi*time_p);

	if t_plot
		subplot(3, 1, 1);
		plot(time_p, p);
		title("Reference Signal");
		xlabel("Time");
		ylabel("Amplitude");
	end

	% Upsampling
	nsymbols = length(symbols);

	nsymbols_upsampled = 1 + (nsymbols-1)*m;
	nsymbols_upsampled = nsymbols_upsampled*s;

	symbols_upsampled = zeros(nsymbols_upsampled, 1);
	symbols_upsampled(1:m*s:nsymbols_upsampled) = symbols; % Inserting symbols with spacing m

	u = conv(symbols_upsampled, p);
	time_u = 0:1/m:(length(u) - 1)/m;

	if t_plot
		subplot(3, 1, 2);
		plot(time_u, u);
		str_title = cstrcat("Modulated signal. Message = ", mat2str(symbols));
		title(str_title);
		xlabel("Time");
		ylabel("Amplitude");
	end
		
		

	% Calculating PSD

	[U, freq_U, df_acquired] = contFT(u, time_u(1), 1/m, 1);

	% Extracting one column from U
	% U is a matrix with the same column repeated
	U = U(:, 1)';

	psd = abs(U).^2.*(m/nsymbols);
	freq_psd = freq_U;

	if t_plot
		subplot(3, 1, 3);
		plot(freq_psd, psd);
		title("Power Spectral Density");
		xlabel("Frequency");
		ylabel("Magnitude");
		xlim([-2, 2]);
		print -dpng psd.png;
	end

end