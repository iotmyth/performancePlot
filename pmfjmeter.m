format longG

clear all;close all;
stringCSV = 'ResponseTimesDistribution';
dataID = '5';
data = readtable(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/data_jmeter/',dataID,'/',strcat(stringCSV,'.csv')), 'ReadVariableNames', false, 'HeaderLines', 1);

markers = {'+','*','.','o','x','v','d','^','s','>','<','v','p','h','p','v','<','>','s','^','d','v','x','o','.','*'};
colors = {'b','b','m','k','y','c','g','c','y','k','m','b'};
lines = {'-','--',':','-.',':','--'};
line_width = 0.9;
marker_size = 5;
marker_counter = 1;
color_counter = 1;
line_counter = 1;
ylabels='Response Time (ms)';
ylabels1='Number of Threads';
ylabels2='Mega Bytes (MB)';
ylabels3='Probability';
legend_base_name = 'data-';

x = data{:,1};
y = data{:,2};
y1 = data{:,3};
y2 = data{:,4};

hold on

% set(gca, 'YScale', 'log')
stem(x,y);
stem(x,y1);
stem(x,y2);



box on;
set(gcf,'Units','Inches');
ax = gca;
ax.YAxis.Exponent = 0;
ax.GridLineStyle = ':';
ax.GridAlpha = 0.3;
ax.LineWidth = 0.9;
set(gca,'FontSize',16)


title({'Response Times Distribution','Instance Type (m5.xlarge/m5a.xlarge)'},'FontSize',14);
xlabel(ylabels,'FontSize',15);
ylabel('Number of responses','FontSize',15);
% ylabel('\boldmath \bf{$\log _{10} (Number\, of\, responses)$}','FontSize',15,'interpreter','latex','FontWeight', 'bold');
ax.XAxis.Exponent = 0;
pos = get(gcf,'Position');
set(findall(gcf,'-property','FontName'),'FontName','Times New Roman');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)]);
print(gcf,'-dpdf',strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,stringCSV)),'-r0');
savefig(strcat('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/hasilgrafik/',strcat(dataID,stringCSV)));
hold off