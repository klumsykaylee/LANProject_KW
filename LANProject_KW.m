%% LAN Project
% Kaylee Ward
% 10/25/2024 
% Network Engineering
% CENG-4213
%% Clean up (stolen from Dr. Waldo)
close all;
clear;
clc;
format compact;
%% Task 1
% initialization
K_values = [1, 5, 15, 50, 100]; % each packet size that needs to be simulated
p = 0:0.01:1; % probability of failure from 0 to 1
N = 1000; % # of iterations
simulated_results = zeros(length(K_values), length(p)); % where the code stores the simulated results
expected_results = zeros(length(K_values), length(p)); % where the code stores the calculated results

% main loop
for i = 1:length(K_values) % runs through each value of K
    K = K_values(i); % packet size
    for j = 1:length(p) % runs through each value of p
        p_value = p(j); % probability of failure
        simulated_results(i, j) = runSingleLinkSim(K, p_value, N); % calculates the simulated
        expected_results(i, j) = K / (1 - p_value); % calculates the expected
    end
end

% plotting/part of main loop
for i = 1:length(K_values) % runs through each value of K
    K = K_values(i); % packet size
    figure; % creates an empty plot for each K value
    plot(p, expected_results(i, :), 'k-'); % plots the calculated results
    hold on; % holds for all info to be considered until told to turn off
    plot(p, simulated_results(i, :), 'ko', 'MarkerFaceColor', 'w'); % plots the simulated results
    title(sprintf('Task 1: K = %d', K)); % title for the plot
    xlabel('p'); % x-axis title
    ylabel('Average # of transmissions'); % y-axis title
    legend('Calculated result', 'Simulated result'); % legend
    grid on; % enables the grid (easier for user to read)
    set(gca, 'YScale', 'log'); % Set y-axis to logarithmic scale
    hold off; % tells the previous "hold on" that we are done retrieving info
end


%% Task 2 
% initialization
K_values = [1, 5, 15, 50, 100]; % each packet size that needs to be simulated
p_values = linspace(0, 1, 100); % range of probabilities of failure, p
num_iterations = 1000; % # of iterations

combined_expected_results = zeros(length(K_values), length(p_values));
combined_simulated_results = zeros(length(K_values), length(p_values));

