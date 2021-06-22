
format longG

data = readtable('/Users/mymac/Documents/SCRIPTSHEET/SKRIPSI/data_jmeter/4/LatenciesOverTime.csv', 'ReadVariableNames', false, 'HeaderLines', 1);
% x = data{:,2};
 x = -1000:0.5:1000;
 B = data{:,2}';
 B = B(:)';
 %x = B;
h=x/sum(x);
 %y = randn(10000,1);
y = h(:);
disp(x)
n = hist(y);
pmf = n/sum(n);
plot(pmf,'o');