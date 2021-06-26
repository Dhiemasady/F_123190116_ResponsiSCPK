opts = detectImportOptions('realEstate.xlsx'); 
opts.SelectedVariableNames = (3:8); %pilih data dari .xlsx dari kolom 3-8
data = readmatrix('realEstate.xlsx', opts);
data2 = data(1:50,1:3); %data2=baris 1-50, kolom 1-3
data3 = data(1:50,6); %data3=baris 1-50, kolom 6
x = [data2 data3]; %matriks yang berisi gabungan data2 dan 3
k = [0,0,1,0];%atribut tiap-tiap kriteria
w = [3,5,4,1];%Nilai bobot tiap kriteria 

[m n]=size (x); %inisialisasi ukuran x
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i)=prod(x(i,:).^w);
end;

V= S/sum(S)