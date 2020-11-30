function N = preproc(A)
%FUNCTION TO NORMALIZE A PICTURE USING MEAN AND STANDARD DEVIATION

reqmean = 0.5; 
reqstd = 0.15;
meanim = mean(A(:));
stdim = std(A(:));
N = (((A-meanim) ./ stdim) .* reqstd) + reqmean;



% I1 = A3;
% J1 = R3;
% A4 = (A - meana) ./meana;
% R4 = (R - meanr)./meanr;
% reconwocoeff1
% I1 = A4;
% J1 = R4;
% expsobelmod