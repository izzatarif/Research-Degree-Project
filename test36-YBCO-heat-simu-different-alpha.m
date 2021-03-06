% implicit method. Heat diffusion of thin film sample
% YBCO heat simulation for different thermal diffusivity
% B used is from the bestfit of ALUMINIUM
% Thermal diffusivity is varied.
% data is saved in excel file

clear;
clc;
format long

% constant. laser properties
I = 12;                 %pump laser intensity. 
TAU = 60e-9;            %half pump laser pulse width. mewsec
lambda = 780e-3;        %wavelength of pump laser. mewmeter

% constant. aluminium properties
% B is set at 20 and thermdiff is run at [0.1, 0.2, 0.3, 0.4, 0.5]
B = 20.;                 %absorption per unit length. permewmeter
thermdiff = 0.5;      %thermal diffusivity. mewmeter square per mewsec
rho = 3.0e-9;           %density. miligram per mewmeter cube
Cv = 5;               %specific heat.
C = rho*Cv;             %heat capacity per unit volume.
R = 0.632;              %reflectivity.


% parameter of sample. whithin the space z and time t
L = 95e-3;            % length of wire. 300e-3 mewmeter. 300 nm
t = 700.0e-6;           % final time. 700.0e-6 mewsec. 700 ps

% solving the equation of implicit method
j = 7000;               % number of time steps
dt = t/j;               % time step
n = 95;               % number of space steps
dx = L/n;               % space steps


lambda1 = thermdiff*dt/(dx*dx);       % constant in implicit equation
Q = I*(1-R)*B;
lambda2 = dt*(Q/C);                   % second constant

%matrix creation. to improve speed
grid = zeros(n+1,j+1);                % matrix of temperature at thick-time
x = zeros(1,n+1);                     % matrix of thickness of sample
time = zeros(1,j+1);                  % matrix of time
rhs = zeros(n-2,j+1);                   % matrix of rhs-time

% initial temperature of wire. at time = 1 and any x
for i = 1: n+1
    grid(i,1) = 300.;
    x(i) = (i-1)*dx;
end

% temperature at boundary not given. only gradient = 0 at x = 0 and L
for k = 1: j+1
    time(k) = (k-1)*dt;
    grid(n+1,k) = 300.;         %temperature at substrate contacts
    grid(n,k) = grid(n+1,k);    %temperature above it by 1 index
end

% forming the matrix
diagonal(1:n-2) = 1+2*lambda1;       % diagonal component
diagonal(1) = 1+lambda1;
superdiag(1:n-3)= -lambda1;          % superdiagonal component
subdiag(1:n-3) = -lambda1;           % subdiagonal component
matrix = diag(diagonal,0)+ diag(superdiag,1) + diag(subdiag,-1);

% forming rhs and implementing implicit method
for k = 2: j+1                 % time loop
    for i = 2 : n-2
        % took the value within the boundary of the previous level
        rhs(i-1,k-1) = grid(i,k-1) + lambda2*exp(-B*x(i))*exp(-(time(k-1)/TAU)^2);           % took the value within the boundary of the previous level
    end
    i = n-1;
    rhs(i-1,k-1) = grid(i,k-1) + lambda1*grid(i+1,k) + lambda2*exp(-B*x(i))*exp(-(time(k-1)/TAU)^2);
    grid(2:n-1,k) = matrix\rhs(:,k-1);      % input a new value into the current level
end

modelmeas(:,1) = time'*1e6;         %model measurements
maxgrid = max(grid(2,:));
normtemp = (grid(2,:)-300.)/(maxgrid-300.);
modelmeas(:,2) = normtemp';

%importing experimental data from excel file
% filename = 'data\YBCO_thermal_Sample2_0715.xls';
% timeexp = xlsread(filename,1,'A1:A140');
% normtempexp = xlsread(filename,1,'E1:E140');

%exporting data to excel file
% file has already been made
% filename = 'data\YBCO95nmdata.xlsx';
% xlswrite(filename,modelmeas, 'M1:N7001');

%graphical representation
% figure(2)
% plot(modelmeas(3:end,1)+20,modelmeas(3:end,2)-0.21,'-k')
% hold on
% plot(timeexp,normtempexp,'-b')
% title('Normalized temperature change against Time in picosecond for B = 17')
% xlabel('time / picosecond')
% ylabel('Normalized temperature change')
% legend('Model measurement','Experimental measurement')
% axis([-50 750 0  1.2])




