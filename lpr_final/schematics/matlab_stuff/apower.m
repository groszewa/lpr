data = csvread("ids_curve_apower_new.csv")

vgs= data(:,1)
ids = data(:,2)

vth = 0.5221

%vgs_minus_vth = vgs - vth


%a_model = fit(vgs_minus_vth,ids,'power1')
my_model = 0.0005532*(vgs-vth).^(1.505)


%plot(a_model,vgs_minus_vth,ids)
%hold on
plot(vgs,ids,'k*',vgs,my_model,'g-')
xlabel('Vgs (V)')
ylabel('Ids (A)')
legend('data points','0.0005532*(Vgs-0.5221)^{1.505}','location','northwest')
title('Alpha power law model fit for NMOS device')
text(0.55,1.6E-4,'R^2 = 0.9753')

r2 = 1- sum((ids-my_model).^2)/sum((ids-mean(ids)).^2)
