T=1;
m=16; %sampling rate as multiple of symbol rate
%discrete time representation of sine pulse
time_p = 0:T/m:T; %sampling times over duration of pulse
p = sin(pi*time_p); %samples of the pulse
%symbols to be modulated
ns=4;
X_avg=0;
no_avg=1000; % number of outputs we want, to calculate the average
for i=1:1:no_avg
  symbols=randomArray(4);
  %UPSAMPLE BY m
  nsymbols = length(symbols);%length of original symbol sequence
  nsymbols_upsampled = 1+(nsymbols-1)*m;%length of upsampled symbol sequence
  symbols_upsampled = zeros(nsymbols_upsampled,1);%
  symbols_upsampled(1:m:nsymbols_upsampled)=symbols;%insert symbols with spacing M
  %GENERATE MODULATED SIGNAL BY DISCRETE TIME CONVOLUTION
  u=conv(symbols_upsampled,p)';
  [X,f,df]=contFT(u,0,T/m,0.001);
  X_power=(abs(X).^2)/(ns*0.001);
  if(X_avg == 0)
    X_avg=X_power;
  else
    X_avg=X_avg+X_power;
  end
  end
X_avg=X_avg/no_avg;
%time_u = 0:T/m:((length(u)-1)*T)/m; %unit of time = symbol time T
%plot(time_u,u);
%plot(time_p,p);
plot(f,X_avg);
xlim([-3,3]);
xlabel ("f in kHz");
ylabel ("PSD(X_average)"); 
grid();
title("Average of power spectral densities of 1000 inputs");
%plot(freqHz,abs(X));

pause()
