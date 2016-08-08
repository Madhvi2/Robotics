function node=generateRandomNode(world);

% randomly pick configuration
pn       = (world.NEcorner(1)-world.SWcorner(1))*rand;
pe       = (world.NEcorner(2)-world.SWcorner(2))*rand;
chi      = 0;
cost     = 0;
node     = [pn, pe, chi, cost, 0];

% check collision with obstacle
while collision(node, node, world),
  pn       = (world.NEcorner(1)-world.SWcorner(1))*rand;
  pe       = (world.NEcorner(2)-world.SWcorner(2))*rand;
  chi      = 0;
  cost     = 0;
  node     = [pn, pe, chi, cost, 0];
end