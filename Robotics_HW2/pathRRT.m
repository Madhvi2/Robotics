function pathRRT;

% create random world
Size = 100;
NumObstacles = 100;
world = createWorld(NumObstacles,[Size; Size],[0;0]);

% standard length of path segments
segmentLength = 5;

% randomly select start and end nodes
start_node = generateRandomNode(world);
end_node   = generateRandomNode(world);

% establish tree starting with the start node
tree = start_node;

% check to see if start_node connects directly to end_node
if ( (norm(start_node(1:2)-end_node(1:2))<segmentLength )...
    &(collision(start_node,end_node,world)==0) )
  path = [start_node; end_node];
else
  numPaths = 0;
  while numPaths<1,
      [tree,flag] = extendTree(tree,end_node,segmentLength,world);
      numPaths = numPaths + flag;
  end
end

% find path with minimum cost to end_node
path = findMinimumPath(tree,end_node);
plotWorld(world,path);