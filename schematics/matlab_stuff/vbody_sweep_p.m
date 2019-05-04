data = csvread('pmos_vbody_sweep.csv')

len = data(:,1)
vth = data(:,2)

coefs = polyfit(len,vth,1);
coefs


plot(len,vth,'k-')

xlabel(' (nm)')
ylabel('Vth (mV)')
%ylim([0.61 0.632])
title('Vth vs Channel Length (nmos)')