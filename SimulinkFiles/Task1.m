clear all
close all
clc
snr_min = 0;
snr_max = 30;

snrcounter = 0;
for snrdB = snr_min: 0.1 : snr_max
    avg_SNR = 10^(snrdB/10);
    snrcounter = snrcounter + 1;
    Pb(snrcounter) = (1/2)*(1-sqrt(avg_SNR/(2+avg_SNR)));
    SNR_Values(snrcounter) = snrdB;
end
[v,T,vT]=xlsread('SimulinkProjectData.xlsx');
t = v(:,1);
y = v(:,2);

figure
semilogy(SNR_Values,Pb,'-')
axis([snr_min snr_max 1e-4 1]);
hold on
semilogy(t,y, '*');
grid on
box on
legend('Theoretical expression','Simulink Simulated System');
xlabel('Average SNR (dB)')
ylabel('Bit Error Rate')
title("BER vs Average SNR for QPSK Rayleigh Fading")