function collision_flag = collision(node, parent, world);

collision_flag = 0;

if ((node(1)>world.NEcorner(1))...
    | (node(1)<world.SWcorner(1))...
    | (node(2)>world.NEcorner(2))...
    | (node(2)<world.SWcorner(2)))
  collision_flag = 1;
else
    for sigma = 0:.2:1,
    p = sigma*node(1:2) + (1-sigma)*parent(1:2);
      % check each obstacle
      for i=1:world.NumObstacles,
        if (norm([p(1);p(2)]-[world.cn(i); world.ce(i)])<=1.5*world.radius(i)),
            collision_flag = 1;
            break;
        end
      end
    end
end
