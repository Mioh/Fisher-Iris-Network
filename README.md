# Fisher Iris Network
Matlab implementation of a neural network able to categorise Iris plants. 
Data set provided is the classic Fisher Irish data set in xls format.

###### Run Commands

1. Prepare data: `[P,T] = prepareData();` 
2  Plot data set:  `prepareData('plot');`
3. Train network:`[net, error, errorv, errors] = trainNetwork(P, T, 2, 10, true);`
4. Train with no graphs: `trainNetwork(P, T, 2, 10, false);`
5. Get the avarage of 100 runs for k = {2,3,4,5,10}: `testNetworks;`
