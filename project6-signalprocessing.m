

% PART TWO-----------------------------------------------------------------
% Generating a square X-Y grid.
m = 500;
a = 0:1/m:1;
u = ones(size(a));
X = u.'*a;
Y = a.'*u;
imshow(X);
imshow(Y);
imshow(X<Y)
% Equation for a straight line.
W = -X > Y;
imshow(W);
% Equation for the curved line.

V = floor((X).^2 + (Y).^2);
B = sqrt((X.^2)/(Y/2)-1);
imshow(B);
% Equation for the figure
A = rot90(xor(W, V),4);
imshow(flipud(A));

%PART
%TWO-----------------------------------------------------------------------
% 
% Study the example in item 5 - Lab 06. Keeping this example in mind
%  think on how to create a 4x4 symmetric matrix.
% 
%  Compute the determinants of all 
%     4x4 symmetric matrices with entries 1 or -1, 
% and output:
% 
% 
% 
%         (i) Fraction of singular matrices
%      
%    
%        (ii) Average value of the determinant


c = 0 ;                          % initialize # singular matrices
		B = blanks(9) ;

		for i = 0:4^9-1
			S = dec2base(i,4,9) ;
			S = [S;B] ;
			S = S(:)' ;                   % 4-ary digits separated by spaces
			A = str2num(S) + 5 ;
			A = reshape(A,3,3) ;
			c = c + (abs(det(A))<0.5) ;  % compensate for round-off
		end
