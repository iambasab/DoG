

function C = midconv1(A,samp_resol,filt_dim,cent_dev,cell_type,cell_polarity,shift)

%% This function is being called from within the script file main2/lilianIII.m for generating the coefficient matrices by performing a convolution of the %% image matrix with the DoG filter matrices. 
%% kr and kc are the sampling resolution during filtering of A by B along
%% the rows and the columns respectively


B=dog1(filt_dim,cent_dev,cell_type,shift); 
if (cell_polarity==1)%% 1 is for off-centre cell; 2 will be for on-centre
B=-B;
end
[ma na] = size(A);
[mb nb] = size(B);
C = zeros(ma,na);

% r1 AND s1 ARE INITIALISED TO THE MIDDLE INDICES OF THE FILTER B
r1 = ceil(mb/2); 
s1 = ceil(nb/2);

icount=0;
% i AND j ARE THE INDICES OF THE MATRIX C. 
 for i = 1 : samp_resol : ma
     icount=icount+1;
     
     
     jcount=0;
       for j =1 : samp_resol : na
       jcount=jcount+1;
           i1 = max(0,i-r1);                 % i1 AND j1 ARE THE CURRENT INDICES OF THE IMAGE MATRIX A
           for r = max(1,r1-i+1) : mb        % r AND s ARE THE CURRENT INDICES OF THE FILTER MATRIX B 
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
                         C(i,j) = C(i,j) + B(r,s) * A(i1,j1);
                         C1(icount,jcount) = C(i,j);
            
                      end % end of for loop for s
                      
               end % end of for loop for r

           
           end % end of for loop for j

              
   end %end of for loop for i
                       

