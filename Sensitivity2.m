% Load your data
filename1 = 'SensNithin3004.dat'; % Replace with your actual file names
filename2 = 'SensNithin3005.dat'; % Replace with your actual file names

% Read the data, skipping the header lines
data1 = readtable(filename1, 'FileType', 'text', 'HeaderLines', 3);
data2 = readtable(filename2, 'FileType', 'text', 'HeaderLines', 3);

% Extract x and y values
x1 = data1{:, 1};  % Extract the first column as x1
y1 = data1{:, 2};  % Extract the second column as y1

x2 = data2{:, 1};  % Extract the first column as x2
y2 = data2{:, 2};  % Extract the second column as y2

% Calculate Oscillation FOM for the first curve
% Step 1: Find local maxima and minima
[peaks1, locs1_max] = findpeaks(y1, x1); % Local maxima
[valleys1, locs1_min] = findpeaks(-y1, x1); % Local minima (invert y to find minima)
valleys1 = -valleys1; % Correct the sign of minima

% Step 2: Pair peaks and valleys
min_length1 = min(numel(peaks1), numel(valleys1));

% Pairing closest maxima and minima based on their locations
if locs1_max(1) < locs1_min(1)
    amplitude_oscillations1 = sum(abs(peaks1(1:min_length1) - valleys1(1:min_length1)));
else
    amplitude_oscillations1 = sum(abs(peaks1(1:min_length1-1) - valleys1(2:min_length1)));
end

% Calculate the number of oscillations
num_oscillations1 = numel(peaks1) + numel(valleys1);

% Repeat for the second curve
[peaks2, locs2_max] = findpeaks(y2, x2);
[valleys2, locs2_min] = findpeaks(-y2, x2);
valleys2 = -valleys2;

min_length2 = min(numel(peaks2), numel(valleys2));

if locs2_max(1) < locs2_min(1)
    amplitude_oscillations2 = sum(abs(peaks2(1:min_length2) - valleys2(1:min_length2)));
else
    amplitude_oscillations2 = sum(abs(peaks2(1:min_length2-1) - valleys2(2:min_length2)));
end

num_oscillations2 = numel(peaks2) + numel(valleys2);

% Define weights for oscillation count and amplitude
w_osc = 0.5; % weight for oscillation count
w_amp = 0.5; % weight for amplitude

% Combine them into an Oscillation FOM
FOM_osc1 = w_osc * num_oscillations1 + w_amp * amplitude_oscillations1;
FOM_osc2 = w_osc * num_oscillations2 + w_amp * amplitude_oscillations2;

% Display the results
disp(['Number of oscillations in the first curve: ', num2str(num_oscillations1)]);
disp(['Amplitude of oscillations in the first curve: ', num2str(amplitude_oscillations1)]);
disp(['Oscillation FOM for the first curve: ', num2str(FOM_osc1)]);

disp(['Number of oscillations in the second curve: ', num2str(num_oscillations2)]);
disp(['Amplitude of oscillations in the second curve: ', num2str(amplitude_oscillations2)]);
disp(['Oscillation FOM for the second curve: ', num2str(FOM_osc2)]);
