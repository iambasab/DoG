
%  function filtrect(ma,na,sizes)

%% script to prepare the rectangular filterbank - once prepared , can be
%% saved as a .mat file. 
addpath('/users/senb/matlab_folders/myfunctions')
stcl=clock;
% if(nargin==0)
% ma=128; na=128;sizes=7;
% end
ma=32; na=32;sizes=6;

totpix=ma*na;
elements=round((4/3)*ma*na);
n=5;v=0.5;
for scale = 1:sizes
    DOG{1,scale} = posdog((n*(2^(scale-1)))+((2^(scale-1))-1), v*(2^(scale-1)));
end
clear n v;
dist=distributor(2);
num_of_labs=numlabs;
extra_col = rem(elements,num_of_labs);
num_col_F=elements-extra_col;
F = zeros(totpix,num_col_F,dist);
offset = (size(F,2)/num_of_labs);
st_ind=0;

for scale1 = 1:sizes
   resol1 = 2^(scale1-1);
   f1=DOG{1,scale1};  
   [mf,nf]=size(f1);
%    for x=1:resol1:ma
        lab_ind=labindex;
       for F_row_ind = (((lab_ind-1) * offset)+1):(offset *lab_ind)
           
     for y = 1:resol1:na
      colcount=colcount+1;

filt2 = zeros(ma,na);

midrowf2 = ceil(mf/2) ; 
midcolf2 = ceil(nf/2) ;

  rowfilt= max(0,x-midrowf2);
           for rowf2 = max(1,midrowf2-x+1) : mf 
                rowfilt= rowfilt + 1;
                if(rowfilt > ma)
                    break
                end
                   colfilt =max(0,y-midcolf2);
                   for colf2 = max(1,midcolf2 - y + 1) : nf
                    	colfilt = colfilt + 1;
                    	if(colfilt > na)
                       	    break
                    	end
                        filt2(rowfilt,colfilt)= f1(rowf2,colf2);
                 
                    end % for loop for colf2
            end % for loop for rowf2


F(F_row_ind,:) = filt2(:);  %% Positive  filterbank

end %  y loop
st_ind=st_ind + 1;

% end %% x loop
% end  %%  scale1 loop
% F=F';
