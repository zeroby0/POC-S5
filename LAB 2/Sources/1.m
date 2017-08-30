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
plot(time, filtered, time, result);
title("u(t) = 2I[1,3](t) - 3I[2,4](t)");
xlabel ("time");
ylabel ("amplitude");
legend("y = matchedFilter(u(t))", "y = u(t)", "Location", "southwest");

