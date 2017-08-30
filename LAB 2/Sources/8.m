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


function [mags] = getMagnitudes (dt, scalarArray)
  current = ones(1/dt, 1).*scalarArray(1);
  if(length(scalarArray) == 1)
     mags = current;
     return;
  end
  [next] = getMagnitudes(dt, scalarArray(2:1:end));
  mags = vertcat(current, next);
endfunction

function [times, magnitudes] = getSignal(Tstart, Tend, dt, scalars)
  % generates signals made of square waves
  times = Tstart:dt:Tend-dt;
  magnitudes = getMagnitudes(dt, scalars);
endfunction

function [times, magnitudes] = timeInvert(timeVct, magnitudeVct)
  magnitudes = magnitudeVct(end:-1:1);
  times = timeVct(end:-1:1).*(-1);
endfunction

% v(t) = I[-1, 2] + 2I[0, 1]
% v(t) = I[-1, 0] + 3I[0, 1] + I[1, 2]
%
% u(t) = 2I[1, 3] - 3I[2, 4]
% u(t) = 2I[1, 2] - I[2, 3] - 3I[3, 4]
%
% s(t) = u(t) + j*v(t)
% s(t) = (j)I[-1, 0] + (3j)I[0, 1] + (2+j)I[1, 2] - I(2, 3) - 3I(3, 4)

resolution = 0.001; % millisecond
[time, signal] = getSignal(-1, 4, resolution, [i, 3i, 2 + i, -1, -3]);

[amplitudes, frequencies, df] = contFT(signal, time(1), resolution, 1);

Amp = abs(amplitudes);

Amp(1:1:10)

%plot(frequencies, Amp);



