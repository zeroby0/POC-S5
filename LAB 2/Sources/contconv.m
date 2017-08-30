function [convolution, time] = contconv (x1, x2, t1, t2, dt)
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

