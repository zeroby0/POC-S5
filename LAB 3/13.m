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
  temp_signal = randomArray(arrayLength);
  
  signal = ones(arrayLength, 1/dt);
  signal = bsxfun(@times, signal, temp_signal(:));
  
  signal = signal';
  signal = signal(:);
  
  time = 0:dt:arrayLength - dt;
end

arrayLength = 10;
dt = 0.005;

[time1, Uc] = getU (arrayLength, dt);
[time2, Us] = getU (arrayLength, dt);

carrier_IP = arrayfun(@(t) cos(40*pi*t), time1); %in phase carrier
carrier_QC = arrayfun(@(t) sin(40*pi*t), time1); %Q component

UpIP = Uc.*carrier_IP';
UpQC = Us.*carrier_QC';

size(UpIP);
size(UpQC);

Up = UpIP.-UpQC;

plot(time1 , Up);

xlabel("Time");
ylabel("Magnitude");