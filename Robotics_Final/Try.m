function Try

    x_start=10;
    y_start=10;
    
    psi=0;
   
    figure(1);hold on;axis equal;grid on;axis([-20 150 -20 150])
    plot([0 100],[0 0],'b','Linewidth',2);hold on
    plot([100 100],[0 100],'b','Linewidth',2);hold on
    xlabel('x');ylabel('y');
    flag=0;
  
    while(1) 
    %while(counter<=3) 
        
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
        %plot([x_start x_new],[y_start y_new],'bo');hold on
        value=angle-psi;
        disp(value)
        
           
        
        x_old_start=x_start;
        y_old_start=y_start;

        % Updation of x distance and y distance to be travlled by the robot 
        x_start=x_old_start+2*cos(value);
        y_start=y_old_start+2*sin(value);
        %psi=value;
        plot([x_old_start x_start],[y_old_start y_start],'ko-');hold on
        dis=sqrt((x2-x_start)^2+(y2-y_start)^2);
            if((dis<=3))
               flag=1;
            end
            if((flag==1)&&(dis<=3))
                break
            end
    end
    

end







% % calculation of desired heading angle
% function value,x_new,y_new = pathdesign(x1,x2,y1,y2,psi,x_start,y_start)
%     R_u=sqrt((x1-x_start)^2+(y1-y_start)^2);
%     theta=atan2((y2-y1),(x2-x1));
%     theta_u=atan2((y_start-y1),(x_start-x1));
%     beta=theta-theta_u;
%     R=sqrt((R_u)^2-(R_u*sin(beta))^2);
%     delta=8;
%    % K=0.1;
%     x_new=(R+delta)*cos(theta);
%     y_new=(R+delta)*sin(theta);
%     angle=atan2((y_new- y_start),(x_new-x_start));
%     %plot([x_start x_new],[y_start y_new],'bo');hold on
%     value=angle-psi;
% end