%% NATALIE BROOKS
% ENEE222 - Elements of Discrete Signal Analysis
% Laboratory 07
%      { -sin(pi*t/2)+1  , for t in [0,1)
%      s(t) = { -(t-2)^5     , for t in [1,3)
%      { sin(pi*t/2)-1  , for t in [3,4)
N = 512;
t1 = [0:4/N:1-4/N];
t2 = [1:4/N:3-4/N];
t3 = [3:4/N:4-4/N];t = [t1 t2 t3];
s1 = sin(pi*t1/2)+1;

s2 = -(t2-2).^5;
s3 = sin(pi*t3/2)-1;
s = [s1 s2 s3].';
V = nhaar222(512);
c = V'*s;

clf

subplot(2,2,1);
plot(t, s,'r');
title('Signal Vector');
axis([0 4 -1.2 1.2]);
hold on;

subplot(2,2,2);
plot(t, c(1)*V(:,1));
title(['Approximation By(Scale 0)']);
axis([0 4 -1.2 1.2]);

subplot(2,2,[3,4]);
plot(t, s,'r');
hold on;
plot(t, c(1)*V(:,1));
hold off;
title('Initial Plot');

pause
I = [1];
for k = 1:round(log2(N))-2;
    J = [2^(k-1)+1 : 2^k] ;
    I = [I J] ;
    c1 = c.*ismember((1:N)',J) ;
    cI = c.*ismember((1:N)',I) ;
    
    subplot(2,2,1);
    plot(t, s, 'r', t, V*cI);
    title(['Approximation By Scales 0 - ' int2str(k)]);
    axis([0 4 -1.2 1.2]);d
    
    subplot(2,2,2);
    plot(t, V*c1);    
    title(['Approximation By Scale ' int2str(k) ' Only']);
    axis([0 4 -1.2 1.2]);
   %iv
    A = norm(s - V*cI)/norm(s);
    pause
end
clf