# neauralnetworks
Nearual Networks and Genetic Algorithms Project

run commands:

clear all;
close all;
[P,T] = prepareData(); % to plot data use prepareData('plot');
[net, error, errorv, errors] = trainNetwork(P, T, 2, 10, true);
% For no graphs: trainNetwork(P, T, 2, 10, false);

% To get the avarage of 100 runs for k = {2,3,4,5,10}, run the script by typing:
testNetworks;
