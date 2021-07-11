function N = normalize(D,k)
%Normalise a matrix D so that the maximum value of an element
%of the matrix will be k and the minimum value will be 0. 
% k=1;
[md,nd] = size(D);
mxd = max(D(:)); %find the maximum element value
mnd = min(D(:)); %the minimum element value
   if(mxd == mnd)
       N(1:md,1:nd)=k;
   else
   fctd = k/(mxd - mnd);
   
  
      N = (D - mnd).*fctd; 
  end