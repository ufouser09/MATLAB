x = input('x fonksiyonunun değerlerini girin:');
rx = input('x fonksiyonunun başlangıcı:'):input('x fonksiyonunun bitişi:');
%x fonksiyonunun değerleri, başlangıç ve bitiş noktaları alınır.
h = input('h fonksiyonunun değerlerini girin:');
rh = input('h fonksiyonunun başlangıcı:'):input('h fonksiyonunun bitişi:');
%h fonksiyonunun değerleri, başlangıç ve bitiş noktaları alınır.
ry = rx(1)+rh(1):rx(end)+rh(end);
y1=1:length(ry);
%y fonksiyonunun uzunluğu tanımlanır.
for i=1:length(ry)
    y1(i)=0;
    for j=i:-1:1
        if (j<=length(x)) && ((i-j+1)<=length(h))
            y1(i)=y1(i)+x(j)*h(i-j+1);
        end
    end
    
end
%döngü içinde sayılar çarpılarak toplanır ve y dizisine değerler atanır.
subplot(2,1,1);
stem(ry,y1),title('Hazır olmayan fonksiyonla konvolüsyon'),ylabel('y1[t]'),xlabel('t');

y2 = conv(x,h);
subplot(2,1,2);
stem(ry,y2),title('Hazır fonksiyonla konvolüsyon'),ylabel('y2[t]'), xlabel('t');
%elde edilen değerler ile hazır fonksiyondan elde edilen değerlerin grafiği
%bastırılır.