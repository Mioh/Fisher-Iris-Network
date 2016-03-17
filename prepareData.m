% Main
function [P, T] = prepareData(varargin)
    % Read data
    [measurments,species] = xlsread('Iris data');
    species = species(:,5);
    nrSamples = length(species);
    
    if nargin >= 1
        if strcmp(varargin{1},'plot') 
            % Plot data
            figure('Name', 'Sepal width/length');
            gscatter(measurments(:,1),measurments(:,2),species,'kkk','x.o', [7,9,7]);
            set(gca,'FontSize',20);
            figure('Name', 'Petal width/length');
            gscatter(measurments(:,3),measurments(:,4),species,'kkk','x.o',[7,9,7]);
            set(gca,'FontSize',20);
        end
    end
    
    % Create random permutation of data
    randIndex = randperm(nrSamples);
    % Randomize row order based on permutation
    species = species(randIndex,:);
    measurments = measurments(randIndex,:);
    
    %Normalization NOT needed here as it will be done automatically when
    %creating the network using mapminmax. It is done in the following way:
    %MIN = min(measurments(:));
    %MAX = max(measurments(:));
    %HIGH = 1;
    %LOW = -1;
    %measurments = (((HIGH-LOW) * (measurments - MIN)) / (MAX - MIN)) + LOW;
    
    % Define target as binary representation of spiecies
    speciesBinary = spieciesAsBinary(species);
    
    % Transpose matricies
    P = measurments';
    T = speciesBinary';
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


