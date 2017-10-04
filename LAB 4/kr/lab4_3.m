T=1;
m=16; %sampling rate as multiple of symbol rate
%discrete time representation of sine pulse
time_p = 0:T/m:T; %sampling times over duration of pulse
p = sin(pi*time_p); %samples of the pulse
%symbols to be modulated
ns=4;

% size(time_p)
% size(p)



symbols=randomArray(4);
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
%multiply by the carrier
ut=u.*cos(2*pi*10*time_u);

% size(time_u)
% size(u)
% size(ut)

plot(time_u,ut);
xlabel ("t in milli seconds");
ylabel ("Magnitude"); 
grid();
title ("Upconverted message signal (DSB)");

print -dpng dsb.png
