%% DTMF decode

%%
clear all;
close all;

[y fs] = wavread('TESTE4_9d8P7d6P5d4P3d2P1d0_100ms.wav');
plot(y);

tsamp = 0.03;
t = linspace(0,tsamp,tsamp*fs+1);
M = length(t);
N = floor(length(y)/M);
ys = reshape(y(1:(N*M)),M,N);

%%

%pause

fL = [697 770 852 941];
fH = [1209 1336 1477 1633];
omega = 2*pi*fL';
w = exp(1j*omega*t);
yL = abs(w*ys)/M;
plot(yL');

%%
%pause

omega = 2*pi*fH';
w = exp(1j*omega*t);
yH = abs(w*ys)/M;
plot(yH');

%%
%pause

ndx = 1:4;
y1 = ndx*(yL>0.07);
subplot(2,1,1);
plot(y1);
ylabel('low freq index');
subplot(2,1,2);
y2 = ndx*(yH>0.07);
plot(y2);
ylabel('high freq index');

%%
%pause

% look for zero to positive differences
% and then a few samples later
ndx = find(diff(y1)>0);
ndx = find(diff([0 y1])>0);
n1 = y1(ndx+2);
n2 = y2(ndx+2);

n1 = y1(ndx);
n2 = y2(ndx);

[n1' n2']

%%
%pause

key = ['147*'; '2580'; '369#'; 'ABCD'];

for k=1:length(n1)
    pn(k) =key(n2(k),n1(k));
end
disp('phone number:');
disp(pn);



