vc1 = linspace(1,50,200)
c2 = c1
[C1,C2] = meshgrid(c1,c1)

%F = X.*exp(-X.^2-Y.^2);
delay  =  (1+C1) + (1+C2./C1) + (270./C2)
energy_alex = 1+ C1 + C2 + 270
surf(C1,C2,delay)
xlabel('C1')
ylabel('C2')
zlabel('delay')
figure()
surf(C1,C2,energy_alex)
xlabel('C1')
ylabel('C2')
zlabel('Energy')

i = find(delay==min(min(delay)))

delay_min = delay(i)
C1_min = C1(i)
C2_min = C2(i)

figure()
%contour(delay,1)
%contour(C1,C2,delay)

delay_more_i = 2888
delay_more = delay(delay_more_i)

[cc hh] = contour(C1,C2,delay,[delay_more delay_more])
xlabel('C1')
ylabel('C2')
title('Contour at 1.1*delay = 23.5307')

c1_contour = cc(1,:)
c2_contour = cc(2,:)

energy = 1 + c1_contour + c2_contour + 270
i_en = find(energy == min(energy))
energy_min = energy(i_en)
c1_contour(i_en)
c2_contour(i_en)

