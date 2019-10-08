% plotting of experimental measurement al and ybco sample
% comparing between ALUMINIUM and YBCO thin film
% Graph is directly plotted

% importing experimental data from excel file
filename = 'data\YBCO_thermal_Sample2_0715.xls';
timeexpybco = xlsread(filename,1,'A1:A140');
normtempexpybco = xlsread(filename,1,'E1:E140');

%importing experimental data from excel file
filename = 'data\Aldata300nm.xlsx';
timeexpalum= xlsread(filename,2,'A1:A90');
normtempexpalum = xlsread(filename,2,'B1:B90');

figure
plot(timeexpalum,normtempexpalum,'g')
hold on
plot(timeexpybco,normtempexpybco,'b')
xlabel('masa / pikosaat')
ylabel('Perubahan suhu ternormal')
legend('boxon')
legend('300 nm Aluminium diatas Si','90 nm Al/ 95 nm YBCO diatas STO')
axis([-50 750 0  1.2])