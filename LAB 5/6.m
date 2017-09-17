RC = 0.383
% RC = 0.1
% RC = 3

% Get AM Signal
[tAM, uAM] = getAM();

% figure(1);
	subplot(4, 1, 1)
	plot(tAM, uAM);

	title("AM Signal");

	ylabel("Magnitude");
	xlabel("T (milli Seconds)");

% print -dpng 6_a.png

% Pass through diode filter

filtered_t_AM = tAM;
filtered_u_AM = diodeFilter(uAM);

% figure(2);
	subplot(4, 1, 2);
	plot(filtered_t_AM, filtered_u_AM);

	title("AM after passing through idealized diode");

	ylabel("Magnitude");
	xlabel("T (milli Seconds)");

% print -dpng 6_b.png


[RCfilt_t_AM, RCfilt_u_AM] = RCfilter(filtered_t_AM, filtered_u_AM, RC);

% figure(3);
	subplot(4, 1, 3)
	plot(RCfilt_t_AM, RCfilt_u_AM);

	title("After RC filter");

	xlabel("T (milli Seconds)");
	ylabel("Magnitude");

% print -dpng 6_c.png

[dcblock_t_AM, dcblock_u_AM] = DCblock(RCfilt_t_AM, RCfilt_u_AM);

% figure(4);
	subplot(4, 1, 4);
	plot(dcblock_t_AM, dcblock_u_AM);

	title("DC blocked");

	xlabel("T (milli Seconds)");
	ylabel("Magnitude")

print -dpng 6.png