function rocodecWithFovealModel()

%% This function is run stella with the script file rocodecfovealmodel_on_stellanodes.sh, each
%% 'x' denote the image number, and their are 65 of them. The function is
%% run parallelly on the nodes of stella.

%% This is the same as the retinal model simulation done earlier, but it is
%% for the foveal model that we designed based on Thorpe's retinal model.
%% The filter parameters are different as are the resolutin of filtering.

%% An image is being processed by the DoG filters, 8 of them.The
%% coefficient matrices are then sorted and stored in an array cfs,the image reconstructed in R,and
%% the information plot Q generated. All these three parameters are then
%% stored in the the folder .......

%% Time required: Initial part prior to overlap correction: 8 sec; overlap
%% correction of foveal model coefficients: 30-35 minutes; Reconstruction
%% with generated plot for Q: 128 minutes; Total time: 2'30'' - 2' 45''.
warning off MATLAB:divideByZero;
disp('Start time is:  ')
clock


tic
ma = 128; na=128; dogsc =8;

load('./myfile01.mat');

%% Functions used: preproc, dog1, midconv1
A1 = preproc(A);

B = cell(1,dogsc); %%%initialize the cell matrix to store the DoG matrices
C = cell(1,dogsc); %%%initialize the cell matrix to store the coefficient matrices

disp(' Generating the DoG filters')

midoff=5; midon=11; paroff=61; paron=243;
midoffstd=0.8; midonstd=1.04; paroffstd=8; paronstd=10.4;
parofresol=7; paronresol=7;midonresol=1;midofresol=1;
B{1,1}=-(dog1(midoff, midoffstd,1,0));% the fourth parameter is 0 for unshifted, 1 for shifted dog
B{1,2}= dog1(midon, midonstd, 1,0); % the third parameter is the type of cell: 1 for midget, 2 for parasol
B{1,3}=-(dog1(paroff, paroffstd,2,0));
B{1,4} = dog1(paron, paronstd, 2,0);
B{1,5} = -(dog1(midoff, midoffstd,1,1));
B{1,6} = dog1(midon, midonstd, 1,1);
B{1,7}=-(dog1(paroff, paroffstd,2,1));
B{1,8} = dog1(paron, paronstd, 2,1);

disp('Generating the coefficient matrices')

C{1,1} = midconv1(A,midofresol,midoff, midoffstd,1,1,0); % the last parameter is 0 showing no shift in dog
C{1,2} = midconv1(A,midonresol,midon, midonstd,1,2,0);
C{1,3} = midconv1(A,parofresol,paroff, paroffstd,2,1,0);
C{1,4} = midconv1(A,paronresol,paron, paronstd,2,2,0);
C{1,5} = midconv1(A,midofresol,midoff, midoffstd,1,1,1);
C{1,6} = midconv1(A,midonresol,midon, midonstd,1,2,1);
C{1,7} = midconv1(A,parofresol,paroff, paroffstd,2,1,1);
C{1,8} = midconv1(A,paronresol,paron, paronstd,2,2,1);


%% creating three different matrices: to hold 1) the coefficient values
%% 2) The filter scale and 3) the spatial location corresponding to
%% each coefficient
%% Functions used: c_ind2sub, reduce

T1 = 0;  I1 = 0;J1 = 0;  %%%  Initialization of variables

for dog_ind = 1 : dogsc
    [T1,I1,J1] = reduce(C{1,dog_ind},T1,I1,J1,dog_ind);
end

disp('Gathering the coefficients and remembering their respective indices')

P = transpose(T1(:));
[M,marker] = sort(P);%sorts in ascending order,
%M has the sorted values whereas marker has the indices
M1=fliplr(M);%now the sort is in descending order
marker1=fliplr(marker);%the indices are also arranged accordingly
indx1=find(M1~=0);
cfs=M1(indx1);
S2=marker1(indx1);
lencfs = length(cfs);

[SC1,SUB1] = c_ind2sub(dogsc,S2);

toc

disp('Going for overlap correction')
%%%%%  Going for overlap correction  %%%%%%%%%%%%%%%%%
%% Functions used overlapcorwith8filters, c_ind2sub
tic

for i=1:(lencfs - 1)
    
    
    
    cfthr1=zeros(1,(lencfs-i));
    cfthr3=zeros(1,(lencfs-i));cfthr2=zeros(1,(lencfs-i));
    colind=zeros(1,(lencfs-i));colind2=zeros(1,(lencfs-i));
    
    cfthr1=overlapcorwith8filters( ma, na, i, lencfs, SC1, SUB1, I1, J1,  cfs, B{1,1}, B{1,2}, B{1,3}, B{1,4}, B{1,5}, B{1,6}, B{1,7}, B{1,8});
    
    
    
    [cfthr2,colind]=sort(cfthr1);
    cfthr3=fliplr(cfthr2);
    colind2 = fliplr(colind);
    cfs((i+1) : end) = cfthr3;
    
    ntemp=0;
    ntemp=S2(colind2+i);
    S2((i+1):end)=ntemp;
    
    
    SC1=0; SUB1=0;
    
    [SC1,SUB1] = c_ind2sub(dogsc,S2);
    
end


toc



disp('going on for reconstruction');
%%  Going for reconstruction  %%%%%%%%%%%%%%%%%
%% Function used: expsobelmod, giveback, preproc



tic
perc=0.35;
thresh = round(perc * lencfs);
R = zeros(ma,na);
Q=zeros(1,thresh);


for i = 1:thresh
    
    rowr = I1(SC1(i),SUB1(i));
    columnr = J1(SC1(i),SUB1(i));
    
    R = giveback(R,B{1,SC1(i)},cfs(i),rowr,columnr);
    R1=preproc(R);
    
    
   
    Q(i)=expsobelmod(A1,R1);
 
    
end
fout = sprintf('./QandR_for_coefficient.mat');
save (fout,'Q','R1','cfs','SC1','SUB1','S2')
disp('FILE SAVED SUCCESSFULLY')
toc



disp('End time is:   ')
clock
exit
