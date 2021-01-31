clc;
clear all;
close all;
% define transmitted signal contain random binary bits
number=10; % number of bits
b_input = randi([0, 1], [1, number]); %getting random 0's and 1's
tb=100; %period of bits fb=1/tb
snr_db=0:10;
snr=10.^(snr_db./10);
nrz=[];
E=1^2*tb/2;
% encoding ones and zeros****
for (i=1:number)
    if (b_input(i)==0) % generating array's amplitude*****
         nrz(i)=-1; %amplitude for 0's
        else
        nrz(i)=1; %amplitude for 1's
         end
end
k=1; 
y=[]; 
t1=0:0.01:number; %time parameter
for i=1:length(t1)   % **time parameter is a an array so it has length.   
    if t1(i)<=k      % **t1 array starts from 0 and go to 10. also step range 0.01    
        y(i)=nrz(k); 
   % creating square wave process
    else
       k=k+1;
        y(i)=nrz(k);
   end
end
% plotting nrz square wave
subplot(2,2,1);
plot(t1,y,'linewidth',3);
grid on;
title('NRZ message signal    ');
xlabel('time(seconds)            ');
ylabel('amplitude(volt)');
% define carrier
ac=1; %amplitude of carrier signal
fc=100;  %frequeny of carrier
% **BPSK modulation
bpsk_mod=[];
phase_1 = 0; %**phase for 1's
phase_2 = pi; %**phase for 0's
z=1;
t3=0.0001:0.0001:0.01; %time parameter
for (z=1:number) % modulating 100Hz freq carrier 
    if (nrz(z)==1)
        bpsk_mod_temp=ac*cos(2*pi*fc*t3+phase_1);
    else
        bpsk_mod_temp=ac*cos(2*pi*fc*t3+phase_2); % 180 degree phase for 0's
    end
    bpsk_mod=[bpsk_mod bpsk_mod_temp]; 
end
t4=0.01:0.01:10;
subplot(2,2,2);
plot(t4,bpsk_mod,'linewidth',1);
grid on;
xlabel('time(seconds)             ');
ylabel('amplitude(volt)');
title('Output of the BPSK modulation');
%%noise generation
for j=1:length(snr_db)
    sigma=sqrt(E/(2*snr(j)));
    n_noise=sigma*randn(size(bpsk_mod));%random noise
    yp=double(bpsk_mod>0);
    noisy=bpsk_mod+n_noise;%noisy signal at receiver ***r(t)=y(t)+n(t)
    yz=double(noisy>0);
   end
subplot(2,2,3);
plot(t4,noisy,'linewidth',1);
grid on;
xlabel('time(seconds)             ');
ylabel('amplitude(volt)');
title('Output of the BPSK modulation with awgn');
%%demodulation process***
ac=1; %amplitude of carrier signal
fc=100;  %frequeny of carrier
carr=cos(2*pi*fc*t3);
y_demod=[];
n=100;
for n=100:n:length(noisy)
    y_demod0=ac*carr.*yz(n-99:n);%%multiplying modulated signal by same carrier
    tr=trapz(y_demod0);%%integrated [cos X cos]
    amp=round((tr/10));%%generating amplitude
   if(amp>1/2)
        amp_0=1;
    else
        amp_0=0;
    end
    y_demod=[y_demod amp_0];
end
k=1;
for i=1:length(t1)   % **time parameter is a an array so it has length.
    if t1(i)<=k      % **t1 array starts from 0 and go to 10. also step range 0.01    
        yk(i)=y_demod(k); 
   % creating demodulated square wave process
    else
      k=k+1;
        yk(i)=y_demod(k);
   end
end
% plotting demodulated signal
subplot(2,2,4);
plot(t1,yk,'linewidth',3);
grid on;
title('demodulated message signal   ');
xlabel('time(seconds)            ');
ylabel('amplitude(volt)');