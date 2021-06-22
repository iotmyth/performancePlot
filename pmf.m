format longG

data = readtable('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/data_jmeter/4/LatenciesOverTime.csv', 'ReadVariableNames', false, 'HeaderLines', 1);

% ini untuk format date seperti halnya di jmeter ya
% x = seconds((datenum(datestr(data.ElapsedTime, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000);
% x.Format = 'hh:mm:ss';

markers = {'+','*','.','o','x','v','d','^','s','>','<','v','p','h','p','v','<','>','s','^','d','v','x','o','.','*'};
colors = {'r','b','m','k','y','c','g','c','y','k','m','b'};
lines = {'-','--',':','-.',':','--'};
line_width = 0.9;
marker_size = 5;
marker_counter = 1;
color_counter = 1;
line_counter = 1;
ylabels='Response Time (ms)';
ylabels1='Number of Threads';
ylabels2='Mega Bytes (MB)';
ylabels3='TCP Connections';
legend_base_name = 'data-';

% kalo ini format number dalam menit elapsed time
% x = (datenum(datestr(data{:,1}, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000/60;

% ini untuk data x yang pure number aja, bukan elapsed time
x = data{:,2};

hold on
title('Any Plot');
xlabel('Elapsed time (minutes), Granulation: 500 ms','FontSize',12,'FontWeight','bold');
ylabel(ylabels3,'FontSize',12,'FontWeight','bold');
disp(data)
pmfs=zeros(size(x(:))); 
    for i=1:length(x) 
        pmfs(i)= sum(px(find(sx==x(i)))); 
    end
% pmfs = histcounts(data{:,2},[unique(data{:,2}) Inf],'Normalization','probability');
histogram(pmfs);



box on;
ax = gca;
ax.YAxis.Exponent = 0;
legend('show');
hold off