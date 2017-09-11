ns = 4;

randA = randomArray(ns)

m=1000; %sampling rate as multiple of symbol rate 


%discrete time representation of sine pulse
time_p = 0:1/m:1; %sampling times over duration of pulse 
p = sin(pi*time_p); %samples of the pulse
%symbols to be modulated
% symbols = [-1;1;1;-1]

symbols = randA;

%UPSAMPLE BY m
nsymbols = length(symbols);%length of original symbol sequence 
nsymbols_upsampled = 1+(nsymbols-1)*m;%length of upsampled symbol sequence 
symbols_upsampled = zeros(nsymbols_upsampled,1);% 
symbols_upsampled(1:m:nsymbols_upsampled)=symbols;%insert symbols with spacing M 
%GENERATE MODULATED SIGNAL BY DISCRETE TIME CONVOLUTION

u=conv(symbols_upsampled,p);
%PLOT MODULATED SIGNAL
time_u = 0:1/m:(length(u)-1)/m; %unit of time = symbol time T

figure(1)
plot(time_u,u);
xlabel('t/T');

print -dpng imag.png

figure(2)
[U, freq_U, df_acquired] = contFT(u, time_u(1), 1/m, 1);

% Extracting one column from U
% U is a matrix with the same column repeated
U = U(:, 1)';

plot(freq_U, U);
xlabel('Freq');
xlim([-50, 50]);
print -dpng imag2.png

% magnitude squared of the Fourier transform, divided by nsT, the length of the observation interval.
magSquaredU = abs(U).^2.*(m/ns);
freq_magSquaredU = freq_U;

figure(3)
plot(freq_magSquaredU, magSquaredU);
xlim([-20, 20]);

print -dpng imag3.png




