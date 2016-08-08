xmin=0.8;
xmax=4;
n=10;
x=xmin+rand(1,n)*(xmax-xmin);
ymin=0.8;
ymax=4;
y=ymin+rand(1,n)*(ymax-ymin);
data=[x
    y];
data=data';
[v,c] = voronoin(data);
node1=[];
node2=[];
for i=1:length(c)
    for j=1:length(c{i})
            if(j<length(c{i}))
            temp1=(c{i}(j));
            temp2=(c{i}(j+1));
            if ~(temp1==1||temp2==1)
                node1=[node1 temp1 temp2];
                node2=[node2 temp2 temp1];
            end
            end
            if(j==length(c{i}))
                temp1=(c{i}(1));
                temp2=(c{i}(length(c{i})));
                if ~(temp1==1||temp2==1)
                    node1=[node1 temp1 temp2];
                    node2=[node2 temp2 temp1];
                end
            end
            
        
        
    end
        
end

S=sparse(node1,node2,8);

source_x=xmin+rand(1,1)*(xmax-xmin);
source_y=ymin+rand(1,1)*(ymax-ymin);
 
goal_x=xmin+rand(1,1)*(xmax-xmin);
goal_y=ymin+rand(1,1)*(ymax-ymin);

diff_x = (source_x-v(:,1));
diff_y=source_y-v(:,2);
diff= sqrt(diff_x.^2+diff_y.^2);
[min_distance,index]=sort(diff);
Index_to_join=index(1);

diff1_x = (goal_x-v(:,1));
diff1_y=goal_y-v(:,2);
diff1= sqrt(diff1_x.^2+diff1_y.^2);
[min_distance1,index1]=sort(diff1);
Index_to_join1=index1(1);


h= (biograph(S));
[dist,path,pred] = shortestpath(h,Index_to_join,Index_to_join1,'Directed','False');
disp(dist);
disp(path);


plot(x(1,:),y(1,:),'blueo','LineWidth',2);hold on
voronoi(data(:,1),data(:,2));hold on;
plot(source_x,source_y,'redo','Linewidth',2);hold on
plot(goal_x,goal_y,'greeno','Linewidth',2);

x_temp=[];
y_temp=[];
for i=1:length(path)
    if(i+1<=length(path))   
        node_1=path(i);
        node_2=path(i+1);
        initial_node_x=v(node_1,1);
        initial_node_y=v(node_1,2);
        final_node_x=v(node_2,1);
        final_node_y=v(node_2,2);
        x_temp=[initial_node_x;final_node_x];
        y_temp=[initial_node_y;final_node_y];
        plot(x_temp,y_temp,'ko--','Linewidth',4);
        
        if(i==1)
            x_temp=[source_x;initial_node_x];
            y_temp=[source_y;initial_node_y];
            plot(x_temp,y_temp,'ko--','Linewidth',4);
        end   
        
        if(i+1==length(path-1))
            x_temp=[goal_x;final_node_x];
            y_temp=[goal_y;final_node_y];
            plot(x_temp,y_temp,'ko--','Linewidth',4);  
        end
     end
end


