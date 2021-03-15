clear all
close all
clc
snr_min = 0;
snr_max = 30;

%code for task 3 - scenario 3
d = [100 1000 5000 10000 15000 20000 25000 30000];
dcounter = 1;
% for i = 1 : length(d)
%     Ds = d(i);
%     disp(Ds);
%     sim('QPSK_Rayleigh_differential_coding',0.1);
%     BER(dcounter) = ErrorVec(1);
%     dcounter = dcounter+1;
% end
dlog = log10(d);
% For scenario 1 and 2 plotting
SNR = 0 : 2: 30;
snrcounter = 1;
for s = 0 : 2 : 30
    sim('QPSK_Rayleigh_differential_coding',0.1);

    BER(snrcounter) = ErrorVec(1);
    snrcounter = snrcounter + 1; 
 
end
figure;
semilogy(SNR,BER,'r*');
axis([ snr_min snr_max 1e-4 1]);
hold on
grid on
box on

legend('Simulink Simulated MRC BER');
xlabel('Doppler Frequency (hz)')
ylabel('Bit Error Rate')
title("BER vs Average SNR for QPSK Differential Encoding")