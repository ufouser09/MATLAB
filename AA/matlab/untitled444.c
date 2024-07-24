% Matlab program to implement
% the above approach
%% 5 saniye ses kaydetme
recObj = audiorecorder;
disp('Start speaking.');
recordblocking(recObj,5);
disp('End of recording');
X1 = getaudiodata(recObj);

recObj1 = audiorecorder;
disp('Start speaking.');
recordblocking(recObj1,10);
disp('End of recording');
X2 = getaudiodata(recObj1);
H = zeros(1,length(X1));
H(1) = 1;
H(401) = 0.4*1;
H(801) = 0.4*1;
V=X1.';
My_Y1 = my_conv(V,length(V),H,length(H));
My_Y1=My_Y1(:);

V=X2.';
My_Y2 = my_conv(V,length(V),H,length(H));
My_Y2=My_Y2(:);
clc;
disp('S1');
sound(X1);
pause(5);
disp('S2');
sound(X2);
pause(5);
disp('S3');
sound(My_Y1);
pause(5);
disp('S4');
sound(My_Y2);
pause(5);

x = input('x fonksiyonunun değerlerini girin:');
rx = input('x fonksiyonunun başlangıcı:'):input('x fonksiyonunun bitişi:');
%x fonksiyonunun değerleri, başlangıç ve bitiş noktaları alınır.
h = input('h fonksiyonunun değerlerini girin:');
rh = input('h fonksiyonunun başlangıcı:'):input('h fonksiyonunun bitişi:');
  
% Sending parameters to a separate function
[y, y1] = my_conv(x, rx, h, rh);
y1n=conv(x,h);
  
figure;
subplot(1,2,1);
stem(y1n, y);
title('My Convolution');
fprintf("My Convolution Vektorel:\n");
disp(y);
disp(y1n);

%%matlab conv
figure(1);
xlabel('ZAMAN ');
ylabel('GENLİK');

subplot(1,2,2);

stem(ny,y1n);
title('Matlab Convolution');
xlabel('ZAMAN');
ylabel('GENLİK');
fprintf("Matlab Convolution Vektorel:\n");
disp(y1n);
disp(ny);
  
% Function to find the length of our output
function [y,y1n] = my_conv(x, rx, h, rh)
    ry = rx(1)+rh(1):rx(end)+rh(end);
   y1n=1:length(ry);
      
    % Calling a function within a function
    y = calconv(x, h);
end
  
% Here is where the summation is calculated
function [y1] = calconv(x, h)
    for i=1:length(ry)
    y1(i)=0;
    for j=i:-1:1
        if (j<=length(x)) && ((i-j+1)<=length(h))
            y1(i)=y1(i)+x(j)*h(i-j+1);
        end
    end
    end
end