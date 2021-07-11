
 function D1 = posdog(n,v)
% Function to calculate the DoG Filter
% n=191;v=8;
nr =floor( n/2); %half the width of the gaussian on the x -axis

t = 3*v; %standard deviation for surround


% Matrix H is the Gaussian for the center
% Matrix K is the Gaussian for the surround


 [x,y] = ndgrid(-nr:nr,-nr:nr);
      H  = (1/(2 * pi * v^2)) * exp(-(x.^2 + y.^2)/(2* (v^2)));
      K  = (1/(2 * pi * t^2)) * exp(-(x.^2 + y.^2)/(2* (t^2)));
   

s1 = sum(sum(H)); s2 = sum(sum(K));

% Matrix D is the Dog filter representing the ON center Ganglion cells

D = (s2 * H) - (s1 * K); % manipulated to make the integral over D zero for any value of the standard deviation
% D = (s2 * H) - ( 4*s1 * K);%used when the images of the filter are to be
%taken - the mult. factor 4 gives a distinct grayshades to the centre and
%surround which, otherwise, is not very clearly demarcated on screen.

%s3 = sum(sum(D));  % added to the code for testing

% D1 is the normalised filter D such that when convolved with itself gives
% a value of 1

S1 = sqrt(sum(sum(D .^ 2)));

D1 = D ./ S1;

S2 = sum(sum(D1 .^ 2));

%  This part of the code was used to generate figures of narrow and wide gaussians used in the
%  continuation report

% V = horzcat(H,K,D);
% V1 = normalize(V,1);
%  H1 = V1(:,1:23);
%  K1 = V1(:,24:46);
%  D2 = V1(:,47:end);
%  
%  subplot(1,2,1);plot(H1(12,:));
%  subplot(1,2,2);plot( K1(12,:));

%These are the commands for generating the mexican hat shape (fig 4.9
%stored as dog11.eps) in the cont. report
 
% n=95; v=4;
% >> posdog(%prior to that D is written as D = (s2 * H) - ( 4 * s1 * K); 
% >> figure(1),plot(D(48,:))
% >> box off
% >> axis off

% The commands used for generating the fig 4.8 in the continuation report
% sre as follows:
% n=47; v=6;
% >> posdog
% >> mesh(H),axis off, box off, grid off