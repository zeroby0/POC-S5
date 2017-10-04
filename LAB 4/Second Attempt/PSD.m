%% PSD: Returns the Power Spectral Density of a signal
function [freq_psd, psd, time_message, message] = PSD(symbols, m = 100, t_plot = false, dt = 1/1000)
	% code fragment 2.3.2 - page 45
	s = 1; % Symbol time - in milli seconds

	% Reference Signal
	time_p = 0:s/m:s;
	p = sin(pi*time_p);

	% "time_p & p"
	% size(time_p)
	% size(p)

	if t_plot
		subplot(3, 1, 1);
		plot(time_p, p);
		title("Reference Signal");
		xlabel("Time (mS)");
		ylabel("Amplitude");
	end

	% Upsampling
	nsymbols = length(symbols);

	nsymbols_upsampled = 1 + (nsymbols-1)*m;
	nsymbols_upsampled = nsymbols_upsampled*s;

	symbols_upsampled = zeros(nsymbols_upsampled, 1);
	symbols_upsampled(1:m*s:nsymbols_upsampled) = symbols; % Inserting symbols with spacing m

	u = conv(symbols_upsampled, p)';
	time_u = 0:s/m:(length(u) - 1)*s/m;

	% "time_u & u"
	% size(time_u)
	% size(u)

	if t_plot
		subplot(3, 1, 2);
		plot(time_u, u);
		str_title = cstrcat("Modulated signal. Message = ", mat2str(symbols));
		title(str_title);
		xlabel("Time (mS)");
		ylabel("Amplitude");
	end

	message = u;
	time_message = time_u;	

	% Calculating PSD

	[U, freq_U, df_acquired] = contFT(u, time_u(1), 1/m, dt);

	psd = abs(U).^2.*(1/(nsymbols*dt));
	freq_psd = freq_U;

	% "freq_psd, psd"
	% size(freq_psd)
	% size(psd)

	if t_plot
		subplot(3, 1, 3);
		plot(freq_psd, psd);
		title("Power Spectral Density");
		xlabel("Frequency (kHz)");
		ylabel("Magnitude");
		xlim([-2, 2]);
		print -dpng psd.png;
	end

end