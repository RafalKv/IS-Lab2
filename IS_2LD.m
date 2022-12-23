clear all;
close all;

tic

%% Duomenys
x = [0.1:1/22:1];
y = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2;
plot (x,y, 'r*'); grid on

%% Sluoksniu svoriai
w11_1 = randn(1)*0.1;
w12_1 = randn(1)*0.1;
w13_1 = randn(1)*0.1;
w14_1 = randn(1)*0.1;
w15_1 = randn(1)*0.1;
b1_1 = randn(1)*0.1;
b2_1 = randn(1)*0.1;
b3_1 = randn(1)*0.1;
b4_1 = randn(1)*0.1;
b5_1 = randn(1)*0.1;


w11_2 = randn(1)*0.1;
w12_2 = randn(1)*0.1;
w13_2 = randn(1)*0.1;
w14_2 = randn(1)*0.1;
w15_2 = randn(1)*0.1;
b1_2 = randn(1)*0.1;

n = 0.15;

for i = 1:100000
    for j = 1:length(x)
        % Pirmasis sluoksnis
        v1_1 = x(j)*w11_1 + b1_1;
        v2_1 = x(j)*w12_1 + b2_1;
        v3_1 = x(j)*w13_1 + b3_1;
        v4_1 = x(j)*w14_1 + b4_1;
        v5_1 = x(j)*w15_1 + b5_1;
        
        % Aktyvavimo funkcija
        y1_1 = 1/(1+exp(-v1_1));
        y2_1 = 1/(1+exp(-v2_1));
        y3_1 = 1/(1+exp(-v3_1));
        y4_1 = 1/(1+exp(-v4_1));
        y5_1 = 1/(1+exp(-v5_1));
        
        % Antrasis sluoksnis
        v1_2 = y1_1*w11_2+y2_1*w12_2+y3_1*w13_2+y4_1*w14_2+y5_1*w15_2 + b1_2;
        
        % Aktyvavimo funkcija 
        y1_2 = tanh(v1_2);
        yy = y1_2;
        
        % Klaida
        e = y(j) - yy;
        
        % Isejimo neuronas
        delta1 = (1-(tanh(v1_2))^2)*e;
        
        % Klaidos gradientai
        delta11 = y1_1*(1-y1_1)*delta1*w11_2;
        delta12 = y2_1*(1-y2_1)*delta1*w12_2;
        delta13 = y3_1*(1-y3_1)*delta1*w13_2;
        delta14 = y4_1*(1-y4_1)*delta1*w14_2;
        delta15 = y5_1*(1-y5_1)*delta1*w15_2;
        
        % Isejimo neuronu svoriai
        w11_2 = w11_2 + n*delta1*y1_1;
        w12_2 = w12_2 + n*delta1*y2_1;
        w13_2 = w13_2 + n*delta1*y3_1;
        w14_2 = w14_2 + n*delta1*y4_1;
        w15_2 = w15_2 + n*delta1*y5_1;
        b1_2 = b1_2 + n*delta1;
        
        % Svoriu atnaujinimas
        w11_1 = w11_1 + n*delta11*x(j);
        w12_1 = w12_1 + n*delta12*x(j);
        w13_1 = w13_1 + n*delta13*x(j);
        w14_1 = w14_1 + n*delta14*x(j);
        w15_1 = w15_1 + n*delta15*x(j);
        b1_1 = b1_1 + n*delta11;
        b2_1 = b2_1 + n*delta12;
        b3_1 = b3_1 + n*delta13;
        b4_1 = b4_1 + n*delta14;
        b5_1 = b5_1 + n*delta15;
    end
end

x = [0.1:1/220:1];
Y = zeros(1, length(y));

for j=1:length(x)
    % Pirmasis sluoksnis
    v1_1 = x(j)*w11_1 + b1_1;
    v2_1 = x(j)*w12_1 + b2_1;
    v3_1 = x(j)*w13_1 + b3_1;
    v4_1 = x(j)*w14_1 + b4_1;
    v5_1 = x(j)*w15_1 + b5_1;
        
    % Aktyvavimo funkcija
    y1_1 = 1/(1+exp(-v1_1));
    y2_1 = 1/(1+exp(-v2_1));
    y3_1 = 1/(1+exp(-v3_1));
    y4_1 = 1/(1+exp(-v4_1));
    y5_1 = 1/(1+exp(-v5_1));
        
    % Antrasis sluoksnis
    v1_2 = y1_1*w11_2+y2_1*w12_2+y3_1*w13_2+y4_1*w14_2+y5_1*w15_2 + b1_2;
        
    % Aktyvavimo funkcija
    y1_2 = tanh(v1_2);
    yy = y1_2;
    Y(j) = yy;
end

hold on;
plot (x, Y, 'b*');
hold off;

toc