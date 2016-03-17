% Train a network on population P with target T 
% using k-fold cross-validation
% PRE: length(P) == length(T), length(P) mod k = 0
function [net, error, errorv, errors] = trainNetwork(P, T, h, k, doPlot)
    nrSamples = length(P);
    errors = zeros(k,1);
    errorsv = zeros(k,1);
    step = nrSamples/k - 1;
    
    % Init plot data
    y = []; % output vector
    perf = [];
    vperf = [];
    gradient = [];
    best_perf = zeros(k,1);
    best_vperf = zeros(k,1);
    
    % Create network
    net = newff(P, T, h, {'tansig' 'purelin'});
    net.plotFcns{3} = 'plotconfusion';
    %net.trainParam.showWindow = 0;
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
        
        % Set indicies for training and validation (test=validation)
        net.divideFcn = 'divideind';
        net.divideParam.trainInd = trainInd;
        net.divideParam.valInd = valInd;
        
        % Train network
        [net, record] = train(net, P, T);

        % Store output
        yk = net(P(:,valInd));
        y =[y  yk];
        
        if doPlot
            % Store plot info
            perf = [perf record.perf];
            vperf = [vperf record.vperf];
            gradient = [gradient record.gradient];
            best_perf(i, :) = record.best_perf;
            best_vperf(i, :) = record.best_vperf;
        end
        
        % Store mean squared error
        errors(i, :) = record.best_perf;
        errorsv(i, :) = record.best_vperf;
              
    end
    
    % Cross-validation error (avarage mean squared error)
    error = sum(errors) / k;
    errorv = sum(errorsv) / k;
    
    %Plot confition matrix for all folds
    plotconfusion(T,y);
    
    if doPlot
        % Plot
        figure('Name', 'Performance');
        plot(1:length(perf),perf,1:length(perf),vperf);
        figure('Name', 'Best Performance');
        plot(1:k,best_perf,1:k,best_vperf);
        figure('Name', 'Gradient');
        plot(gradient);
    end
end