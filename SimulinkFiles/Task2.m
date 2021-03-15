clear all
close all
clc
snr_min = 0;
snr_max = 30;

snrcounter = 0;
%Selection Combining Theory AVG BER
M=2; % the number of receive antenna
ii=0;
for ave_gamma = 0:2:30 % average SNR at each antenna (dB), from 0 to 30
ii=ii+1;
ave_gamma= 10^(ave_gamma/10); % in the calculation we don't need dB
delta_gamma =1e-3; % step
my_gamma = delta_gamma:delta_gamma:1e4; % upper limit of integration is 1e4
my_BER=qfunc(sqrt(my_gamma)); % BER for QPSK given SNR
SD_pdf = M/ave_gamma*(1-exp(-my_gamma/ave_gamma)).^(M-1).*exp(-my_gamma/ave_gamma);
% pdf of SNR after SD
SD_BER(ii) = sum(delta_gamma*my_BER.*SD_pdf);
% do the integration, calculate average BER for QPSK with SD
end
% MRC Theoretical AVG BER
M=2; % the number of receive antenna
ii=0;
for ave_gamma= 0:2:30; % average SNR at each antenna (dB), from 0 to 30
ii=ii+1;
ave_gamma= 10^(ave_gamma/10); % in the calculation we don't need dB
delta_gamma=1e-3; % step
my_gamma= delta_gamma:delta_gamma:1e4; % upper limit of integration is 1e4
my_BER=qfunc(sqrt(my_gamma)); % BER for QPSK given SNR
MRC_pdf= (my_gamma.^(M-1)).*exp(-my_gamma/ave_gamma)/(ave_gamma^M*factorial(M-1));
% pdf of SNR after MRC
MRC_BER(ii) = sum(delta_gamma*my_BER.*MRC_pdf);
% do the integration, calculate average BER for QPSK with MRC
end

snrcounter = 1;
SNR = 0 : 2: 30;
for s = 0 : 2 : 30
    sim('QPSK_Rayleigh_SIMO_SD',0.1);
    sim('QPSK_Rayleigh_SIMO_MRC',0.1);
    BER_MRC(snrcounter) = Error_MRC(1);
    BER_SC(snrcounter) = Error_SC(1);
    snrcounter = snrcounter + 1; 
 
end
figure;
semilogy(SNR,SD_BER,'r-');
axis([snr_min snr_max 1e-7 1]);
hold on
semilogy(SNR,MRC_BER,'b-');
semilogy(SNR,BER_SC,'r*');
semilogy(SNR,BER_MRC,'b*');
grid on
box on

legend('Theoretical SC BER','Theoretical MRC BER','Simulink Simulated SC BER','Simulink Simulated MRC BER');
xlabel('Average SNR (dB)')
ylabel('Bit Error Rate')
title("BER vs Average SNR for QPSK MRC/SC Schemes")