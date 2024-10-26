%% Function runSingleLinkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations
function result = runSingleLinkSim(K, p, N)
    simResults = ones(1, N); % a place to store the result of each simulation
    maxAttempts = 10000; % Set a maximum number of attempts to avoid infinite loops

    for i = 1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across

        while pktSuccessCount < K
            r = rand; % generate random number to determine if packet is successful (r > p)
            txAttemptCount = txAttemptCount + 1; % count 1st attempt

            % Attempt to transmit until a packet is successful or max attempts are reached
            attempts = 0; % Reset attempts for each packet
            while r < p && attempts < maxAttempts
                r = rand; % transmit again, generate new success check value r
                txAttemptCount = txAttemptCount + 1; % count additional attempt
                attempts = attempts + 1; % count this attempt
            end
            
            if attempts == maxAttempts
                warning('Max attempts reached for a single packet transmission. Check p or K values.');
                break; % Exit the loop if max attempts are reached
            end

            pktSuccessCount = pktSuccessCount + 1; % increase success count after success (r > p)
        end

        simResults(i) = txAttemptCount; % record total number of attempted transmissions
    end
    result = mean(simResults);
end
