function path = findMinimumPath(tree,end_node);
    
    % find nodes that connect to end_node
    connectingNodes = [];
    for i=1:size(tree,1),
        if tree(i,3)==1,
            connectingNodes = [connectingNodes; tree(i,:)];
        end
    end

    % find minimum cost last node
    [tmp,idx] = min(connectingNodes(:,4));
    
    % construct lowest cost path
    path = [connectingNodes(idx,:); end_node];
    parent_node = connectingNodes(idx,5);
    while parent_node>1,
        parent_node = tree(parent_node,5);
        path = [tree(parent_node,:); path];
    end
    