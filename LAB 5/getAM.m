%% getAM: Returns random AM signal
function [tAM, uAM] = getAM()
	ns = 4;

	T = 1; % In milli seconds
	m = 40; % Sample rate

	%discrete time representation of sine pulse
	time_p = 0:T/m:1; %sampling times over duration of pulse 
	p = sin(pi*time_p); %samples of the pulse
	%symbols to be modulated
	% symbols = [-1;1;1;-1]

	% Random symbols
	symbols = randomArray(4);

	%UPSAMPLE BY m
	nsymbols = length(symbols);%length of original symbol sequence 
	nsymbols_upsampled = 1+(nsymbols-1)*m;%length of upsampled symbol sequence 
	symbols_upsampled = zeros(nsymbols_upsampled,1);% 
	symbols_upsampled(1:m:nsymbols_upsampled) = symbols;%insert symbols with spacing M 

	%GENERATE MODULATED SIGNAL BY DISCRETE TIME CONVOLUTION
	u = conv(symbols_upsampled,p)';

	%PLOT MODULATED SIGNAL
	time_u = 0:T/m:(length(u)-1)/m; %unit of time = symbol time T


	% %%%%%%%%%%%%%
	% The AM signal

	Ac = 1;
	fc = 10/T;

	tAM = time_u;
	uAM = (u + Ac).*cos(2*pi*fc*tAM);

	size(tAM)
	size(uAM)
end
