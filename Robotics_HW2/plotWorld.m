function plotWorld(world,path)
  % the first element is the north coordinate
  % the second element is the south coordinate

  N = 10;
  th = [0:2*pi/N:2*pi];
  figure(1), clf
  axis([world.SWcorner(2),world.NEcorner(2),...
      world.SWcorner(1), world.NEcorner(1)]);
  hold on
  
  for i=1:world.NumObstacles,
      X = world.radius(i)*sin(th) + world.ce(i);
      Y = world.radius(i)*cos(th) + world.cn(i);
      fill(X,Y,'b');
  end
  
  X = path(:,2);
  Y = path(:,1);
  plot(X,Y,'r');
