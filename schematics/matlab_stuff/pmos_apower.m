data = csvread("pmos_apower_new.csv")

vgs= data(:,1)
ids = data(:,2)

vth = -0.4554



%a_model = fit(vgs_minus_vth,ids,'power1')
my_model = 0.00932*(vgs-vth).^(1.509)


plot(vgs,ids,'k*',vgs,my_model,'g-')
 xlabel('Vgs (V)')
 ylabel('Ids (A)')
 legend('data points','0.00932*(Vgs+0.4554)^{1.509}','location','northeast')
 title('Alpha power law model fit for PMOS device')
 text(-0.85,1.4E-4,'R^2 = 0.9857')
% 
 r2 = 1- sum((real(ids-my_model)).^2)/sum((ids-mean(ids)).^2)
