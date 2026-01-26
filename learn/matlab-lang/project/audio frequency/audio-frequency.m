% sample frequency
fs = 10
t = 0:1/fs:20;

% sum of sine waves with similar frequences, interference, 
% *beat* pattern
y = sin(1.8 * 2 * pi * t) + sin(2.1 * 2 * pi * t);
plot(t, y);

yfft = fft(y);
% number of elements of y
n = numel(y);
% frequences
f = 0:fs/n:fs*(n-1)/n;
% plot fft magnitude with abs, fft values are complex number
plot(f, abs(yfft));

% Nyquist frequency