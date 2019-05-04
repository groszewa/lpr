vgs = 1.2
w = 1E-6
k = 3.6E-6

L_mean = 0.18E-6
L_std = 0.01E-6

Vth_mean = 0.2
Vth_std = 0.06
% 
% x = 0:0.001:0.6
% y = normpdf(x,Vth_mean,Vth_std)
% 
% subplot(2,1,1)
% plot(x,y)
% title('PDF of Voltage (V)')
% 
% x = 0:0.001E-7:0.3E-6
% y = normpdf(x,L_mean,L_std)
%   subplot(2,1,2)
%   plot(x,y)
%   title('PDF of Channel Length (m)')


rng('default')
num_samples = 100000
L_norm = normrnd(L_mean,L_std,[1,num_samples])
Vth_norm = normrnd(Vth_mean,Vth_std,[1,num_samples])
Idsat = (((1/2)*w*k)./L_norm).*(vgs - Vth_norm).^2

limit = 9E-6

num_passed = sum(Idsat > limit)
yield = num_passed/num_samples

Idsat_mean = mean(Idsat)
Idsat_std  = std(Idsat)

subplot(3,1,1)
histfit(L_norm)
title('Channel Length')
subplot(3,1,2)
histfit(Vth_norm)
title('Vth')
subplot(3,1,3)
histfit(Idsat)
title('Idsat')
hold on
line([9E-6 9E-6],[0 1500],'Color','green')
text(limit,1300,'\leftarrow 9\muA')
my_text = ['Yield = ',num2str(yield)]
text(1.4E-5,1200,my_text)



