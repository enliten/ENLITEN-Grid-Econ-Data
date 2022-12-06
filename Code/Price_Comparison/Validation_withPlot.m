%% WECC
load('SW_Price_comparison.mat')
A = normalize(SW_actual_price);
B = normalize(Sim_price);
A_n = movmean(A,2);
B_n = movmean(B,2);
subplot(1,3,1)
plot(A_n)
hold on
plot(B_n)
grid on 
co = corrcoef(A_n,B_n);
disp(['WECC Southwest correlation  ', num2str(co(3))])
xlabel('ICE price sample index')
ylabel('price variation index')
title('Southwest','fontweight','bold')

load('NW_Price_comparison.mat')
A = normalize(NW_actual_price);
B = normalize(Sim_price);
A_n = movmean(A,2);
B_n = movmean(B,2);
subplot(1,3,2)
plot(A_n)
hold on
plot(B_n)
grid on 
co = corrcoef(A_n,B_n);
disp(['WECC Northwest correlation  ', num2str(co(3))])
xlabel('ICE price sample index')
ylabel('price variation index')
title('Northwest','fontweight','bold')

load('CA_Price_comparison.mat')
A = normalize(CA_actual_price);
B = normalize(Sim_price);
A_n = movmean(A,2);
B_n = movmean(B,2);
subplot(1,3,3)
plot(A_n)
hold on
plot(B_n)
grid on 
co = corrcoef(A_n,B_n);
disp(['WECC California correlation  ', num2str(co(3))])
xlabel('ICE price sample index')
ylabel('price variation index')
title('California','fontweight','bold')

%% NPCC
figure
load('NE_Price_comparison.mat')
A = normalize(NE_actual_price);
B = normalize(Sim_price);
A_n = movmean(A,2);
B_n = movmean(B,2);
subplot(1,2,1)
plot(A_n)
hold on
plot(B_n)
grid on 
co = corrcoef(A_n,B_n);
disp(['NPCC New England correlation  ', num2str(co(3))])
xlabel('ICE price sample index')
ylabel('price variation index')
title('New England','fontweight','bold')

load('NY_Price_comparison.mat')
A = normalize(NY_actual_price);
B = normalize(Sim_price);
A_n = movmean(A,2);
B_n = movmean(B,2);
subplot(1,2,2)
plot(A_n)
hold on
plot(B_n)
grid on 
co = corrcoef(A_n,B_n);
disp(['NPCC New York correlation  ', num2str(co(3))])
xlabel('ICE price sample index')
ylabel('price variation index')
title('New York','fontweight','bold')
