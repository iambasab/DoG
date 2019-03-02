%% Code used in Thesis: Information Recovery from Rank-order encoded Images.
% Basabdatta Sen Bhattacharya, Supervisor: Prof Steve Furber
% School of Computer Science, University of Manchester 2008

function N = preproc(A)
%FUNCTION TO NORMALIZE A PICTURE USING MEAN AND STANDARD DEVIATION

reqmean = 0.5; 
reqstd = 0.15;
meanim = mean(A(:));
stdim = std(A(:));
N = (((A-meanim) ./ stdim) .* reqstd) + reqmean;
