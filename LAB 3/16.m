function [array] = randomArray (arrayLength)
  array = rand(arrayLength, 1);
  for i = 1:length(array)
    if (array(i) < 0.5)
      array(i) = -1;
    else
      array(i) = 1;
    end
  end
end


function [time, signal] = getU (arrayLength, dt)
  temp_signal = randomArray(arrayLength)
  
  signal = ones(arrayLength, 1/dt);
  signal = bsxfun(@times, signal, temp_signal(:));
  
  signal = signal';
  signal = signal(:);
  
  time = 0:dt:arrayLength - dt;
end

arrayLength = 10;
dt = 0.001;

src_theta = 0;

[time1, Uc] = getU (arrayLength, dt);
[time2, Us] = getU (arrayLength, dt);

carrier_IP = arrayfun(@(t) cos(40*pi*t + src_theta), time1); %in phase carrier
carrier_QC = arrayfun(@(t) sin(40*pi*t + src_theta), time1); %Q component

UpIP = Uc.*carrier_IP';
UpQC = Us.*carrier_QC';

size(UpIP);
size(UpQC);

Up = UpIP.-UpQC; % Up


% ______________________________________________________________________________

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

function [mags] = getMagnitudes (duration, dt, scalarArray)
  current = ones(duration/dt, 1).*scalarArray(1);
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
  magnitudes = getMagnitudes(Tend - Tstart, dt, scalars);
endfunction


theta = pi/4; % in Radians

theta_genie = pi/4;

I_mask = arrayfun(@(t) 2*cos(40*pi*t + theta), time1);
I_unfiltered = Up.*I_mask';


Q_mask = arrayfun(@(t) 2*sin(40*pi*t + theta), time1);
Q_unfiltered = Up.*Q_mask';

% generating filter impulse response
% I(0, 0.25)
[time_response, response] = getSignal(0, 0.25, dt, [1]);

% Filtered inphase component
[I_filtered, time_I_filtered] = contconv(I_unfiltered, response, time1(1), time_response(1), dt);

% Filtered Quadrature component
[Q_filtered, time_Q_filtered] = contconv(Q_unfiltered, response, time2(1), time_response(1), dt);

% complex envelope at reciever
CE_rec = I_filtered.+i*Q_filtered;

% complex envelope at sender
CE_trs = CE_rec.*exp(i*-theta_genie);

I_recovered = real(CE_trs);
Q_recovered = imag(CE_trs);

plot(time_I_filtered, Q_recovered);
% plot(time_Q_filtered, Q_filtered);

xlabel("Time");
ylabel("Magnitude");