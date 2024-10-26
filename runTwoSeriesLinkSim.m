%% Function runTwoSeriesLinkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations
function result = runTwoSeriesLinkSim(K, p, N)
    simResults = zeros(1, N); % Store results of each simulation
    maxAttempts = 10000; % Set a maximum number of attempts

    for i = 1:N
        txAttemptCount = 0; % Transmission count
        pktSuccessCount = 0; % Number of packets successfully transmitted

        while pktSuccessCount < K
            txAttemptCount = txAttemptCount + 1; % Count this attempt
            
            % Attempt to transmit the packet through two links
            r1 = rand; % First link success check
            r2 = rand; % Second link success check
            
            % Check if the packet succeeds through both links
            if r1 > p && r2 > p
                pktSuccessCount = pktSuccessCount + 1; % Successful transmission
            else
                % If unsuccessful, retry the transmission for this packet
                attempts = 0; % Reset attempts for the packet
                while (r1 <= p || r2 <= p) && attempts < maxAttempts
                    r1 = rand; % Retry first link
                    r2 = rand; % Retry second link
                    txAttemptCount = txAttemptCount + 1; % Count additional attempts
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
    fprintf('Completed simulation for K = %d, p = %.2f: Avg transmissions = %.2f\n', K, p, result); % Debug message
end


