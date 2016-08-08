function world = createWorld(NumObstacles, NEcorner, SWcorner);

% check to make sure that the region is nonempty
  if (NEcorner(1) <= SWcorner(1)) | (NEcorner(2) <= SWcorner(2)),
      disp('Not valid corner specifications!')
      world=[];
      
  % create world data structure
  else
    world.NumObstacles = NumObstacles;
    world.NEcorner = NEcorner;
    world.SWcorner = SWcorner;
                          
    % create NumObstacles 
    maxRadius = min(NEcorner(1)- SWcorner(1), NEcorner(2)-SWcorner(2));
    maxRadius = 5*maxRadius/NumObstacles/2;
    for i=1:NumObstacles,
        % randomly pick radius
        world.radius(i) = maxRadius*rand;
        % randomly pick center of obstacles
        cn = SWcorner(1) + world.radius(i)...
            + (NEcorner(1)-SWcorner(1)-2*world.radius(i))*rand;
        ce = SWcorner(2) + world.radius(i)...
            + (NEcorner(2)-SWcorner(2)-2*world.radius(i))*rand;
        world.cn(i) = cn;
        world.ce(i) = ce;
    end
  end
  