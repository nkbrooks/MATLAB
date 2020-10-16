

%loading file
file = 'audio09.wav'
[l, Fs] = audioread(file);
N = length(l)
Fs
Y = fft(y);
n = (0:N-1).';


k = n;
    dt = 1/Fs;
    t = 0:dt:(length(y)*dt)-dt;
%i
figure(1);
subplot(2,2,1);
plot(t,Y);
title('Plot of AM signal (i)');

%ii
subplot(2,2,2);
plot(k, abs(Y))
title 'Magnitude of DFT Y (ii)'
xlabel 'k values'
ylabel 'Y Magnitudes'
grid

% N = 53835 and Fs = 16000

%iii
K = 43420;
% K was found by the location of the highest peak which was 43420.

Y = Y(1:53835);
Y = [Y;zeros(53835,1)];
X = circshift(Y, -K);
g = real(ifft(X));

%iv
soundsc(g, Fs)
audioread(g, Fs, 'brooks_labhw_09.wav');

%plot for iii
subplot(2,2,3);
plot(k, abs(X))
title 'Magnitude of DFT X (iii)'
xlabel 'K values'
ylabel 'X Magnitudes'
grid


