function X = seudo(A,tol)
%%function to calculate the pseudo-inverse; the tolerence value is fixed to
%%10% of the maximum of the svd values
[m,n] = size(A);
if n > m
   X = seudo(A',tol)';
else
   [U,S,V] = svd(A,0);
   if m > 1, s = diag(S);
      elseif m == 1, s = S(1);
      else s = 0;
   end
%    maxs = max(s);
   
%      tol = 0.8;
     
   r = sum(s > tol); %% the count of elements in the array 's' that are greater than the tolerance
   
   if (r == 0)
      X = zeros(size(A'));
   else
      s = diag(ones(r,1)./s(1:r));
      X = V(:,1:r)*s*U(:,1:r)'; %% The values of s are sorted top down.
                                %% thus consecutive cols/rows in U/V represent corresponding values  
   end
end
