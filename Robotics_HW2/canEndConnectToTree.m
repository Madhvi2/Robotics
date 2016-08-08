function flag = canEndConnectToTree(tree,end_node,minDist,world);
  flag = 0;
  % check only last node added to tree since others have been checked
  if ( (norm(tree(end,1:2)-end_node(1:2))<minDist)...
     & (collision(tree(end,1:2), end_node(1:2), world)==0) ),
    flag = 1;
  end