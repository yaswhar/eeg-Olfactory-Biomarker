%% Yashar Zafari Haqqi - 99106209
%% Pre- Processing
% load("Subject1.mat")
% load("Subject2.mat")
% sub1np = table2array(subject1);
% sub2np = table2array(subject2);
% sub1np=sub1np';
% sub2np=sub2np';
% save('s1np',"sub1np")
% save('s2np',"sub2np")
% start1 = 14;
% start2 = 16.4;
% Fs = 200;
% resttime = 8;
% stimulustime=2;
% restsamples=resttime*Fs;
% stimulussamples=stimulustime*Fs;
% totalsamples=restsamples+stimulussamples;
% epochsamples=1*Fs+stimulussamples;
% num_epochs = floor(length(EEG(1).data) / totalsamples);
% if num_epochs>120
%     num_epochs=120;
% end
% s1_p_epoched = zeros(19, epochsamples, num_epochs);
% for i = 0:num_epochs-1
%     start_idx = i * totalsamples + 7*Fs + 1;
%     end_idx = (i + 1) * totalsamples;
%     s1_p_epoched(:, :, i+1) = EEG(1).data(:, start_idx:end_idx);
% end
% s2_p_epoched = zeros(19, epochsamples, num_epochs);
% num_epochs = floor(length(EEG(1).data) / totalsamples);
% if num_epochs>120
%     num_epochs=120;
% end
% for i = 0:num_epochs-1
%     start_idx = i * totalsamples + 7*Fs + 1;
%     end_idx = (i + 1) * totalsamples;
%     s2_p_epoched(:, :, i+1) = EEG(2).data(:, start_idx:end_idx);
% end
% save('s1_epoched.m','s1_p_epoched');
% save('s2_epoched.m','s2_p_epoched');
% s1e=reshape(s1_p_epoched,19,600*120);
% s2e=reshape(s2_p_epoched,19,600*120);
% save('s1e.m','s1e')
% save('s2e.m','s2e')
load('s1_epoched.m','-mat')
load('s2_epoched.m','-mat')
save('s1_epoched.mat','s1_p_epoched');
save('s2_epoched.mat','s2_p_epoched');
noisy1=[1 15 40 45 61 66 68 86 89 90 92 93 94 100 102 117 119 120];
s1_p_epoched(:,:,noisy1)=[];
odorrr=normal(13).odor;
odor1=odorrr;
odor1(noisy1)=[];
noisy1=noisy1-1;
noisy2=2;
s2_p_epoched(:,:,noisy2)=[];
odor2=odorrr;
odor2(noisy2)=[];
noisy2=noisy2-1;
channels=[1 5 10 15];
subjects=struct('epoch',{s1_p_epoched(channels,:,:); s2_p_epoched(channels,:,:)},'odor',{odor1;odor2},'noisy',{noisy1;noisy2});
save('subjects.m',"subjects")
%% PLV
%function plv = PLVcalc(signal1, signal2,Fs,freqrange)
S1 = fft(signal1);
S2 = fft(signal2);
freqout = (0:length(S1)-1)*Fs/length(S1); % Frequency bins
freqind = freqout >= freqrange(1) & freqout <= freqrange(2); % Indices of frequencies within the specified range
phase1 = angle(S1);
phase2 = angle(S2);
phaseDiff = phase1-phase2;
plv = abs(mean(exp(1i*phaseDiff(freqind))));
%end
%% Processing
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
phasenDiff = phasen1-phasen2;
%
T1 = fft(AD(2).epoch(2,:,AD(2).odor==0));
T2 = fft(AD(2).epoch(3,:,AD(2).odor==0));
freqout = (0:length(T1)-1)*Fs/length(T1); % Frequency bins
freqind = freqout >= freqrange(1) & freqout <= freqrange(2);
phaseAD1 = angle(T1);
phaseAD2 = angle(T2);
phaseADDiff = phaseAD1-phaseAD2;
subplot(1,2,1)
polarhistogram(phasenDiff)
title('Polar Histogram Phase Difference of  No.7 Normal Frequent')
subplot(1,2,2)
polarhistogram(phaseADDiff)
title('Polar Histogram Phase Difference of  No.2 AD Frequent')
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
%% Heatmap
xnames={'Fp1-Fz Freq','Fp1-Fz Rare','Fp1-Cz Freq','Fp1-Cz Rare','Fp1-Pz Freq','Fp1-Pz Rare','Fz-Cz Freq','Fz-Cz Rare','Fz-Pz Freq','Fz-Pz Rare','Cz-Pz Freq','Cz-Pz Rare'};
ynamesnorm=string(1:numNormal);
ynamesAD=string(1:numAD);
for i=1:numNormal
    nor(i,1)=PLVcalc(normal(i).epoch(1,:,normal(i).odor==0),normal(i).epoch(2,:,normal(i).odor==0),200,freqrange);
    nor(i,3)=PLVcalc(normal(i).epoch(1,:,normal(i).odor==0),normal(i).epoch(3,:,normal(i).odor==0),200,freqrange);
    nor(i,5)=PLVcalc(normal(i).epoch(1,:,normal(i).odor==0),normal(i).epoch(4,:,normal(i).odor==0),200,freqrange);
    nor(i,7)=PLVcalc(normal(i).epoch(2,:,normal(i).odor==0),normal(i).epoch(3,:,normal(i).odor==0),200,freqrange);
    nor(i,9)=PLVcalc(normal(i).epoch(2,:,normal(i).odor==0),normal(i).epoch(4,:,normal(i).odor==0),200,freqrange);
    nor(i,11)=PLVcalc(normal(i).epoch(3,:,normal(i).odor==0),normal(i).epoch(4,:,normal(i).odor==0),200,freqrange);
    nor(i,2)=PLVcalc(normal(i).epoch(1,:,normal(i).odor==1),normal(i).epoch(2,:,normal(i).odor==1),200,freqrange);
    nor(i,4)=PLVcalc(normal(i).epoch(1,:,normal(i).odor==1),normal(i).epoch(3,:,normal(i).odor==1),200,freqrange);
    nor(i,6)=PLVcalc(normal(i).epoch(1,:,normal(i).odor==1),normal(i).epoch(4,:,normal(i).odor==1),200,freqrange);
    nor(i,8)=PLVcalc(normal(i).epoch(2,:,normal(i).odor==1),normal(i).epoch(3,:,normal(i).odor==1),200,freqrange);
    nor(i,10)=PLVcalc(normal(i).epoch(2,:,normal(i).odor==1),normal(i).epoch(4,:,normal(i).odor==1),200,freqrange);
    nor(i,12)=PLVcalc(normal(i).epoch(3,:,normal(i).odor==1),normal(i).epoch(4,:,normal(i).odor==1),200,freqrange);
