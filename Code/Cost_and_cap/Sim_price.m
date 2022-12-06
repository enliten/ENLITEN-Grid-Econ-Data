clear
clc
%% npcc
% load the case file including topology, cost, capacity,...
mpc = loadcase('npcc.m');
% load the load data
load('NPCC_load.mat');
LMP_c = [];
% maximum price 
price_cap = 50;
% simulate the year-round hourly LMP by MATPOWER
for i = 1:size(load_dis,2)
    mpc.bus(:,3) = load_dis(:,i);
    re = rundcopf(mpc);
    if re.success ~= 1
         LMP_c = [LMP_c,LMP_c(:,i-1)];
         continue;
    end
    % lock price to price cap 
    re.bus(find(re.bus(:,14)>=50),14) = 50;
    LMP = re.bus(:,14);
    LMP_c = [LMP_c, LMP];
end


%% wecc
% load the case file including topology, cost, capacity,...
mpc = loadcase('wecc.m');
% load the load data
load('WECC_load.mat');
LMP_c = [];
% maximum price 
price_cap = 50;
% simulate the year-round hourly LMP by MATPOWER
for i = 1:size(load_dis,2)
    mpc.bus(:,3) = load_dis(:,i);
    re = rundcopf(mpc);
    if re.success ~= 1
         LMP_c = [LMP_c,LMP_c(:,i-1)];
         continue;
    end
    % lock price to price cap 
    re.bus(find(re.bus(:,14)>=50),14) = 50;
    LMP = re.bus(:,14);
    LMP_c = [LMP_c, LMP];
end