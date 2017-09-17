T=1;
m=100; %sampling rate as multiple of symbol rate
%discrete time representation of sine pulse
time_p = 0:T/m:T; %sampling times over duration of pulse
p = sin(pi*time_p); %samples of the pulse
%symbols to be modulated
ns=4;
%Taking symbols at random
% symbols=arrayfun(@custom_random,rand(ns,1))

symbols=randomArray(4);

%UPSAMPLE BY m
nsymbols = length(symbols);%length of original symbol sequence
nsymbols_upsampled = 1+(nsymbols-1)*m;%length of upsampled symbol sequence
symbols_upsampled = zeros(nsymbols_upsampled,1);%
symbols_upsampled(1:m:nsymbols_upsampled)=symbols;%insert symbols with spacing M
%GENERATE MODULATED SIGNAL BY DISCRETE TIME CONVOLUTION
u=conv(symbols_upsampled,p)';
time_u = 0:T/m:((length(u)-1)*T)/m; %unit of time = symbol time T
%Take fourier Transform
[X,f,df]=contFT(u,0,T/m,0.001);

%Plot the modulated signal
subplot(2,1,1);
plot(time_u,u);
%xlim([-10,10]);
xlabel ("t in milli seconds");
ylabel ("Magnitude"); 
grid();
title ("Modulated message signal");


%Plot The PSD
subplot(2,1,2);
plot(f,(abs(X).^2)/(ns*0.001));
xlim([-5,5]);
xlabel ("f in kHz");
ylabel ("PSD(X)"); 
grid();
title ("Power Spectral Density of modulated message signal");

print -dpng 4_1.png
