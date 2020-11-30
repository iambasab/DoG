  
function Qvalue = expsobelmod(I1,J1)


% horsobel=fspecial('sobel');
horsobel = [1 2 1;0 0  0; -1 -2 -1];
versobel=transpose(horsobel);


Aver=midconv(I1,horsobel,1);
Ahor=midconv(I1,versobel,1);
Bver=midconv(J1,horsobel,1);
Bhor=midconv(J1,versobel,1);


Amag=abs(Aver)+abs(Ahor);
Bmag=abs(Bver)+abs(Bhor);

Amag_norm=Amag;
Bmag_norm=Bmag;

    Aang=atan(Ahor ./ Aver);
    Aang(find(isnan(Aang))) = 0;
            
    Bang=atan(Bhor ./ Bver);
    Bang(find(isnan(Bang))) = 0;
    
[ma,na]=size(J1);

for i = 1:ma
for j = 1:na
    
    if (Amag_norm(i,j) > Bmag_norm(i,j))
magdel(i,j) = Bmag_norm(i,j) / Amag_norm(i,j);
else
    if(Bmag_norm(i,j) > Amag_norm(i,j))
magdel(i,j) = Amag_norm(i,j) / Bmag_norm(i,j);

else
    magdel(i,j)=1;
end
end
angdel(i,j) = abs(abs(Aang(i,j) - Bang(i,j)) - (pi / 2)) / (pi / 2);

end
end



a1=11;c1=0.7;a2=24;c2=0.8;

% constant1=inv(sigmf(1,[a1,c1]));
% constant2=inv(sigmf(1,[a2,c2]));
constant1=inv(1/(1+exp(-a1*(1-c1))));
constant2=inv(1/(1+exp(-a2*(1-c2))));

% Qmag=(constant1 * sigmf(magdel,[a1,c1]));
% Qang=(constant2 * sigmf(angdel,[a2,c2]));
Qmag= constant1 * (1./(1+exp(-a1*(magdel-c1))));
Qang= constant2 * (1./(1+exp(-a2*(angdel-c2))));

Q= sqrt( Qmag .* Qang);
threshold=0.2;
Amag_mod= Amag_norm;
Amag_mod(find(Amag_norm < threshold))=0;
Qvalue = (sum(sum(Q.* Amag_mod)))/(sum(sum(Amag_mod)));


