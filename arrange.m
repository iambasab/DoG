
function [SC1,SUB1,M1] = arrange(T1)


% function to sort the coefficients and their indices and then convert the
% indices back to the subscript format and returned to the main programme

% P = transpose(T1(:));
% [M,marker] = sort(P);%sorts in ascending order,
%                      %M has the sorted values whereas marker has the indices
% M1=fliplr(M);%now the sort is in descending order
% marker1=fliplr(marker);%the indices are also arranged accordingly
% marker1 = marker1(find(M1~=0));
% M1=M1(find(M1~=0));
% 
% [SC1,SUB1] = ind2sub([size(T1)],marker1);
% 


P = transpose(T1(:));
[M,marker] = sort(abs(P));%sorts in ascending order,
                     %M has the sorted values whereas marker has the indices
M1=fliplr(M);%now the sort is in descending order
marker1=fliplr(marker);%the indices are also arranged accordingly
marker1 = marker1(find(M1~=0));
M1=M1(find(M1~=0));

m=find(P<0);
for l= 1: length(m)
j=find(marker1==m(l));
M1(j) = -M1(j);
end

[SC1,SUB1] = ind2sub([size(T1)],marker1);


       
       

