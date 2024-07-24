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
A = 0.8;
m = input("m girin:");
for k=1 : m
    H(400*k+1) = A*k;
end

V=X1.';
My_Y1 = my_conv(V,length(V),H,length(H));
My_Y1=My_Y1(:);
Mtlab_Y1 = conv(V,H);

V=X2.';
My_Y2 = my_conv(V,length(V),H,length(H));
My_Y2=My_Y2(:);
Mtlab_Y2 = conv(V,H);
clc;
disp('Normal ilk ses');
sound(X1);
pause(5);
disp('Normal ikinci ses');
sound(X2);
pause(5);
disp('my_conv ses 1');
sound(My_Y1);
pause(5);
disp('matlab conv ses 1');
sound(Mtlab_Y1);
pause(5);
disp('my_conv ses 2');
sound(My_Y2);
pause(5);
disp('matlab conv ses 2');
sound(Mtlab_Y2);
pause(5);
%%
%%ses bitti

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
    nybegin = at(1) + bt(1)-1;
    nyend = at(length(at)) + bt(length(bt))-1;
    ny = nybegin : nyend;
      
    % Calling a function within a function
    y = calconv(x, h);
end
  
% Here is where the summation is calculated
function [result] = calconv(x, conv)
    l1 = length(x);
    l2 = length(conv);
    conv_siz = l1 + l2 - 1;
    result = zeros(1,conv_siz);
    for n = 1 : 1 : conv_siz
        result(n) = 0;
        for k = 1 : 1 : l1
            if(n - k + 1 >= 1 && n - k + 1 <= l2)
                result(n) = result(n) + x(k) * conv(n - k + 1);
            end
        end
    end
end