end
for i=1:numAD
    aad(i,1)=PLVcalc(AD(i).epoch(1,:,AD(i).odor==0),AD(i).epoch(2,:,AD(i).odor==0),200,freqrange);
    aad(i,3)=PLVcalc(AD(i).epoch(1,:,AD(i).odor==0),AD(i).epoch(3,:,AD(i).odor==0),200,freqrange);
    aad(i,5)=PLVcalc(AD(i).epoch(1,:,AD(i).odor==0),AD(i).epoch(4,:,AD(i).odor==0),200,freqrange);
    aad(i,7)=PLVcalc(AD(i).epoch(2,:,AD(i).odor==0),AD(i).epoch(3,:,AD(i).odor==0),200,freqrange);
    aad(i,9)=PLVcalc(AD(i).epoch(2,:,AD(i).odor==0),AD(i).epoch(4,:,AD(i).odor==0),200,freqrange);
    aad(i,11)=PLVcalc(AD(i).epoch(3,:,AD(i).odor==0),AD(i).epoch(4,:,AD(i).odor==0),200,freqrange);
    aad(i,2)=PLVcalc(AD(i).epoch(1,:,AD(i).odor==1),AD(i).epoch(2,:,AD(i).odor==1),200,freqrange);
    aad(i,4)=PLVcalc(AD(i).epoch(1,:,AD(i).odor==1),AD(i).epoch(3,:,AD(i).odor==1),200,freqrange);
    aad(i,6)=PLVcalc(AD(i).epoch(1,:,AD(i).odor==1),AD(i).epoch(4,:,AD(i).odor==1),200,freqrange);
    aad(i,8)=PLVcalc(AD(i).epoch(2,:,AD(i).odor==1),AD(i).epoch(3,:,AD(i).odor==1),200,freqrange);
    aad(i,10)=PLVcalc(AD(i).epoch(2,:,AD(i).odor==1),AD(i).epoch(4,:,AD(i).odor==1),200,freqrange);
    aad(i,12)=PLVcalc(AD(i).epoch(3,:,AD(i).odor==1),AD(i).epoch(4,:,AD(i).odor==1),200,freqrange);
end
subplot(1,2,1)
heatNorm=heatmap(xnames,ynamesnorm,nor);
title('HeatMap of Normal')
subplot(1,2,2)
heatAD=heatmap(xnames,ynamesAD,aad);
title('HeatMap of AD')

