function [X,f,df] = contFT(x,tstart,dt,df_desired)
%Use Matlab DFT for approximate computation of continuous time Fourier 
%transform
%INPUTS
%x = vector of time domain samples, assumed uniformly spaced
%tstart= time at which first sample is taken
%dt = spacing between samples
%df_desired = desired frequency resolution
%OUTPUTS
%X=vector of samples of Fourier transform
%f=corresponding vector of frequencies at which samples are obtained %df=freq resolution attained (redundant--already available from %difference of consecutive entries of f)
%%%%%%%%%
%minimum FFT size determined by desired freq 
Nmin=max(ceil(1/(df_desired*dt)),length(x));
%choose FFT size to be the next power of 2
Nfft = 2^(nextpow2(Nmin))
%compute Fourier transform, centering around 
X=dt*fftshift(fft(x,Nfft));
%achieved frequency resolution
df=1/(Nfft*dt)
%range of frequencies covered
f = ((0:Nfft-1)-Nfft/2)*df; %same as f=-1/(2*dt):df:1/(2*dt) - df
%phase shift associated with start time 
X=X.*exp(-j*2*pi*f*tstart);
end

sampling_freq = 16; % per micro second
dt = 1/sampling_freq;

temp_time = -8:dt:8; % -8 to 8 micro seconds
temp_time = temp_time.*0.5;
time = temp_time; % 2t - 3

temp_signal = sinc(time.-1.5);
signal = temp_signal.*3; % 3sinc(2t - 3)

df_desired = 10^-3 % 0.001 per micro second = 1 KHz.

%plot(time, signal);

[amplitudes, frequencies, df] = contFT(signal, time(1), dt, df_desired);

plot(frequencies, abs(amplitudes));



%plot(frequencies, amplitudes)
xlabel("frequencies (MHz)");
ylabel("Amplitudes");
title("Frequency spectrum of 3*sinc(2t - 3)")

%plot(frequencies, rad2deg(angle(amplitudes)));
%xlabel("frequencies (MHz)");
%ylabel("Phase (degrees)");
%title("Phase spectrum of 3*sinc(2t - 3)")
