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

Rsignal = real(signal);
Rsignal2 = real(signal2);

Isignal = imag(signal);
Isignal2 = imag(signal2);

%plot(time, Rsignal, time2, Rsignal2);
%xlabel("Time");
%ylabel("Amplitude (Real)")
%title("Real part of s(t) and s*(-t)");
%legend("y = Real( s(t) )", "y = Real( s*(-t) )", "Location", "southwest")

plot(time, Isignal, time2, Isignal2);
xlabel("Time");
ylabel("Amplitude (Imaginary)")
title("Imaginary part of s(t) and s*(-t)");
legend("y = Imag( s(t) )", "y = Imag( s*(-t) )")






  