% test system 
m = 5.4789e-10; 
k = 3.431e-1;

w = sqrt(k/m);
f = w/(2*pi);

% Range of b values to try
b_values = linspace(1e-8, 1e-3, 1000); % Try different values of b

flatness_range = [0, 4000]; % Frequency range for flat response

flatness_measure = zeros(size(b_values)); % Array to store flatness measure for each b

for i = 1:length(b_values)
    b = b_values(i);
    
    % Compute the transfer function
    s = tf('s');
    H = 1 / (m * s^2 + b * s + k);
    
    % Compute the magnitude response within the flatness range
    [mag, ~, wout] = bode(H, {2 * pi * flatness_range(1), 2 * pi * flatness_range(2)});
    
    % Compute the flatness measure (standard deviation of magnitude response)
    flatness_measure(i) = std(20 * log10(squeeze(mag)));
end

% Find the index of the minimum flatness measure
[min_flatness, min_index] = min(flatness_measure);

% Corresponding b value
optimal_b = b_values(min_index);

disp(['Optimal b value for flat response from 0 to 4000 Hz: ', num2str(optimal_b)]);
