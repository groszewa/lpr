data = csvread('q1_len_vs_vth.csv')

len = data(:,1)
vth = data(:,2)


plot(len,vth,'k-')

xlabel('Channel Length (nm)')
ylabel('Vth (mV)')
ylim([0.61 0.632])
title('Vth vs Channel Length (nmos)')