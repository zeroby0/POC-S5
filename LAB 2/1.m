resolution = 0.001;
first = ones(1/resolution,1);
first = first.*(2);

second = ones(1/resolution, 1);
second = second.*(-1);

third = ones((1/resolution)+1, 1);
third = third.*(-3);

result = vertcat(first, second, third);
filtered = result.*(-1);

time = [1:resolution:4];
plot(time, filtered, time, result);
title("q1");
xlabel ("time");
ylabel ("amplitude");

