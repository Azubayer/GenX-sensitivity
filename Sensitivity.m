% Define your filenames
filename1 = 'SensCoTithin3004.dat'; % Replace with your actual file names
filename2 = 'SensCoTithin3005.dat'; % Replace with your actual file names

% Step 1: Read the data, skipping the header lines
% Assuming 3 header lines as indicated by your example
data1 = readtable(filename1, 'FileType', 'text', 'HeaderLines', 3);
data2 = readtable(filename2, 'FileType', 'text', 'HeaderLines', 3);

% Assuming the first column is x and the second column is y
x1 = data1{:, 1};  % Extract the first column as x1
y1 = data1{:, 2};  % Extract the second column as y1

x2 = data2{:, 1};  % Extract the first column as x2
y2 = data2{:, 2};  % Extract the second column as y2

% Step 2: Compute the absolute area under each curve
area1 = trapz(x1, abs(y1));
area2 = trapz(x2, abs(y2));

% Step 3: Interpolate y2 onto x1 to ensure both curves are evaluated at the same x-points
y2_interp = interp1(x2, y2, x1, 'linear', 'extrap');

% Step 4: Compute the integral of the absolute difference between the two curves
diff_integral = trapz(x1, abs(y1 - y2_interp));

% Step 5: Define weights for the area difference and curve difference terms
w1 = 0.5; % weight for area difference
w2 = 0.5; % weight for curve difference

% Step 6: Combine them into a Figure of Merit (FOM)
FOM = w1 * abs(area1 - area2) + w2 * diff_integral;

% Display the results
disp(['Area under the first curve: ', num2str(area1)]);
disp(['Area under the second curve: ', num2str(area2)]);
disp(['Integral of the absolute difference between the curves: ', num2str(diff_integral)]);
disp(['Figure of Merit (FOM): ', num2str(FOM)]);
