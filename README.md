# neauralnetworks
Nearual Networks and Genetic Algorithms Project

run commands:

clear all;
close all;
[P,T] = prepareData();
%[P,T] = prepareData('plot');
[net,error, errors] = trainNetwork(P,T,10);
