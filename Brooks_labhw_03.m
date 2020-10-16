%% Natalie Brooks
% ENEE222 - Elements of Discrete Signal Analysis
% Lab Assignment 3

S = [];
T = [];

for a = 0:0.0202:2 
    for b = 0:0.0202:2 
        
        c= a + j*b;
        vec = [0; 0; 1];
        vnew = 0;
%         output @ n=0 & n=1 are both zero
%         output @ n=2 is set to 1

        n = 3;
        while (abs(vnew) < 2001) && (length(vec) < 2000) %while loop
           
            vnew = a*vec(n) +0.25*vec(n-1) + b*vec(n-2);%output
            vec = [vec ; vnew];
            n = n+1;
        end
        if (n < 2001) && (abs(vnew) < 2001)
            S = [S ; c]; %appends to S vector
            
        else
            T = [T ; c]; %appends to T vector
   

        end
    end
end

figure;
plot(S, 'o')
xlabel 'Discrete Time'
ylabel 'Values'
title 'S Vector Plot'
hold on;
figure;
plot(T, '.')
xlabel 'Discrete Time'
ylabel 'Values'
title 'T Vector Plot'

figure; hold on
plot(T, '.')
plot(S, 'o')
xlabel 'Discrete Time'
ylabel 'Values'
title 'T and S Vector Plot'