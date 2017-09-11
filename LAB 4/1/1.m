[freq, psd] = PSD(4, randomArray(4), 1000);

figure(1);
plot(freq, psd);
ylabel("power spectral density");
xlabel("Frequency (Hz)");
xlim([-2, 2]);
print -dpng image.png
