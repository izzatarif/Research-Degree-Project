% plotting experiment and model data of ybco
% YBCO with different value of thermal diffusivity
% Graph is directly plotted

clc
clear

% importing experimental data from excel file
filename = 'data\YBCO_thermal_Sample2_0715.xls';
timeexp = xlsread(filename,1,'A1:A140');
normtempexp = xlsread(filename,1,'E1:E140');

% importing model data from excel file
filename = 'data\YBCO95nmdata.xlsx';
B01 = xlsread(filename,1, 'A1:B7001');
B02 = xlsread(filename,1, 'D1:E7001');
B03 = xlsread(filename,1, 'G1:H7001');
B04 = xlsread(filename,1, 'J1:K7001');
B05 = xlsread(filename,1, 'M1:N7001');

%graphical representation
figure()
plot(timeexp,normtempexp,'-.k')
hold on
plot(B01(3:end,1)+20,B01(3:end,2)-0.2967,'-b')
plot(B02(3:end,1)+20,B02(3:end,2)-0.2408,'-g')
plot(B03(3:end,1)+20,B03(3:end,2)-0.2020,'-r')
plot(B04(3:end,1)+20,B04(3:end,2)-0.1716,'-m')
plot(B05(3:end,1)+20,B05(3:end,2)-0.1465,'-k')
xlabel('masa / pikosaat')
ylabel('Perubahan suhu ternormal')
legend('boxon')
legend('Pengukuran pemantulan terma','kemeresapan = 0.1','kemeresapan = 0.2','kemeresapan = 0.3','kemeresapan = 0.4','kemeresapan = 0.5')
axis([-50 750 0  1.2])