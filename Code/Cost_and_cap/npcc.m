clear
clc

%% fuel price
cp = [42.58, 40.39, 39.09, 39.08, 38.53, 36.14];
ep = [104.1, 102.7, 104.8, 105.3, 105.4, 106.6];
gp = [3.93, 3.51, 4.08, 4.19, 3.90, 3.32];
op = [52.32, 43.67, 54.25, 71.34, 64.3, 41.96];
%% generator list
g(1) = {["Millstone";]};%21
g(2) = {["Brayton Point"]};%22
g(3) = {["Rhode Island State Energy Center"]};%23
g(4) = {["Manchester Street"]};%23
g(5) = {["Pilgrim Nuclear Power Station",]};%24
g(6) = {["Canal"]};%25
g(7) = {["Harris Hydro", "Great Lakes Hydro America - ME", "Bingham Wind";]};%26
g(8) = {["Seabrook"]};%27
g(9) = {["Milford Power Project", "Lake Road Generating Plant"]};%36
g(10) = {["Bethlehem Energy Center"]};%42
g(11) = {["Robert Moses Power Dam"]};%47
g(12) = {["Robert Moses Power Dam"]};%48
g(13) = {["Nine Mile Point Nuclear Station"]};%51
g(14) = {["Sithe Independence Station"]};%52
g(15) = {["R E Ginna Nuclear Power Plant"]};%53
g(16) = {[""]};%54 c
g(17) = {[""]};%54 c
g(18) = {[""]};%55 c
g(19) = {["Empire Generating Co LLC"]};%56
g(20) = {["Robert Moses Niagara"]};%57
g(21) = {["Dunkirk Generating Plant"]};%60
g(22) = {["Indeck Olean Energy Center"]};%61
g(23) = {["Seneca Energy"]};%65
g(24) = {["Howard Wind Farm"]};%68
g(25) = {["Binghamton Cogen"]};%71
g(26) = {["Fenner Wind"]};%72
g(27) = {["E F Barrett"]};%78
g(28) = {["Caithness Long Island Energy Center"]};%79
g(29) = {["Northport"]};%80
g(30) = {["Ravenswood"]};%82
g(31) = {["Belle River"]};%86 c
g(32) = {[""]};%91 c
g(33) = {[""]};%92 c
g(34) = {[""]};%97 c
g(35) = {["Raymondville", "East Norfolk","Yaleville", "Norwood", "Hewittville Hydroelectric", "Massena Energy Facility"]};%98
g(36) = {[""]};%101 c 
g(37) = {["Pine Tree Acres"]};%115
g(38) = {["Midland Cogeneration Venture"]};%119
g(39) = {["Palisades"]};%120
g(40) = {["Tuscola Bay Wind", "Cross Winds Energy Park"]};%121
g(41) = {["Dearborn Industrial Generation"]};%122
g(42) = {["Monroe (MI)"]};%123
g(43) = {["Peach Bottom"]};%130
g(44) = {["Conemaugh"]};%133
g(45) = {["Homer City Generating Station"]};%134
g(46) = {["Panda Patriot Generation Plant","York Energy Center"]};%135
g(47) = {["Hunterstown Power Plant"]};%137
g(48) = {["John E Amos"]};%139
% col. 5: name
% col. 95: electric fuel
% col. 96: net generation
%% O&M cost and capital cost
col_om = [37.8*1000, 4.47];
col_cap = [3246*1000];
ng_om = [13.17*1000, 3.6];
ng_cap = [917*1000];
nu_om = [92.28*1000, 2.14];
nu_cap = [5530*1000];
bio_om = [200*1000, 10];
bio_cap = [6000*1000];
win_om = [40*1000, 0];
win_cap = [2213*1000];
sun_om = [35*0, 0];
sun_cap = [6000*1000];
geo_om = [132*0, 0];
geo_cap = [6000*1000];
hy_om = [132*0, 0];
hy_cap = [6000*1000];

