total_power_data = csvread("inv_chain_total_power_new.csv")
static_power_data = csvread("inv_chain_static_power_new.csv")

vdd    = total_power_data(:,1)
p_tot  = total_power_data(:,2)
p_stat = static_power_data(:,2)
p_dyn  = p_tot - p_stat

plot(vdd,p_tot)
hold on
plot(vdd,p_stat)
plot(vdd,p_dyn)
xlabel('vdd (V)')
ylabel('Power (pW)')
title('Power vs Voltage (ajg3862)')
legend('total power','static power','dynamic power','Location','northwest')

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
