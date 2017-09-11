m=16; %sampling rate as multiple of symbol rate 
%discrete time representation of sine pulse
time_p = 0:1/m:1; %sampling times over duration of pulse 
p = sin(pi*time_p); %samples of the pulse
%symbols to be modulated
symbols = [-1;1;1;-1];

%UPSAMPLE BY m
nsymbols = length(symbols);%length of original symbol sequence 
nsymbols_upsampled = 1+(nsymbols-1)*m;%length of upsampled symbol sequence 
symbols_upsampled = zeros(nsymbols_upsampled,1);% 
symbols_upsampled(1:m:nsymbols_upsampled)=symbols;%insert symbols with spacing M 
%GENERATE MODULATED SIGNAL BY DISCRETE TIME CONVOLUTION 
u=conv(symbols_upsampled,p);
%PLOT MODULATED SIGNAL
time_u = 0:1/m:(length(u)-1)/m; %unit of time = symbol time T
plot(time_u,u);
xlabel('t/T');

print -dpng imag.png