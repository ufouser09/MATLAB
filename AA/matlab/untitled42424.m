



%%5 saniye ses kaydetme
recObj = audiorecorder;
disp('Speak for 5 Seconds');
recordblocking(recObj,5);
disp('Kayıt Sona Ermiştir');
X1 = getaudiodata(recObj);
%%10 saniye ses kaydetme
recObj1 = audiorecorder;
disp('Speak for 10 Seconds');
recordblocking(recObj1,10);
disp('Kayıt Sona Ermiştir');
X2 = getaudiodata(recObj1);
H = zeros(1,length(X1));
%%4.soru
H(1) = 1;
H(401) = 0.4*1;
H(801) = 0.4*1;
V=X1.';
My_Y1 = my_conv(V,length(V),H,length(H));
My_Y1=My_Y1(:);
V=X2.';
My_Y2 = my_conv(V,length(V),H,length(H));
My_Y2=My_Y2(:);
%%sesleri dinleriz
disp('5 Saniyelik Normal Ses Kaydı :');
sound(X1);
pause(5);
disp('10 Saniyelik Normal Ses Kaydı :');
sound(X2);
pause(5);
disp('5 Saniyelik Konvülasyona Sokulmuş Ses Kaydı :');
sound(My_Y1);
pause(5);
disp('10 Saniyelik Konvülasyona Sokulmuş Ses Kaydı :');
sound(My_Y2);
pause(5);

%% KULLANICIDAN KONVOLÜSYON ALMA

x = input('[]kullanarak ilk sinyalin elemanlarını giriniz :');
xx = input('[]kullanarak ilk sinyalin zaman indislerini giriniz :');
h = input('[]kullanarak ikinci sinyalin elemanlarını giriniz :');
hh = input('[]kullanarak ikinci sinyalin zaman indislerini giriniz  :');
  
% FUNCTİON 
[y, ny] = convv(x, xx, h, hh);
y1n=conv(x,h);



%%
figure;
subplot(1,4,1);
stem(ny, y);
title('KONVOLÜSYONUM');
fprintf("VEKTÖREL KONVOLÜSYONUM:\n");
disp(y);
disp(ny);
xlabel('ZAMAN ');
ylabel('GENLİK');

figure(1);
subplot(1,4,2);
stem(ny,y1n);
title('MATLAB KONVOLÜSYONU');
xlabel('TİME');
ylabel('AMPLİTUDE');
fprintf("VEKTÖREL MATLAB KONVOLÜSYONU:\n");
disp(y1n);
disp(ny);
subplot(1,4,3);
stem(xx,x); 
title('X');
xlabel('TİME');
ylabel('AMPLITUDE');
subplot(1,4,4);
stem(hh,b); 
title('Y');
xlabel('TİME');
ylabel('AMPLİTUDE');

%%



% sinyalimin range ini buluyor
function [y, ny] = convv(x, xx, h, hh)
    nybegin = xx(1) + hh(1);
    nyend = xx(length(xx)) + hh(length(hh));
    ny = nybegin : nyend;
      
    % Konvülasyonu Hesaplayacak Fonksiyonumuzu Çağırıyoruz
    y = calconv(x, h);
end
  
%Konvülasyon Hesabı Yapıyoruz
function [y] = calconv(x, h)
    la = length(x);
    lb = length(h);
    N = la + lb - 1;
    for i = 1 : 1 : N
        y(n) = 0;
        for j = 1 : 1 : la
            if(i - j + 1 >= 1 & i - j + 1 <= lb)
                y(i) = y(i) + x(j) * h(i - j + 1);
            end
        end
    end
end


