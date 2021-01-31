clc;
clear all;
close all;
% define transmitted signal contain random binary bits
number=10^5; % number of bits
b_input = randi([0, 1], [1, number]); %getting random 0's and 1's
tb=100; %period of bits fb=1/tb
snr_db=0:8;
snr=10.^(snr_db./10);
nrz=[];
E=1^2*tb/2;
% encoding ones and zeros***
for (i=1:number)
    if (b_input(i)==0) % generating array's amplitude*****
         nrz(i)=-1; %amplitude for 0's
        else
        nrz(i)=1; %amplitude for 1's
         end
end
% define carrier
ac=1; %amplitude of carrier signal
fc=100;  %frequeny of carrier
% **BPSK modulation
bpsk_mod=[];
phase_1 = 0; %**phase for 1's
phase_2 = pi; %**phase for 0's
t3=0.0001:0.0001:0.01; %time parameter
for (z=1:number) % modulating 100Hz freq carrier 
    if (nrz(z)==1)
        bpsk_mod_temp=ac*cos(2*pi*fc*t3+phase_1);
    else
        bpsk_mod_temp=ac*cos(2*pi*fc*t3+phase_2); % 180 degree phase for 0's
    end
    bpsk_mod=[bpsk_mod bpsk_mod_temp];
    yb=double(bpsk_mod>0);
    end
y_demod=[];
%%noise generation
for j=1:length(snr_db)
    sigma=sqrt(E/(2*snr(j)));
    n_noise=sigma*randn(size(yb));%random noise
    noisy=bpsk_mod+n_noise; %noisy signal at receiver ***r(t)=y(t)+n(t)
    yz=double(noisy>0);
    n=100;
        %%demodulation process***
        for n=100:n:length(bpsk_mod)
        t4=0.0001:0.0001:0.01;
        ac=1; %amplitude of carrier signal
        fc=100;  %frequeny of carrier
        carr=cos(2*pi*fc*t4);
        y_demod0=ac*carr.*noisy(n-99:n);     %%multiplying modulated signal by same carrier
        tr=trapz(y_demod0);   %%integrated [cos X cos]
        amp=round((tr/10)); %%generating amplitude
                   if(amp>1/2)
                        amp_0=1;
                   else
                          amp_0=0;
                   end
                         y_demod=[y_demod amp_0];
                         
        end
        x_out=y_demod;
        y_demod=[];
        [num(j),ratio(j)]=biterr(b_input,x_out);%calculating ber
        Ph(j)=0.5*erfc(sqrt(2*snr(j))/sqrt(2));%theorical ber
 end
semilogy(snr_db,ratio,'r*');%simulation
hold
semilogy(snr_db,Ph);%theorical
xlabel('SNR');ylabel('P(h)');
legend('simulation','theorical');