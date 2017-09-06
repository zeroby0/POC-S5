function [array] = randomArray (arrayLength)
  % creates Random Array from arrayLength
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
  % creates a random time domain binary signal
  temp_signal = randomArray(arrayLength);
  
  signal = ones(arrayLength, 1/dt);
  signal = bsxfun(@times, signal, temp_signal(:));
  
  signal = signal';
  signal = signal(:);
  
  time = 0:dt:arrayLength - dt;
end

arrayLength = 10;
dt = 0.001;

[time1, Uc] = getU (arrayLength, dt);
[time2, Us] = getU (arrayLength, dt);

plot(time1, Uc);

xlim([-2, arrayLength + 2]);
ylim([-2, 2]);

xlabel("Time");
ylabel("Magnitude");










