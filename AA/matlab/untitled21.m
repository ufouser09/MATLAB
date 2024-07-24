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
A = 0.8;
M = 4;
H(1) = 1;
for n = 1 : 1 : M
    H(400*n+1) = A*n;
end
X1 = A*X1
X2 = A*X2
for n=1:M
    for k=1:M
        if(n-400*k>=1)
            Y1(n)=X1(n)+n*X1(n-400*k)
            Y2(n)=X2(n)+n*X2(n-400*k)
        end
    end
end
V=Y1.';
My_Y1 = my_conv(V,length(V),H,length(H));
My_Y1=My_Y1(:);

V=Y2.';
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

x = input('İlk işaretin elemanlarını [ ] kullanarak giriniz :');
at = input('İlk işaretin zaman indislerini [ ] kullanarak giriniz :');
h = input('İkinci işaretin elemanlarını [ ] kullanarak giriniz :');
bt = input('İkinci işaretin zaman indislerini [ ] kullanarak giriniz  :');
  
% Sending parameters to a separate function
[y, ny] = my_conv(x, at, h, bt);
y1n=conv(x,h);
  
figure;
subplot(1,2,1);
stem(ny, y);
title('My Convolution');
fprintf("My Convolution Vektorel:\n");
disp(y);
disp(ny);

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
function [y, ny] = my_conv(x, at, h, bt)
    nybegin = at(1) + bt(1);
    nyend = at(length(at)) + bt(length(bt));
    ny = nybegin : nyend;
      
    % Calling a function within a function
    y = calconv(x, h);
end
  
% Here is where the summation is calculated
function [y] = calconv(x, h)
    l1 = length(x);
    l2 = length(h);
    N = l1 + l2 - 1;
    for n = 1 : 1 : N
        y(n) = 0;
        for k = 1 : 1 : l1
            if(n - k + 1 >= 1 && n - k + 1 <= l2)
                y(n) = y(n) + x(k) * h(n - k + 1);
            end
        end
    end
end