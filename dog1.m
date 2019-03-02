%% Code used in Thesis: Information Recovery from Rank-order encoded Images.
% Basabdatta Sen Bhattacharya, Supervisor: Prof Steve Furber
% School of Computer Science, University of Manchester 2008
% 
function D1 = dog1(n,v,p,shift)


%% off-centre midget:
% n=3; v=0.02;p=1;

% % on centre midget:
% n=3; v=0.04;p=1;

% % off-centre parasol:
% n=3; v=.2; p=2;

% % on-centre parasol
% n=3; v=.4; p=2;

nr =floor(n/2); %half the width of the gaussian on the x -axis

if (p==1)
t = 6.5*v; %standard deviation for surround for midget
elseif (p==2)
t = 4.8 * v; % standard deviation for the parasol
else
% display(' going to default centre surround structure measurements');
t = 3 * v;
end


% Matrix H is the Gaussian for the center
% Matrix K is the Gaussian for the surround


 [x,y] = ndgrid(-nr:nr,-nr:nr);
      H  = 10*(1/(2 * pi * v^2)) * exp(-(x.^2 + y.^2)/(2* (v^2)));
      K  = 10*(1/(2 * pi * t^2)) * exp(-(x.^2 + y.^2)/(2* (t^2)));
   

s1 = sum(sum(H)); s2 = sum(sum(K));

% Matrix D is the Dog filter representing the ON center Ganglion cells

D = ((s2 * H) - (s1 * K)); % manipulated to make the integral over D zero for any value of the standard deviation
s3=sum(sum(D));
S1 = sqrt(sum(sum(D .^ 2)));

start=ceil(n/2);
shifted_d = circshift(D,[-start  start]);
shifted_sum = sqrt(sum(sum(shifted_d .^ 2)));

if (shift==1)
D1 = shifted_d ./ shifted_sum;
else
D1 = D ./ S1;
end

S2 = sum(sum(D1 .^ 2));

