m = 16;
t = 1;
dt = 1/1000;
fc = 10/t;

[time, dsb] = DSB(randomArray(4), m, fc);

[U, freq_U, df_acquired] = contFT(dsb, time(1), 1/m, dt);

% Extracting one column from U
% U is a matrix with the same column repeated
% U = U(:, 1)';
psd = abs(U).^2.*(1/(4*dt));
freq_psd = freq_U;


plot(freq_psd, psd);
title("Power Spectral Density");
xlabel("Frequency (kHz)");
ylabel("Magnitude");
% xlim([-2, 2]);
print -dpng dsb_psd.png;