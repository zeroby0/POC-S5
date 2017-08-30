function [convolution, time] = contconv (x1, x2, t1, t2, dt)
  % continous convolution
  Tstart1 = t1;
  Tstop1 = t1 + length(x1)*dt - dt;
  
  Tstart2 = t2;
  Tstop2 = t2 + length(x2)*dt - dt;
  
  startTime = Tstart1 + Tstart2;
  endTime = Tstop1 + Tstop2;
  
  time = startTime:dt:endTime;
  t = 1
  convolution = conv(x1,x2).*dt;
endfunction

function [time, result, filtered] = getSignalPair () 
  % get signal and filtered signal
  resolution = 0.001;

  first = ones(1/resolution,1);
  first = first.*(2);

  second = ones(1/resolution, 1);
  second = second.*(-1);

  third = ones((1/resolution)+1, 1);
  third = third.*(-3);

  result = vertcat(first, second, third);
  filtered = result(end:-1:1);

  time = [1:resolution:4];
endfunction

[time, signal, filtered] = getSignalPair();

[result, time] = contconv(signal, filtered, time(1), time(1), 0.001);
plot(time, result);
xlabel("time");
ylabel("magnitude");
title("Convolution of u(t) and u(-t)");

