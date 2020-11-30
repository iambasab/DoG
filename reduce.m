
function [retmatel,retrowind,retcolind] = reduce(coefmat,retmatel,retrowind,retcolind,filtype)

% FUNCTION THAT GOES WITH TEMP.M. IT REDUCES THE SET OF COEFFICIENT
% MATRICES TO A ROW VECTOR. SIMULTANEOUSLY, IT RECORDS THE ROW AND
% COLUMN INDICES IN SEPARATE VECTOR MATRICES.


[rowind,colind,matel] = find(coefmat);
l = length(matel);
retmatel(filtype,1:l) =  transpose(matel);
retrowind(filtype, 1:l) = transpose(rowind);
retcolind(filtype, 1:l) = transpose(colind);
