[freq, psd] = PSD(4, randomArray(4), 1000);
numberOfSamplesTaken = 5000;
average_psd = psd./numberOfSamplesTaken;

for i = 1:(numberOfSamplesTaken - 1)
	[freq, psd] = PSD(4, randomArray(4), 1000);
	average_psd = average_psd + psd./numberOfSamplesTaken;
end

figure(1);
plot(freq, average_psd);
ylabel("Power Spectral Density");
xlabel("Frequency");
title("Power Spectral Density taken for 50000 samples");
xlim([-2,2]);
grid();
print -dpng image.png;
