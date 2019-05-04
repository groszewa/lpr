total_energy_data = csvread("new_total_energy_mod.csv")
delay_data = csvread("delays_new.csv")
static_data = csvread("p_static_mod.csv")
%total_energy_data = csvread("total_energy_mod2.csv")

%energy is in fJ

vdd    = total_energy_data(:,1)
e_tot  = total_energy_data(:,2)
delays = delay_data(:,2)
i_off = 3.5
p_stat = static_data(:,2)
e_stat = p_stat.*delays*1E20
%p_stat = static_power_data(:,2)
%p_dyn  = p_tot - p_stat

%plot(vdd,e_tot,'b-')
%hold on
plot(vdd,smooth(e_tot),'r-')
%plot(vdd,p_stat)
%plot(vdd,p_dyn)
xlabel('vdd (mV)')
ylabel('Energy (fJ)')
title('Energy vs Voltage (ajg3862)')
xlim([500 1200])
%ylim([0 5.5])
hold on
e_static = delays.*i_off*1E9/2.5
%plot(vdd,e_static)
plot(vdd,e_stat)
%legend('total power','static power','dynamic power','Location','northwest')
e_dynamic = smooth(e_tot) - e_static
e_dyn = smooth(e_tot) - e_stat
%plot(vdd,smooth(e_dynamic))
plot(vdd,smooth(e_dyn))
legend('Total','Leakage','Active','Location','northwest')


% vgs= data(:,1)
% ids = data(:,2)
% 
% vth = -0.4554
% 
% 
% 
% %a_model = fit(vgs_minus_vth,ids,'power1')
% my_model = 0.00932*(vgs-vth).^(1.509)
% 
% 
% plot(vgs,ids,'k*',vgs,my_model,'g-')
%  xlabel('Vgs (V)')
%  ylabel('Ids (A)')
%  legend('data points','0.00932*(Vgs+0.4554)^{1.509}','location','northeast')
%  title('Alpha power law model fit for PMOS device')
%  text(-0.85,1.4E-4,'R^2 = 0.9857')
% % 
%  r2 = 1- sum((real(ids-my_model)).^2)/sum((ids-mean(ids)).^2)
