%% Function runTwoParallelLinkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations
% Function to simulate two parallel links
function result = runTwoParallelLinkSim(K, p, N)
    simResults = zeros(1, N); % Store results for each simulation
    maxAttempts = 10000; % Set a maximum number of attempts to avoid infinite loops

    for i = 1:N
        txAttemptCount = 0; % Transmission count
        pktSuccessCount = 0; % Number of packets successfully transmitted

        while pktSuccessCount < K
            txAttemptCount = txAttemptCount + 1; % Count this transmission
            
            % Generate new random numbers for both links
            r1 = rand; % Success check for first link
            r2 = rand; % Success check for second link
            
            % Check success through two parallel links
            if r1 > p || r2 > p % Successful if at least one link works
                pktSuccessCount = pktSuccessCount + 1; % Successful transmission
            else
                % Retry logic if both links fail
                attempts = 0; % Reset attempts for this packet
                while attempts < maxAttempts && (r1 <= p && r2 <= p)
                    r1 = rand; % Retry first link
                    r2 = rand; % Retry second link
                    attempts = attempts + 1; % Count this attempt
                end
                if attempts == maxAttempts
                    warning('Max attempts reached for a single packet transmission. Check p or K values.');
                    break; % Exit if max attempts reached
                end
            end
        end

        simResults(i) = txAttemptCount; % Record total attempts for this simulation
    end
    result = mean(simResults); % Average over all simulations
end

