% Combining two wave files and adding noise
% 
% 

% Alexandre R. Franco
% alexandre.franco@pucrs.br
% Oct 29th, 2014

close all;
clear all;

n = 0.3; % noise level

% Read wave files
fname1 = 'teste5_parte1.wav';
fname2 = 'teste5_parte2.wav';
[y1, Fs] = audioread(fname1);
[y2, Fs] = audioread(fname2);

% Combining vectors
y = [y1; y2];


t = 0:(1/Fs):(length(y)-1)/Fs;
figure 
plot(t,y)
title('without noise')
xlabel('time(s)')
ylabel('amplitude')

fname_out = 'teste5_total.wav';
audiowrite(fname_out, y, Fs)

% adding noise to file
y_noise = y + n*randn(size(y));

figure 
plot(t,y_noise)
title('with noise')
xlabel('time(s)')
ylabel('amplitude')

fname_out = 'teste6.wav';
audiowrite(fname_out, y_noise, Fs)

