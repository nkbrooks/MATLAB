N = 256;
t = -1:2/N:(1-2/N);
X = sin(abs(3*t))';
figure(1)
y1 = HAPPROX(X, 0.1);
figure(2)
y2 = HAPPROX(X, 0.05);
figure(3)
y3 = HAPPROX(X, 0.01);