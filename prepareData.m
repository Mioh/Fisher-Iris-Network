% Main
function [input, target] = prepareData
    % Read data
    [measurments,species] = xlsread('Iris data');
    species = species(:,5);
    nrSamples = length(species);
    
    % Create random permutation of data
    randIndex = randperm(nrSamples);
    % Randomize row order based on permutation
    species = species(randIndex,:);
    measurments = measurments(randIndex,:);
    
    % Normalise data
    %MIN = min(measurments(:));
    %MAX = max(measurments(:));
    %HIGH = 1;
    %LOW = -1;
    %measurments = (((HIGH-LOW) * (measurments - MIN)) / (MAX - MIN)) + LOW;
    
    % Define target as binary representation of spiecies
    speciesBinary = spieciesAsBinary(species);
    
    % Transpose matricies
    input = measurments';
    target = speciesBinary';
end

% Represent spiecies as binary arrays
function spieciesBinary = spieciesAsBinary(spiecies)
    % Allocate space for rows of target data
    size = length(spiecies);
    spieciesBinary = zeros(size,3);
    for i=1:size
        switch char(spiecies(i))
          case 'Setosa'
            spieciesBinary(i,:) = [1,0,0]; 
          case 'Versicolor'
            spieciesBinary(i,:) = [0,1,0]; 
          case 'Virginica'
            spieciesBinary(i,:) = [0,0,1]; 
        end
    end
end


