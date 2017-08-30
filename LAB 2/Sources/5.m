function [convolution, time] = contconv (x1, x2, t1, t2, dt)
  % continous convolution
  Tstart1 = t1;
  Tstop1 = t1 + length(x1)*dt - dt;
  
  Tstart2 = t2;
  Tstop2 = t2 + length(x2)*dt - dt;
  
  startTime = Tstart1 + Tstart2;
  endTime = Tstop1 + Tstop2;
  
  time = startTime:dt:endTime;
  convolution = conv(x1,x2).*dt;
endfunction

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

resolution = 0.001
[time, signal] = getSignal(-1, 4, resolution, [i, 3i, 2 + i, -1, -3]);

[time2, signal2] = timeInvert(time, signal);
signal2 = conj(signal2);

timeS = time.+2;  %timeshifting.
signalS = signal.*exp(i*pi/4);

[signalC, timeC] = contconv(signalS, signal2, timeS, time2, resolution);


%plot(timeC, real(signalC));
%xlabel("Time");
%ylabel("Amplitude (Real)")
%title("Real part of s(t) * s*(-t)");
%legend("y = Real( s(t) * s*(-t) )", "Location", "northwest")

%plot(timeC, imag(signalC));
%xlabel("Time");
%ylabel("Amplitude (Imaginary)")
%title("Imaginary part of s(t) * s*(-t)");
%legend("y = Imaginary( s(t) * s*(-t) )", "Location", "northwest")

plot(timeC, abs(signalC));
xlabel("Time");
ylabel("Magnitude")
title("Magnitude of s(t) * s*(-t)");
legend("y = Magnitude( s(t) * s*(-t) )", "Location", "northeast")






  