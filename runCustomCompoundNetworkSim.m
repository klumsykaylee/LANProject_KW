%% Function runCustomCompoundNetworkSim()
% Parameters
% K - the number of packets in the application message
% p - a vector of probabilities of failure for each link
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations
function result = runCustomCompoundNetworkSim(K, p, N)
    simResults = zeros(1, N); % Store results for each simulation
    numLinks = length(p); % Number of links in the network

    for i = 1:N
        txAttemptCount = 0; % Transmission count
        pktSuccessCount = 0; % Number of packets successfully transmitted

        while pktSuccessCount < K
            txAttemptCount = txAttemptCount + 1; % Count this transmission
            
            % Check success through each link
            success = true;
            for j = 1:numLinks
                if rand < p(j) % If transmission fails on link j
                    success = false;
                    break; % Stop checking further links if one fails
                end
            end
            
            if success
                pktSuccessCount = pktSuccessCount + 1; % Successful transmission
            end
        end

        simResults(i) = txAttemptCount; % Record total attempts for this simulation
    end
    result = mean(simResults); % Average over all simulations
end
