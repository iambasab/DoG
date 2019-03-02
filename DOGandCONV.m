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