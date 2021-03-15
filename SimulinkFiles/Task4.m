clear all
close all
clc
snr_min = 0;
snr_max = 30;


SNR = 0 : 2: 30;
snrcounter = 1;
%Scenario 3
for s = 0 : 2 : 30
    sim('QPSK_OFDM_Rayleigh',3);

    BER(snrcounter) = ErrorVec(1);
    snrcounter = snrcounter + 1; 
 
end

%Scenario 4
% D_array = 1e-5*[0.5:0.5:5];
% for d = 1e-5*(0.5:0.5:5)
%     sim('PSK8_OFDM_Rayleigh',10);
%     BER(snrcounter) = ErrorVec(1);
%     snrcounter = snrcounter + 1;
% end
%     
figure;
semilogy(SNR,BER,'r*');
axis([ snr_min snr_max 1e-4 1]);
hold on

grid on
box on

legend('Simulink Simulated BER OFDM');
xlabel(' Avg SNR (dB)')
ylabel('Bit Error Rate')
title("BER vs Average SNR for QPSK OFDM Modulation")