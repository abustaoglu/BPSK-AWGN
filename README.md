# BPSK-AWGN

BPSK Modulation 

Dual Phase Shift Keying (BPSK) is the type of digital modulation least affected by noise. 
Therefore, it is widely used in communication systems. BPSK is a digital modulation technique that sends one bit per symbol, ie '0' and '1'. 
The bitrate and symbol rate are the same. 180 degrees phase difference is used between the two carriers in order to be least affected by noise.

AWGN Channel

Since there is no amplitude and frequency change in BPSK modulation, the envelope sensor cannot be used. 
Since only the coherent demodulation method can be used for BPSK modulation, a sinusoidal signal locked to the carrier frequency and phase is required in the receiver. 
Then, the demodulation of the message signal is realized by passing this signal through the decision circuit.

Bit/Error Rate(biterr)

In this section, the bit / error ratio is calculated for 10 ^ 4 or more bits. After each decision circuit, the output bit is compared with 
the input bit and compared to the last total number of bits. 

In this section, the variation of error probability is observed depending on the SNR (Eb / No) ratio. Theoretically, the error rate calculation can be found with the Q function.


