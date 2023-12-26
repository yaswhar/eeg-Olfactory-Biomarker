function plv = PLVcalc(signal1, signal2,Fs,freqrange)
S1 = fft(signal1);
S2 = fft(signal2);
freqout = (0:length(S1)-1)*Fs/length(S1); % Frequency bins
freqind = freqout >= freqrange(1) & freqout <= freqrange(2); % Indices of frequencies within the specified range
phase1 = angle(S1);
phase2 = angle(S2);
phaseDiff = phase1-phase2;
plv = abs(mean(exp(1i*phaseDiff(freqind))));
end