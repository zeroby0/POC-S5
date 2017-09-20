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