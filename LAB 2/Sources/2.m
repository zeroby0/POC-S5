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

function [time, signal, signal_filtered, time_filtered] = getSignalPair ()
  % get signal and filtered signal
  resolution = 0.001;

  first = ones(1/resolution,1);
  first = first.*(2);

  second = ones(1/resolution, 1);
  second = second.*(-1);

  third = ones((1/resolution)+1, 1);
  third = third.*(-3);

  signal = vertcat(first, second, third); % u(t)
  time = [1:resolution:4];

  signal_filtered = signal(end:-1:1); % reversing magnitudes
  time_filtered = time(end:-1:1).*(-1); %reverse and multiply my -1
endfunction

[time, signal, signal_filtered, time_filtered] = getSignalPair();

[convoluted_signal, convoluted_time] = contconv(signal, signal_filtered, time(1), time_filtered(1), 0.001);

plot(convoluted_time, convoluted_signal);

xlabel("time");
ylabel("magnitude");
title("Convolution of u(t) and u(-t)");

