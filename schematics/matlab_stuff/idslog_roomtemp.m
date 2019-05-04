data = csvread("pmos_ids_log_lowtep.csv")

vgs= data(:,1)
idslog = data(:,2)

coefs = polyfit(vgs,idslog,1)
coefs

plot(vgs,idslog)