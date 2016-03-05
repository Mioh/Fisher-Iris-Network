% Train a network on population P with target T 
% using k-fold cross-validation
% PRE: length(P) == length(T), length(P) mod k = 0
function [net, error, errors] = trainNetwork(P, T, k)
    nrSamples = length(P);
    errors = zeros(k,1);
    step = nrSamples/k - 1;
    
    net = newff(P, T, 2, {'tansig' 'purelin'});
    net.plotFcns{3}= 'plotconfusion';
    net = init(net);
    
    % Initiate bounds
    foldEnd = 0;
    for i = 1:k
        % Get bounds of next fold
        foldStart = foldEnd + 1;
        foldEnd = foldStart + step;
        
        % Indecies for validation fold
        valInd = foldStart:foldEnd; 
        
        % Indicies for training
        trainInd = 1:nrSamples;
        trainInd(valInd) = []; % remove fold from training
        
        % Set indicies for training, test and validation (test=validation)
        net.divideFcn = 'divideind';
        net.divideParam.trainInd = trainInd;
        net.divideParam.testInd = valInd;
        net.divideParam.valInd = valInd;
        
        % Train network
        [net, record] = train(net, P, T);
        
        % Store mean squared error
        errors(i, :) = record.best_perf;
        
    end
    
    % Cross-validation error (avarage mean squared error)
    error = sum(errors) / k;
end