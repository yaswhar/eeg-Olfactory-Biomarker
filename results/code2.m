load('AD.mat')
load('Normal.mat')
Fs=200;
numNormal=length(normal);
numAD=length(AD);
freqrange=[35 40];
normplv=[];
ADplv=[];
for i=1:numNormal
    norraremplv(i)=PLVcalc(normal(i).epoch(2,:,normal(i).odor==1),normal(i).epoch(3,:,normal(i).odor==1),200,freqrange);
    norfreqmplv(i)=PLVcalc(normal(i).epoch(2,:,normal(i).odor==0),normal(i).epoch(3,:,normal(i).odor==0),200,freqrange);
end
for i=1:numAD
    ADrareplv(i)=PLVcalc(AD(i).epoch(2,:,AD(i).odor==1),AD(i).epoch(3,:,AD(i).odor==1),200,freqrange);
    ADfreqplv(i)=PLVcalc(AD(i).epoch(2,:,AD(i).odor==0),AD(i).epoch(3,:,AD(i).odor==0),200,freqrange);
end
%% Box Plot
subplot(2,2,1)
boxplot(norfreqmplv);
title('Normal Frequent Odor PLV');
subplot(2,2,2)
boxplot(norraremplv);
title('Normal Rare Odor PLV');
subplot(2,2,3)
boxplot(ADfreqplv)
title('AD Frequent Odor PLV')
subplot(2,2,4)
boxplot(ADrareplv)
title('AD Rare Odor PLV')
%% Gaussian Fit
xdist=-1:0.01:2;
subplot(2,2,1)
pdnorfreq=fitdist(norfreqmplv','Normal');
ynorfreq = pdf(pdnorfreq,xdist);
plot(xdist,ynorfreq)
title('Normal Frequent Odor Gaussian Fit');
subplot(2,2,2)
pdnorrare=fitdist(norraremplv','Normal');
ynorrare = pdf(pdnorrare,xdist);
plot(xdist,ynorrare)
title('Normal Rare Odor Gaussian Fit');
subplot(2,2,3)
pdADfreq=fitdist(ADfreqplv','Normal');
yADfreq = pdf(pdADfreq,xdist);
plot(xdist,yADfreq)
title('AD Frequent Odor Gaussian Fit');
subplot(2,2,4)
pdADrare=fitdist(ADrareplv','Normal');
yADrare = pdf(pdADrare,xdist);
plot(xdist,yADrare)
title('AD Rare Odor Gaussian Fit');
[~,pvalnor]=ttest2(norfreqmplv,norraremplv);
[~,pvalAD]=ttest2(ADfreqplv,ADrareplv);
%% Polar Histogram
S1 = fft(normal(7).epoch(2,:,normal(7).odor==0));
S2 = fft(normal(7).epoch(3,:,normal(7).odor==0));
freqout = (0:length(S1)-1)*Fs/length(S1); % Frequency bins
freqind = freqout >= freqrange(1) & freqout <= freqrange(2);
phasen1 = angle(S1);
phasen2 = angle(S2);
ph=phasen1-phasen2;
phasenDiff = ph(freqind);
%
freqind=[];
freqout=[];
ph=[];
T1 = fft(AD(2).epoch(2,:,AD(2).odor==0));
T2 = fft(AD(2).epoch(3,:,AD(2).odor==0));
freqout = (0:length(T1)-1)*Fs/length(T1); % Frequency bins
freqind = freqout >= freqrange(1) & freqout <= freqrange(2);
phaseAD1 = angle(T1);
phaseAD2 = angle(T2);
ph=phaseAD1-phaseAD2;
phaseADDiff = ph(freqind);
subplot(1,2,1)
polarhistogram(phasenDiff)
title('Polar Histogram Phase Difference of  No.7 Normal Frequent')
subplot(1,2,2)
polarhistogram(phaseADDiff)
title('Polar Histogram Phase Difference of  No.2 AD Frequent')
freqind=[];
freqout=[];
ph=[];
%% Mean Polar Histogram
for i=1:numNormal
    freqind=[];
freqout=[];
ph=[];
    S1 = fft(normal(i).epoch(2,:,normal(i).odor==0));
S2 = fft(normal(i).epoch(3,:,normal(i).odor==0));
freqout = (0:length(S1)-1)*Fs/length(S1); % Frequency bins
freqind = freqout >= freqrange(1) & freqout <= freqrange(2);
phasenn1 = angle(S1);
phasenn2 = angle(S2);
ph = phasenn1-phasenn2;
phasenDif(i,:,:) = ph(freqind);
end
phasend=mean(phasenDif);
for i=1:numAD
    freqind=[];
freqout=[];
ph=[];
    T1 = fft(AD(i).epoch(2,:,AD(i).odor==0));
T2 = fft(AD(i).epoch(3,:,AD(i).odor==0));
freqout = (0:length(T1)-1)*Fs/length(T1); % Frequency bins
freqind = freqout >= freqrange(1) & freqout <= freqrange(2);
phaseeAD1 = angle(T1);
phaseeAD2 = angle(T2);
ph=phaseeAD1-phaseeAD2;
phaseADDif(i,:,:) = ph(freqind);
end
phaseADd=mean(phaseADDif);
figure
subplot(1,2,1)
polarhistogram(phasend)
title('Polar Histogram Mean Phase Difference of Normal Frequent')
subplot(1,2,2)
polarhistogram(phaseADd)
title('Polar Histogram Mean Phase Difference of AD Frequent')