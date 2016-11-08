%% Programa 2
clear all;
clc
rad  = pi/180;
grad = 180/pi;

d=2;
do=d/2;
M=8;
l=M*d;
k=1;
angini=45;
fase=0;
%i=1:1:M;

paso=0;

for fase=0:36:1440  %realizar for para cambiar de la fase
    for i=1:1:(M+1)
        ang(i)= angini*cos(fase*rad+(((2*pi*k)/M)*(i-1)))
        angdob(i)=-(2*angini*sin(pi*k/M)*sin(fase*rad+((2*pi*k)/M)*((i-1)+(do/d))))
        servo(i)=round(((200/18)*angdob(i))+(1500))
        if i==1
           x(i)= do*cos(angini*rad);
           y(i)= do*sin(angini*rad);
        elseif i==(M+1)
           x(i)= x(i-1)+do*cos(ang(i)*rad);
           y(i)= y(i-1)+do*sin(ang(i)*rad);
        else
           x(i)= x(i-1)+d*cos(ang(i)*rad);
           y(i)= y(i-1)+d*sin(ang(i)*rad);     
        end
    end
    %x=[0 x]
    %y=[0 y]
    if min(y)<0
        %yini = (((angini*cos(fase*rad+(((2*pi*k)/M))))*rad));
        y = [y+abs(min(y))];
        %y=[yini y]
    else
        %yini = (((angini*cos(fase*rad+(((2*pi*k)/M))))*rad));
        y = [y-abs(min(y))];
        %y=[yini y]
    end
    
    
    figure(1)
    plot(x,y)
    hold on;
    plot(x,y,'bs','LineWidth',3,'MarkerEdgeColor','r','MarkerfaceColor','r','MarkerSize',5);
    
%     cx=[6-paso 6-paso 8-paso 8-paso];                                                           %El fondo
%     cy=[0 4 4 0];
%     paso = paso+0.05;
%     if paso > 20
%        paso=0; 
%     end
%     hold on;
%     plot(cx,cy,'g','LineWidth',3);
    
    axis([-2 (l+5) -2 6])
    xlabel('EJE X(m)')
    ylabel('EJE Y(m)')
    title ('CONTROL CINEMATICO SERPIENTE CON 4 GDL')
    grid;
    hold off;
    clear x
    clear y
    pause(0.2);
end
%figure(2)
%plot(x,ang,'gs','LineWidth',3,'MarkerEdgeColor','y','MarkerfaceColor','y','MarkerSize',5);