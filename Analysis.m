close all;
clear all;

filename = 'BRIR_drums_90L_4m6.wav';

[BRIR, Fs] = audioread(filename);

BRIR_left = BRIR(:,1);
BRIR_right = BRIR(:,2);

% Calculate time vector
t = (0:length(BRIR_left)-1)/Fs;

% Plot waveform
figure;
subplot(2,1,1);
plot(t, BRIR_left);
xlabel('Time (s)');
ylabel('Amplitude');
title('Left Channel');
subplot(2,1,2);
plot(t, BRIR_right);
xlabel('Time (s)');
ylabel('Amplitude');
title('Right Channel');

% Plot waveform
figure;
plot(t, BRIR_left, 'b');
hold on;
plot(t, BRIR_right, 'r');
xlabel('Time (s)');
ylabel('Amplitude');
title('Left and Right Channel Waveforms');
legend('Left Channel', 'Right Channel');


% Calculate ITD
[max_corr, delay] = max(xcorr(BRIR_left, BRIR_right));
ITD = (delay - length(BRIR_left)) / Fs;
ITD = ITD * 1E-6;
% Calculate ILD
ILD = 20 * log10(sqrt(mean(BRIR_left .^ 2)) / sqrt(mean(BRIR_right .^ 2)));

disp(['ITD = ' num2str(ITD) ' us']);
disp(['ILD = ' num2str(ILD) ' dB']);


% Calculate timing and level of direct signal
[~, idx] = max(abs(BRIR_left));
t_direct = (idx - 1) / Fs;
level_direct = abs(BRIR_left(idx));


% Calculate timing and level of prominent early reflections
[~, idx] = findpeaks(abs(BRIR_left), 'SortStr', 'descend', 'NPeaks', 3);
t_early = (idx - 1) / Fs;
level_early = abs(BRIR_left(idx));

% Print timing and level of direct signal
disp(['Direct signal time: ' num2str(t_direct) ' s']);
disp(['Direct signal level: ' num2str(level_direct) ' Pa']);

% Print timing and level of prominent early reflections
disp('Early reflection times:');
for i = 1:length(t_early)
    disp(['  ' num2str(t_early(i)) ' s']);
end
disp('Early reflection levels:');
for i = 1:length(level_early)
    disp(['  ' num2str(level_early(i)) ' Pa']);
end