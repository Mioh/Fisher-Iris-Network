clear;
close all;

[P,T] = prepareData();

mseAvg = zeros(1,5);

nrIterations = 10;

% 2-5 neurons in the hidden layer 
for h = 2:5
    for i = 1:nrIterations
        [net, error, errorv, errors] = trainNetwork(P, T, h, 10, false);
        mseAvg(h-1) = mseAvg(h-1) + error; 
    end
end

% 10 neurons in the hidden layer
for i = 1:nrIterations
    [net, error, errorv, errors] = trainNetwork(P, T, 10, 10, false);
    mseAvg(5) = mseAvg(5) + error; 
end

mseAvg = mseAvg / nrIterations;