% main loop for each K value
for i = 1:length(K_values) 
    K = K_values(i); % packet size
    simulated_results = zeros(length(p_values), 1); % stores the simulated results
    expected_results = zeros(length(p_values), 1); % stores the expected results    
    for j = 1:length(p_values) % runs through each value of p
        p = p_values(j); % probability of failure
        simulated_results(j) = runTwoSeriesLinkSim(K, p, num_iterations); % simulation
        expected_results(j) = K/((1-p)^2); % expected calculations
    end
    combined_expected_results(i, j) = expected_results; % stores expected result
    combined_simulated_results(i, j) = simulated_results; % stores simulated result

    % plotting
    figure; % creates a new figure for each K
    semilogy(p_values, expected_results, 'k-', 'LineWidth', 2); % plots expected results in black
    hold on; % holds for overlaying plots
    semilogy(p_values, simulated_results, 'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'w'); % plots simulated results as hollow circles
    title(['task 2: K = ' num2str(K)]); % title for the plot
    xlabel('p'); % x-axis title
    ylabel('average # of transmissions'); % y-axis title
    legend('expected', 'simulated'); % legend
    grid on; % enables the grid
    hold off; % release hold for new plots
end
figure; % creates a new figure for combined results
hold on; % holds for overlaying plots
for i = 1:length(K_values) % loop through each K
    semilogy(p_values, combined_expected_results(i, :), 'DisplayName', ['Expected K = ' num2str(K_values(i))], 'LineWidth', 2, 'Color', 'k');
    semilogy(p_values, combined_simulated_results(i, :), 'ko', 'DisplayName', ['Simulated K = ' num2str(K_values(i))], 'MarkerSize', 5, 'MarkerFaceColor', 'w'); 
end
title('Task 2: Combined'); % title for the combined plot
xlabel('p'); % x-axis title
ylabel('Average # of transmissions'); % y-axis title
legend show; % display the legend
grid on; % enables the grid
hold off; % release hold for new plots

%% Task 3
% initialization
K_values = [1, 5, 15, 50, 100]; % each packet size that needs to be simulated
p_values = 0:0.01:1; % probability of failure from 0 to 1
N = 1000; % # of iterations
figure; % creates an empty plot (will be filled in the for-loop)
hold on; % holds for all info to be considered until told to turn off

% main loop
for K = K_values % packet size
    simulated_results = zeros(length(p_values), 1); % stores the simulated results
    for j = 1:length(p_values) % runs through each value of p
        p = p_values(j); % probability of failure
        simulated_results(j) = runTwoParallelLinkSim(K, p, N); % runs the simulation
    end
    semilogy(p_values, simulated_results, 'ko', 'MarkerFaceColor', 'w', 'DisplayName', ['K = ' num2str(K)]); % plots the results (for each K-value)
end

% plotting
title('task 3'); % title for the plot
xlabel('p'); % x-axis title
ylabel('average # of transmissions'); % y-axis title
legend show; % legend
grid on; % enables the grid (easier for user to read)
set(gca, 'YScale', 'log'); % sets the y-axis to "log" scale
hold off; % tells the previous "hold on" that we are done retreiving info

%% Task 4
% initialization
K_values = [1, 5, 15, 50, 100]; % each packet size that needs to be simulated
p_values = 0:0.01:1; % probability of failure from 0 to 1
N = 1000; % # of iterations
figure; % combined figure for all K values
hold on; % holds for all info to be considered until told to turn off

% main loop
for K = K_values % packet size
    simulated_results = zeros(length(p_values), 1); % stores the simulated results
    for j = 1:length(p_values) % runs through each value of p
        p = p_values(j); % probability of failure
        simulated_results(j) = runCompoundNetworkSim(K, p, N); % runs the simulation
    end
    semilogy(p_values, simulated_results, 'ko', 'MarkerFaceColor', 'w', 'DisplayName', ['K = ' num2str(K)]); % plots each result
end

% plotting
title('task 4'); % title for the plot
xlabel('p'); % x-axis title
ylabel('average # of transmissions'); % y-axis title
legend show; % legend
grid on; % enables the grid (easier for user to read)
set(gca, 'YScale', 'log'); % sets the y-axis to "log" scale
hold off; % tells the previous "hold on" that we are done retreiving info

%% Task 5
% initialization
K_values = [1, 5, 10]; % each packet size that needs to be simulated
N = 1000; % # of iterations
% array of each probability of failure from table
table_values = {
    [0.1, 0.6], [0.01, 0.99]; % p1, p2
    [0.6, 0.1], [0.01, 0.99]; % p2, p1
    [0.1, 0.01], [0.6, 0.99]; % p3, p1
    [0.6, 0.01], [0.1, 0.99]; % p4, p2
    [0.01, 0.1], [0.6, 0.99]; % p5, p1
    [0.01, 0.6], [0.1, 0.99]; % p6, p2
};

% main loop (runs over each figure # in the table)
for i = 1:size(table_values, 1) % runs through each value in the "table" (array)
    figure; % creates a new figure for each indexed value
    hold on; % holds for all info to be considered until told to turn off
    for K = K_values
        p1 = table_values{i, 1}; % gets the first probability (p_ value)
        p2 = table_values{i, 2}; % gets the second probability (p_ value)
        p_vector = linspace(p1(1), p2(2), 100); % range of probabilities
        simulated_results = zeros(length(p_vector), 1); % stores the simulated results
        for j = 1:length(p_vector) % runs through each value of p (from the vector)
            p_current = [p1(1) * p_vector(j), p2(1) * p_vector(j)];  % vector of probabilities for the current figure #
            simulated_results(j) = runCustomCompoundNetworkSim(K, p_current, N); % runs the simulation
        end
        semilogy(p_vector, simulated_results, 'o', 'DisplayName', ['K = ' num2str(K)], 'MarkerSize', 5); % plots the results
    end

    % plotting
    title(['task 5: figure ' num2str(i)]); % title for the plot
    xlabel('p'); % x-axis title
    ylabel('average # of transmissions'); % y-axis title
    grid on; % enables the grid (easier for user to read)
end