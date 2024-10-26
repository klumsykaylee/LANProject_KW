%% Function runCompoundNetworkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations
function result = runCompoundNetworkSim(K, p, N)
    simResults = zeros(1, N); % Store results for each simulation

    for i = 1:N
        txAttemptCount = 0; % Transmission count
        pktSuccessCount = 0; % Number of packets successfully transmitted
        
        maxAttempts = 10000; % Maximum attempts to avoid infinite loop
        while pktSuccessCount < K && txAttemptCount < maxAttempts
            txAttemptCount = txAttemptCount + 1; % Count this transmission
            
            % Simulate multiple links in series (example with 3 links)
            successCount = sum(rand(1, 3) > p); % Number of successful links
            
            if successCount == 3 % All links must succeed
                pktSuccessCount = pktSuccessCount + 1; % Successful transmission
            end
            
            % Debug output to trace progress
            if mod(txAttemptCount, 1000) == 0 % Every 1000 attempts
                disp(['Simulation ' num2str(i) ', Attempts: ' num2str(txAttemptCount)]);
            end
        end
        
        if pktSuccessCount < K
            disp(['Warning: Simulation ' num2str(i) ' reached max attempts.']);
        end
        
        simResults(i) = txAttemptCount; % Record total attempts for this simulation
    end
    
    result = mean(simResults); % Average over all simulations
end
