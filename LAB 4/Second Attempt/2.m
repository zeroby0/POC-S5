numberOfSamplesTaken = 100;
sampleSize = 100;

[freq, psd] = PSD(randomArray(4), sampleSize);

average_psd = psd./numberOfSamplesTaken;

for i = 1:(numberOfSamplesTaken - 1)
	[freq, psd] = PSD(randomArray(4), sampleSize);
	average_psd = average_psd + psd./numberOfSamplesTaken;
end

plot(freq, average_psd);
ylabel("Power Spectral Density");
xlabel("Frequency (KHz)");
title(cstrcat("Power Spectral Density taken for ", int2str(numberOfSamplesTaken), " samples"));
xlim([-2,2]);
grid();
print -dpng mean_psd.png;
