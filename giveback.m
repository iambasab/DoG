function R = giveback(Q,B,k,i,j)
% FUNCTION THAT GOES WITH MAIN.M AND IS FOR RECONSTRUCTING A PICTURE
% IT IS A RECURSIVE FUNCTION CALL
R = Q;
[ma,na] = size(R);
[mb,nb] = size(B);


r1 = ceil(mb/2) ; 
s1 = ceil(nb/2)  ;

        
        
  i1 = max(0,i-r1);
           for r = max(1,r1-i+1) : mb 
             
             i1 = i1 + 1;
             if(i1 > ma)
                break
             end
                   j1 =max(0,j-s1);
                   for s = max(1,s1 - j + 1) : nb
                             
                    j1 = j1 + 1;
                    if(j1 > na)
                       break
                    end
                    
     R(i1,j1) = R(i1,j1) + B(r,s) * (k);
 end % for loop for s
end % for loop for r

