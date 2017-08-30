resolution = 0.001;

first = ones(1/resolution,1);
first = first.*(2);

second = ones(1/resolution, 1);
second = second.*(-1);

third = ones((1/resolution)+1, 1);
third = third.*(-3);

signal = vertcat(first, second, third); % u(t)
time = [1:resolution:4];

signal_filtered = result(end:-1:1); % reversing magnitudes
time_filtered = time(end:-1:1).*(-1); %reverse and multiply my -1

plot(time, signal, time_filtered, signal_filtered);
title("u(t) = 2I[1,3](t) - 3I[2,4](t)");
xlabel ("time");
ylabel ("amplitude");
legend("y = u(t)", "y = matchedFilter(u(t))", "Location", "southwest");

