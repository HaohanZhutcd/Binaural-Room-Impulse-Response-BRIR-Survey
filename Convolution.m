close all;
clear all;

[brir, Fs] = audioread('BRIR_drums_0degree_2m.wav');

BRIRL = brir(:,1);
BRIRR = brir(:,2);

[audio, ~] = audioread('drum_0degree_2m.wav');

audioL = audio(:,1);
audioR = audio(:,2);

[ori, ~] = audioread('drydrums.wav');

oriL = ori(:,1);
oriR = ori(:,2);

convolved_left = conv(oriL, BRIRL);
convolved_right = conv(oriR, BRIRR);

wetDryMix = 0.5; % Example wet/dry mix value
convolved = (wetDryMix * [convolved_left, convolved_right]) + ((1-wetDryMix) * audio);

audiowrite('BRIR_drums_0degree_2m_convoled.wav', convolued, fs);