%%
gencost = zeros(48,7);
gencost(:,1) = 2;gencost(:,2:3) = 0;gencost(:,4) = 3;gencost(:,5) = 0;
npcc_type = [];
npcc_cap = [];
unit_capacity = [];
unit_type = [];
for unit = 1:48
    gg = g{unit};
    % if bus located in Canada  
    if gg == ""
        unit_type = [unit_type;"HYC"];
        unit_capacity = [unit_capacity;0;];
        continue;
    end
    o_name = [];
    type = [];
    ef = []; ng = [];fu = []; ec = [];cap = zeros(size(gg,1),6);
    for y = 2015:2020
        i_ef = []; i_ng = [];i_fu = []; i_ec = [];
        i_name = []; i_type = [];
        file = strcat(string(y),'.xlsx'); 
        [~,~, data]  = xlsread(file);
        for i = 1:size(gg)
            flg = 0;
            for j = 7:size(data,1)
                if gg(i) == string(data(j,4))
                        flg = 1;
                        i_name = [i_name; string(data(j,4))];
                        i_type = [i_type; string(data(j,16))];
                        i_ef = [i_ef; cell2mat(data(j,93))];
                        i_ng = [i_ng; cell2mat(data(j,96))];
                        i_fu = [i_fu; string(data(j,19))];
                    switch string(data(j,19))
                        case ""
                           i_ec = [i_ec; 0];
                        case "barrels"
                           i_ec = [i_ec; cell2mat(data(j,93))*op(y-2014)];
                        case "mcf"
                           i_ec = [i_ec; cell2mat(data(j,93))*gp(y-2014)];
                        case "Mcf"
                           i_ec = [i_ec; cell2mat(data(j,93))*gp(y-2014)];
                        case "short tons"
                           i_ec = [i_ec; cell2mat(data(j,93))*cp(y-2014)];
                       case "megawatthours"
                           i_ec = [i_ec; cell2mat(data(j,93))*ep(y-2014)];
                    end
                end
            end
            if flg == 0
                if ~isempty(type)
                    i_name = [i_name; gg(i)];
                    i_type = [i_type; type(i,end)];
                    i_ef = [i_ef; ef(i,end)];
                    i_ng = [i_ng; ng(i,end)];
                    i_fu = [i_fu; fu(i,end)];
                    i_ec = [i_ec; ec(i,end)];
                else
                    i_name = [i_name; gg(i)];
                    i_type = [i_type; "NA"];
                    i_ef = [i_ef; 0];
                    i_ng = [i_ng; 0];
                    i_fu = [i_fu; 0];
                    i_ec = [i_ec; 0]; 
                end
            end
        end
        name = unique(i_name);
        for i = 1:size(name,1)
           idx = all(ismember(i_name,name(i)),2);
           idx = find(idx==1);
           if size(idx,1) == 1
              continue 
           end
           [~,max_u]=max(i_ng(idx));
           eli_u = setdiff(idx,idx(max_u));
           i_ef(idx(max_u)) = i_ef(idx(max_u)) + sum(i_ef(eli_u));
           i_ng(idx(max_u)) = i_ng(idx(max_u)) + sum(i_ng(eli_u));
           i_ec(idx(max_u)) = i_ec(idx(max_u)) + sum(i_ec(eli_u));
           i_name(eli_u) = [];i_type(eli_u) = [];i_ef(eli_u) = [];i_ng(eli_u) = [];i_fu(eli_u) = [];i_ec(eli_u) = [];  
        end
        file = strcat(string(y),'c.xlsx'); 
        [~,~, cap_data]  = xlsread(file);
        for i = 1:size(i_name,1)
           for j = 3:size(cap_data,1)
               if i_name(i) == string(cap_data(j,4))
                   if isnumeric(cell2mat(cap_data(j,17)) )
                       cap(i,y-2014) = cap(i,y-2014) + cell2mat(cap_data(j,16))*cell2mat(cap_data(j,17));
                   else
                       cap(i,y-2014) = cap(i,y-2014) + cell2mat(cap_data(j,16));
                   end
               end
           end
        end
       o_name = [o_name, i_name]; 
       type = [type, i_type];
       ef = [ef, i_ef];
       ng = [ng, i_ng];
       fu = [fu, i_fu];
       ec = [ec, i_ec];
    end
    for i = 1:size(type,1)
       idx = find(type(i,:)=="NA");
       type(i,idx) = type(i, max(idx)+1);
       ef(i,idx) = ef(i, max(idx)+1);
       ng(i,idx) = ng(i, max(idx)+1);
       fu(i,idx) = fu(i, max(idx)+1);
       ec(i,idx) = ec(i, max(idx)+1);
       cap(i,idx) = cap(i, max(idx)+1);
    end
    p2 = 0; fix_om = []; var_om = [];
    m_cap = mean(cap,2);
    tt = [];
    tt_type = [];
    ec = sum(ec,2);
    ng = sum(ng,2);
    for i = 1:size(o_name,1)
         if isempty(npcc_type)
             npcc_type = [npcc_type; type(i,end)];
             npcc_cap = [npcc_cap; m_cap(i)];
         else
             if ismember(type(i,end), npcc_type)
                 [~,idx] = ismember(type(i,end), npcc_type);
                 npcc_cap(idx) = npcc_cap(idx) + m_cap(i);
             else
                 npcc_type = [npcc_type; type(i,end)];
                 npcc_cap = [npcc_cap; m_cap(i)];
             end
         end
         if isempty(tt)
             tt_type = [tt_type; type(i,end)];
             tt = [tt; ng(i)];
         else
             if ismember(type(i,end), tt_type)
                 [~,idx] = ismember(type(i,end), tt_type);
                 tt(idx) = tt(idx) + ng(i);
             else
                 tt_type = [tt_type; type(i,end)];
                 tt = [tt; ng(i)];
             end
         end
        if type(i,end) == "COL"||type(i,end) == "DFO"||type(i,end) == "RFO"
            p2 = p2 + col_cap*m_cap(i)/40/8760 + col_om(1)*m_cap(i)/8760;
             ec(i) = ec(i) + col_om(2)*ng(i);    
        elseif type(i,end) == "HYC"||type(i,end) == "HPS"
             p2 = p2 + hy_cap*m_cap(i)/100/8760 + hy_om(1)*m_cap(i)/8760;
             ec(i) = ec(i) + hy_om(2)*ng(i);
        elseif type(i,end) == "WOO"||type(i,end) == "WOC"
             p2 = p2 + bio_cap*m_cap(i)/25/8760 + bio_om(1)*m_cap(i)/8760;
             ec(i) = ec(i) + bio_om(2)*ng(i);
        elseif type(i,end) == "SUN"
             p2 = p2 + sun_cap*m_cap(i)/30/8760 + sun_om(1)*m_cap(i)/8760;
             ec(i) = ec(i) + sun_om(2)*ng(i);
        elseif type(i,end) == "WND"||type(i,end) == "ORW"
             p2 = p2 + win_cap*m_cap(i)/20/8760 + win_om(1)*m_cap(i)/8760;
             ec(i) = ec(i) + win_om(2)*ng(i);
        elseif type(i,end) == "NG"|| type(i,end) == "OOG"
             p2 = p2 + ng_cap*m_cap(i)/25/8760 + ng_om(1)*m_cap(i)/8760;
             ec(i) = ec(i) + ng_om(2)*ng(i);   
        elseif type(i,end) == "GEO"
             p2 = p2 + geo_cap*m_cap(i)/30/8760 + geo_om(1)*m_cap(i)/8760;
             ec(i) = ec(i) + geo_om(2)*ng(i);
        elseif type(i,end) == "NUC"
             p2 = p2 + nu_cap*m_cap(i)/35/8760 + nu_om(1)*m_cap(i)/8760;
             ec(i) = ec(i) + nu_om(2)*ng(i);  
       end
    end
    [~,idx] = max(tt);
    unit_type = [unit_type;tt_type(idx)];
    unit_capacity = [unit_capacity;sum(m_cap);];
    p(1) = sum(ec)/sum(ng);
    p(2) = p2/size(name,1);
    gencost(unit,6:7) = p;
end
