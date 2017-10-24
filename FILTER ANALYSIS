%% MATLAB PROJECT 1,PROBLEM 2 : FILTER ANALYSIS

%% General Information
%
% Author: KRUSHAL KYADA
%
% Date Created: NOVEMBER 2016
%
% Context: EEEE678 DIGITAL SIGNAL PROCESSING
%
% Objective: This .m file is designed to analyze the characteristic of the
% given filter
% plotting data in MATLAB, as well as writing decent MATLAB code.

close all;
clear all;
clc;

%% given data

a = [1 -6.6814 21.8365 -45.7544 68.2005 -76.1361 65.4106 -43.8106 22.9357 -9.3222 2.8911 -0.6625 0.1059 -0.0106 0.0005];
G=1.91486834935659*(10^-7);

%% calculating value of b

N=15;
for i=1:N
    
    b(i)=G*(factorial(N-1)/(factorial(i-1)*factorial(N-i)));
    
end

%% generating transfer function 
H= tf([b],[a],0.1,'variable','z^-1')

%% using Filter Visualization Tool for characteristic of given filter
fvtool(b,a);

%% 3-dB cutoff frequency of the filter
fb = bandwidth(H) 

%% plotting frequency response
figure(2);
bode(H,{1,5000})
fs=10000;
t=0:1/fs:10e-3;

 %% checking stability

 flag = isstable(H) % 1 = stable
                    % 0 = Unstable
%% output signal for x(t)
x=1+cos(2*pi*10^3*t)+cos(6*pi*10^3*t);
figure(3);
plot(t,x);
title('x(t) : input');
grid on;

y=filter(b,a,x);
figure(4);
plot(t,y);
title('y(t)= output');
grid on;

%% ratio of the output signal power to the input signal power
output_power=abs(y).^2;
input_power=abs(x).^2;
power_ratio=output_power/input_power;
disp('The ratio of output power to inputp power = ');
disp(power_ratio);
