% % page 45

m = 100; % Sampling rate - multiple of symbol rate
ns = 4;
s = 1; % 1 milli second

% Signal
time_p = 0:1/m:s;
p = sin(pi*time_p);


% symbols = [-1; 1; 1; -1];

symbols = randomArray(4);

% Upsampling by m
nsymbols = length(symbols);

nsymbols_upsampled = 1 + (nsymbols-1)*m;
nsymbols_upsampled = nsymbols_upsampled*s;

symbols_upsampled = zeros(nsymbols_upsampled, 1);
symbols_upsampled(1:m*s:nsymbols_upsampled) = symbols; % Inserting symbols with spacing m



% nsymbols_upsampled'
% symbols_upsampled'


u = conv(symbols_upsampled, p);
time_u = 0:1/m:(length(u) - 1)/m;

size(u);
size(time_u');

subplot(2, 1, 1);
	plot(time_p, p);
	title("Reference Signal");
	xlabel("Time");
	ylabel("Amplitude");

str_title = strcat("Modulated signal. Message =", mat2str(symbols));

% str_title = [str_title(1:end-1); mat2str(symbols)]
% str_title( str_title == "\n" ) = " "

subplot(2, 1, 2);
	plot(time_u, u);
	xlim([0, nsymbols*s]);
	title(str_title);
	xlabel("Time");
	ylabel("Amplitude");

print -dpng "2.3.2.png"