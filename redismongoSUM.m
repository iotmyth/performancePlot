format longG

stringREDIS = 'Total Memory Usage-data-as-seriestocolumns-2021-06-14 05_31_33';
stringMONGO = 'Memory-data-as-seriestocolumns-2021-06-04 23_50_41';
bytesDevider = 1000000;
% bytesDevider = 1;
dataID = '4SUMREDISMONGO';
data = readtable(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/data_grafana/4/redis/cluster/',strcat(stringREDIS,'.csv')), 'ReadVariableNames', false, 'HeaderLines', 2);
data2 = readtable(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/data_grafana/4/mongo/',strcat(stringMONGO,'.csv')), 'ReadVariableNames', false, 'HeaderLines', 2);

% ini untuk format date seperti halnya di jmeter ya
% x = seconds((datenum(datestr(data.ElapsedTime, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000);
% x.Format = 'hh:mm:ss';

markers = {'+','x','*','o','x','v','d','^','s','>','<','v','p','h','p','v','<','>','s','^','d','v','x','o','.','*'};
colors = {'r','g','b','k','y','c','g','r','b','m','k','y'};
lines = {'-','--',':','-.',':','--'};
line_width = 0.9;
marker_size = 5;
marker_counter = 1;
color_counter = 1;
line_counter = 1;
ylabels='Response times (ms)';
ylabelslat = 'Mega Bytes (MB)';
ylabelscpu='Number of core CPU';
ylabels1='Number of threads';
ylabels2='Mega Bytes (MB)';
yredis = 'Command executed per second';
ylabelstruput='Mega Bytes (MB) per second';
ylabels3='TCP connections';
ythread='Number of active threads';
%legend_base_name = 'Worker-';
% legend_base_name = 'All nodes';


% kalo ini format number dalam menit elapsed time
x = (datenum(datestr(data{:,1}, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000/60;
x2 = (datenum(datestr(data2{:,1}, 'yyyy-mm-dd hh:MM:ss.fff')) - datenum(datestr(data2{1,1}, 'yyyy-mm-dd hh:MM:ss.fff'))) * 100000/60;
% ini untuk data x yang pure number aja, bukan elapsed time
%x = data{:,1};

% REDIS REMOVE FIRST COLUMN AND SUM ALL ROW
   temp_data = data;
     temp_data(:,1) = [];
   A = table2array(temp_data);
   A(isnan(A))=0;
% A = rand(1000, 4);  % Test data
B = [A, sum(A, 2)/bytesDevider]; %1000000
B(isnan(B))=0;

%MONGO
   temp_data2 = data2;
     temp_data2(:,1) = [];
   A2 = table2array(temp_data2);
   A2(isnan(A2))=0;
% A = rand(1000, 4);  % Test data
B2 = [A2, sum(A2, 2)/bytesDevider]; %1000000
B2(isnan(B2))=0;

% disp(B(:,size(B,2)));

% b_ex = [B,B2];

hold on
if(size(data,2) == 2)
    markers = {'.'};
    colors = {'r'};
    ylabel(ylabels,'FontSize',14);
end

if(size(data2,2) == 2)
    markers = {'.'};
    colors = {'r'};
    ylabel(ylabels,'FontSize',14);
end

% for i=1:size(data,2)-1
%     plot(x,B(:,size(B,2)),strcat(lines{line_counter},strcat(colors{color_counter},markers{marker_counter})),'MarkerSize',marker_size,'LineWidth',line_width,'DisplayName',strcat(legend_base_name,''));
% end

if(size(x) > size(x2))
    ylimit = max(B(:,size(B,2)))*1.2;
else
    ylimit = max(B2(:,size(B2,2)))*1.2;
end


yyaxis left
plot(x,B(:,size(B,2)),strcat(lines{line_counter},strcat(colors{color_counter},markers{marker_counter})),'MarkerSize',marker_size,'LineWidth',line_width)
ylim([0 ylimit])
marker_counter = marker_counter + 1;
color_counter =color_counter+ 1;
xlabel('Elapsed time (minutes)','FontSize',15);
ylabel(ylabelslat,'FontSize',15);
yyaxis right
plot(x2,B2(:,size(B2,2)),strcat(lines{line_counter},strcat(colors{color_counter},markers{marker_counter})),'MarkerSize',marker_size,'LineWidth',line_width,'color',[0 0.7 0])
ylim([0 ylimit])


box on;
grid on;

ax = gca;
ax.YAxis(1).Exponent = 0;
ax.YAxis(2).Exponent = 0;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.LineWidth = 0.9;
set(gca,'FontSize',16)

ax.YColor = 'black';
box(ax,'on');
% ax.YAxis(2).Visible='off'; % Removes right axis


    legend('Bytes received per second','Bytes sent per second');

legend('show');
lgd = legend;
%lgd.FontSize=7;
lgd.Location = 'northWest';

set(gcf,'Units','Inches');

title({'Node Memory SUM: redis cluster (HTTP 50K Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
%title({'Node Command SUM: redis cluster (HTTP 50K Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
%title({'CPU SUM: iotmyth (HTTP 50K Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
%title({'Network RX SUM: ingress (HTTP 50K Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);
%title({'Network TX SUM: ingress (HTTP 50K Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',14);

%title({'HTTP Response Times over Time (50K Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
%title({'HTTP Latencies over Time (50K Threads)','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
%title({'Bytes Throughput over Time (50K Threads)','Instance Type (m5.2xlarge/m5a.2xlarge)'},'FontSize',15);


%ylim([0,max(B(:,size(B,2)))*1.2]);
% xlim([min(x),max(x)])
pos = get(gcf,'Position');
set(findall(gcf,'-property','FontName'),'FontName','Times New Roman');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(gcf,'-dpdf',strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,stringREDIS,stringMONGO)),'-r0');
savefig(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,stringREDIS,stringMONGO)));
% print -dpdf -painters hasilgrafik/1a
colormap(gcf,hot);
hold off;

