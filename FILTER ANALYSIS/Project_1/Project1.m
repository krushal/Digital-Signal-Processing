%% MATLAB PROJECT 1,PROBLEM 1 : FILTER ANALYSIS

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
%% Generating transfer function
clc

syms z;
h1 = tf([ 1  -0.98*(exp(1i* 0.8*pi))],[ 1  -0.8*(exp(1i* 0.4*pi))],0.1,'variable','z^-1');
h2 = tf([ 1  -0.98*(exp(-1i* 0.8*pi))],[ 1  -0.8*(exp(-1i* 0.4*pi))],0.1,'variable','z^-1');

h= h1*h2;

E =1;

for k=1:4
    
    ck=0.95*exp(1i*((0.15*pi)+(0.02*pi*k)));
    cck=conj(ck);
    E1= tf([cck  -1],[ 1  -ck],0.1,'variable','z^-1');
    E2= tf([ck  -1],[ 1  -cck],0.1,'variable','z^-1');
    E= E*(E1*E2)^2   ;
    
end

H = (1/3.0955)*h*E;
%% pole zero plot for filter
pzmap(H);
figure(1);
pzmap(H);
%% frequency response
q=-pi:2*pi/300:pi;
[v,w] = freqz(real(H.Numerator{1,1}),real(H.Denominator{1,1}),'whole',q);
V=v';
figure(2);
plot(w,abs(V)) %magnitude response%

[grp,~]=grpdelay(real(H.Numerator{1,1}),real(H.Denominator{1,1}),q);

figure(3);
plot(grp); %group delay%
%% Generating input

M= 60;
w=0;
x1=0;
x2=0;
x3=0;
 
for i=1:60
    
    w= 0.54-(0.46*(cos((i*90)/60)));
    
    x1(i)=w*(cos(i*0.2*180));
    x2(i)=w*(cos((i*0.4*180)-(90)));
    x3(i)=w*(cos(i*0.8*180));

end 

for i=1:182
    
    A=i-M-1;
    B=i-2*M-2;
    disp(i);
    if i<60
       x(i)=x3(i) ;
    end
    if A>0 && A<60
       x(i)=x1(A);
    end   
    if B>0 && B<60
        x(i)=x2(B); 
    end
end

figure(5);
plot(x);
title('x(t) : input');
xlim([0 200])
ylim([-1 1])
grid on;
%% dft of input siganl
f = fft(x); 
figure(6);
m = abs(f);
f = (0:length(f)-1)*100/length(f);
plot(f,m);
%% calcualting output
q=iztrans(H);
y=conv(x,q);

plot(y);
title('y(t) : output');
