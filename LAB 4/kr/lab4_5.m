T=1;
m=40; %sampling rate as multiple of symbol rate
%discrete time representation of sine pulse
time_p = 0:T/m:T; %sampling times over duration of pulse
p = sin(pi*time_p); %samples of the pulse
%symbols to be modulated
ns=4;
% symbols=arrayfun(@custom_random,rand(ns,1));
symbols = randomArray(4);
%symbols = [1;-1;1;1];
%UPSAMPLE BY m
nsymbols = length(symbols);%length of original symbol sequence
nsymbols_upsampled = 1+(nsymbols-1)*m;%length of upsampled symbol sequence
symbols_upsampled = zeros(nsymbols_upsampled,1);%
symbols_upsampled(1:m:nsymbols_upsampled)=symbols;%insert symbols with spacing M
%GENERATE MODULATED SIGNAL BY DISCRETE TIME CONVOLUTION
u=conv(symbols_upsampled,p)';
%PLOT MODULATED SIGNAL
time_u = 0:T/m:((length(u)-1)*T)/m; %unit of time = symbol time T
ut=(u+1).*cos(2*pi*10*time_u);
%plot(time_u,u);
%[X,f,df]=contFT(u,0,T/m,0.001);
%Plot the modulated signal
[X,f,df]=contFT(ut,0,T/m,0.001);
subplot(2,1,1);
plot(time_u,ut);
%xlim([-10,10]);
xlabel ("t in milli seconds");
ylabel ("Magnitude"); 
grid();
title ("Conventional AM signal");



%Plot The PSD
subplot(2,1,2);
plot(f,(abs(X).^2)/(ns*0.001));
xlabel ("f in kHz");
ylabel ("PSD(X)"); 
grid();
title ("Power Spectral Density of Conventional AM signal");

print -dpng AM.png
