function pathfollow

dT = 2;%time steps size
L = 2;%length of vehicle
SigmaV = 0.1; %3cm/s std on speed
SigmaPhi = 4*pi/180; % steer inaccuracy

%initial knowledge pdf (prior @ k = 0)
P = diag([0.2,0.2,0]);x = [10;10;0];xtrue = x;

Q = diag([SigmaV^2 SigmaPhi^2]);

%initial knowledge pdf (prior @ k = 0)
P = diag([0.2,0.2,0]);x = [10;10;0];xtrue = x;

Q = diag([SigmaV^2 SigmaPhi^2]);


H=[1 0;0 1];
S=diag([0.1,0.1]);

%-------- Set up graphics -----------%
figure(1);hold on;axis equal;grid on;axis([-20 120 -20 120])
plot([0 100],[0 0],'b','Linewidth',2);hold on
plot(10,10,'bo','Linewidth',4);
plot(0,0,'bo','Linewidth',4);
plot(100,0,'bo','Linewidth',4);
plot(100,100,'bo','Linewidth',4);
plot([100 100],[0 100],'b','Linewidth',2);hold on
xlabel('x');ylabel('y');
flag=0;
x_start=10;
y_start=10;
psi=0;
flag_new=0;
counter=1;
a=1;
b=2;

while(1) 
    %Rabbit path follow algorithm
        if(flag==0)
            x1=0;
            y1=0;
            x2=100;
            y2=0;     
        elseif(flag==1)
           x1=100;
           x2=100;
           y1=0;
           y2=100;
           flag_new=1;               
        end        
        
        R_u=sqrt((x1-x_start)^2+(y1-y_start)^2);
        theta=atan2((y2-y1),(x2-x1));
        theta_u=atan2((y_start-y1),(x_start-x1));
        beta=theta-theta_u;
        R=sqrt((R_u)^2-(R_u*sin(beta))^2);
        delta=8;
        x_new=(R+delta)*cos(theta)+x1;
        y_new=(R+delta)*sin(theta);
        angle=atan2((y_new- y_start),(x_new-x_start));
        value=angle-psi;  
        x_old_start=x_start;
        y_old_start=y_start;

        % Updation of x distance and y distance to be travlled by the robot 
        x_start=x_old_start+2*cos(value);
        y_start=y_old_start+2*sin(value);
        
        a=plot([x_old_start x_start],[y_old_start y_start],'mo-');hold on
        dis=sqrt((x2-x_start)^2+(y2-y_start)^2);
        
      
        %Kalman Prediction
        u = [0.8;value];
        JacFx = [1 0 -dT*u(1)*sin(x(3)); 0 1 dT*u(1)*cos(x(3)); 0 0 1-dT];     
        JacFu = [dT*cos(x(3)) 0; dT*sin(x(3)) 0; 0 dT];

        P = JacFx * P *JacFx' + JacFu*Q*JacFu';
        xtrue = AckermannModel(xtrue,u+[SigmaV ;SigmaPhi].*randn(2,1),dT,L);    
        x = AckermannModel(x,u,dT,L);    

        b=plot(x(1), x(2), 'ko-'); hold on;   
        legend([a b],'Black-->Path by Kalman prediction','Magenta-->Path by Rabbit path follow algorithm');
        if((dis<=3))
            flag=1;
        end
        if((flag==1)&&(dis<=3)&&(flag_new==1))
                break;
        end
       
        
end
%------------ MODEL --------------%
function y = AckermannModel(x,u,dT,L)
y(1,1) = x(1) + dT*u(1)*cos(x(3));
y(2,1) = x(2) + dT*u(1)*sin(x(3));
%y(3,1) = x(3) + dT*u(1)/L*tan(u(2));
y(3,1) = x(3) + dT*u(1)*(u(2)-x(3));
     
