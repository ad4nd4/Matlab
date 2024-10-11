function [num] = float2num(bin, type)
S = bin(1);
E_str = "";
F_str = "";
if type == 32
    E_str = bin(2:9),
    F_str = bin(10:32),              %Wydzielenie eksponenty i ułamka
else
    E_str = bin(2:12);
    F_str = bin(13:64);
end
E_sum = 0;
for n=1:length(E_str)
    E_sum = E_sum + str2num(E_str(length(E_str) - n + 1))*2^(n-1);        
end
F_sum = 0;
for n=1:length(F_str)
    F_sum = F_sum + str2num(F_str(n))*2^(-n);
end
E = E_sum - (2^(length(E_str)-1) - 1);
F = 1 + F_sum;
num = (-1)^S*F*2^E;