function [new_tree,flag] = extendTree(tree,end_node,segmentLength,world);

  flag1 = 0;
  while flag1==0,
    % select a random point
    randomPoint = [...
        (world.NEcorner(1)-world.SWcorner(1))*rand,...
        (world.NEcorner(2)-world.SWcorner(2))*rand];

    % find leaf on node that is closest to randomPoint
    tmp = tree(:,1:2)-ones(size(tree,1),1)*randomPoint;
    [dist,idx] = min(diag(tmp*tmp'));
    cost     = tree(idx,4) + segmentLength;
    new_point = (randomPoint-tree(idx,1:2));
    new_point = tree(idx,1:2)+new_point/norm(new_point)*segmentLength;
    new_node = [new_point, 0, cost, idx];
    if collision(new_node, tree(idx,:), world)==0,
      new_tree = [tree; new_node];
      flag1=1;
    end
  end
  
  % check to see if new node connects directly to end_node
  if ( (norm(new_node(1:2)-end_node(1:2))<segmentLength )...
      &(collision(new_node,end_node,world)==0) )
    flag = 1;
    new_tree(end,3)=1;  % mark node as connecting to end.
  else
    flag = 0;
  end