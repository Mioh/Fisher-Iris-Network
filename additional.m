    % Partition for 10-fold cross-validation
    k = 10;
    cv = cvpartition(species,'kfold',k);
    
    % Mean-squared error
    cvMse = meanSquaredError(measurments);
    
    % Missclassification rate
    cvMCR = missclassificationRate(measurments, species, cv);
    
    % Confution matrix
    cfMat = confutionMatrix(measurments, species, cv);
    
    % Define target as binary representation of spiecies
    speciesBinary = spieciesAsBinary(species);

% Mean squared error from k-fold cross validation
% As example from http://uk.mathworks.com/help/stats/crossval.html
function cvMse =  meanSquaredError(measurments)
    y = measurments(:,1);
    X = [ones(size(y,1),1),measurments(:,2:4)];

    regf=@(XTRAIN,ytrain,XTEST)(XTEST*regress(ytrain,XTRAIN));

    cvMse = crossval('mse',X,y,'predfun',regf);
end

% Missclassification rate from k-fold cross validation
% Modified example from http://uk.mathworks.com/help/stats/crossval.html
function cvMCR = missclassificationRate(measurments,species,cv)
    y = species;
    X = measurments;

    classf = @(XTRAIN, ytrain,XTEST)(classify(XTEST,XTRAIN,ytrain));

    cvMCR = crossval('mcr',X,y,'predfun',classf,'partition',cv);
end
    
% Missclassification rate from k-fold cross validation
% Modifyed example from http://uk.mathworks.com/help/stats/crossval.html
function cfMat = confutionMatrix(measurments, species,cv)
    y = species;
    X = measurments;
    order = unique(y); % Order of the group labels

    f = @(xtr,ytr,xte,yte)confusionmat(yte,...
    classify(xte,xtr,ytr),'order',order);

    cfMat = crossval(f,X,y,'partition',cv);
    cfMat = reshape(sum(cfMat),3,3);
end