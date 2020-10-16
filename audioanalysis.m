

% Loading the chirp.mat file.
load chirp
N = length(chirp);
n = 1:N;

% Delaying of the original chirp file.
delchirp = [0 chirp(1:N-1)];
z = chirp .* delchirp; %x*y<0
signchanges = z < 0;
no_halfcycles = cumsum(signchanges);

% Plot of no_halfcycles versus n
figure;
plot(no_halfcycles, n)
xlabel 'n'
ylabel 'no halfcycles'
title 'Plot of Number of Halfcycles against n'
grid

% Our X and Y expressions for use with the polyfit function.
Y = (no_halfcycles)./(2*n);
X = n/N;
figure;
plot(Y, n);
xlabel 'n'
ylabel 'Y'
title 'Plot of n against Y'
grid

%    a : (max+min)/2  - or more robustly: average of values over an 
%         entire (peak-to-peak) period
% 
%     b : (max - min)/2
%     
%     c : frequency parameter, use the distance (in number of samples) 
%         between two peaks on the graph. You can do this by zooming 
%         into segments containing single peaks, by inspection. 
%         c = N/(difference between two peaks)
%     
%     d : figure out from number of samples ahead of, or behind, 
%         the first peak (say k). 
%         i.e. d =  -(2*pi)*k/(difference between two peaks)

a = Y(length(Y)/2:length(Y));
b = X(length(X)/2:length(X));
constants = polyfit(b,a,2);
disp(constants);
%d =  -(2*pi)*k/(difference between two peaks)

my_v = n.*(0.0103+(-0.0119)*cos(2*pi*(0.1029)*(X)+0.1)); %v = n.* (a + b*cos(2*pi*c*(n/N) + d)) + w ;

my_chirp = cos(2*pi*my_v);
save Brooks_LABHW_04 my_chirp
