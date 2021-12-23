axis([0 2001 0 2001]);
hold on; 
NumOfNodes = 100;
Range = 15;
breadth = 0; 
display_node_numbers = 1;
d=0;
e=1;

 
%%%%%%%%%%%%creating road network%%%%%%%%%
for length = 0:2000
    if(rem(length,10)~=0)
        for breadth = 0:2000
            if(rem(breadth,10)~=0)
                h1 = plot(length,breadth,':g');
            end
        end   
    end
    breadth = breadth+1; 
end
%%%%%%%%%%%%%%%%END1%%%%%%%%%%%%%%%%%%%%%%%%%%
Node = zeros(NumOfNodes,6); % 1:X, 2:Y, 3:updatedX, 4:updatedY, 5:direction
%%%%%%%%%%%%%%%%%%%%%get random nodes%%%%%%%%%%%%%%%%%
for node_index = 1:NumOfNodes
    TempX = randint(1,1,[0,2000]); 
    if (rem(TempX,10)==0)
        sprintf('TempX = %d\n',TempX);
        Node(node_index,1) = TempX;       %X co-ordinate in 1st column
        Node(node_index,2) = randint(1,1,[0,2000]); %Y co-ordinate in 2nd column
        sprintf('%d IF: X=%d Y=%d',node_index, Node(node_index,1),Node(node_index,2))
    else
        Node(node_index,2) = 20*(randint(1,1,[0,10])); %Y co-ordinate in 2nd column 
        Node(node_index,1) = randint(1,1,[0,2000]); %X co-ordinate
        sprintf('%d ELSE: X= %d Y= %d',node_index, Node(node_index,1),Node(node_index,2))
    end
end
%sprintf('Number of Nodes %d',NumOfNodes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%labels = cell2str(num2str([1:NumOfNodes]'));
%h1 = ones(NumOfNodes,1);
h2 = ones(NumOfNodes,1);
h3 = ones(NumOfNodes,1);
distance=zeros(NumOfNodes,NumOfNodes);

neighbors=zeros(NumOfNodes,NumOfNodes);
     neighborscount=zeros(NumOfNodes,1);
for n = 0:2000
    
  

    % time =(d+(e-d).*randint(NumOfNodes,1));
    for node_index = 1:NumOfNodes
        count=0;
        if(rem(Node(node_index,1),10)~=0)
            %h2(node_index) = plot(Node(node_index,1)+n, Node(node_index,2),'.r');
            h2(node_index) = plot(Node(node_index,1)+n*(2*(rem(node_index,2))-1), Node(node_index,2),'.k');
            Node(node_index,3) = Node(node_index,1)+n*(2*(rem(node_index,2))-1); 
            Node(node_index,4) = Node(node_index,2);
            Node(node_index,5) = rem(node_index,2)+2;
        else
            h2(node_index) = plot(Node(node_index,1),Node(node_index,2)+n*(2*(rem(node_index,2))-1),'.k');
            Node(node_index,3) = Node(node_index,1);
            Node(node_index,4) = Node(node_index,2)+n*(2*(rem(node_index,2))-1);
            Node(node_index,5) = rem(node_index,2);
        end
        
      for j=1:NumOfNodes
      
        distance(node_index,j)=sqrt((Node(j,3)-Node(node_index,3))*(Node(j,3)-Node(node_index,3))+((Node(j,4)-Node(node_index,4))*(Node(j,4)-Node(node_index,4))));
      
        if(distance(node_index,j)<Range && node_index~=j) 
         
            neighbors(node_index,j)=1;
            neighborscount(node_index)=neighborscount(node_index)+1;
            count=count+1;
       
        end
        
      end
   disp(count)
    end
%     for p = 1:NumOfNodes
%         for q = 1:NumOfNodes
%             if(p~=q) 
%                 if((abs(Node(q,3)-Node(p,3))<=Range) && (abs(Node(q,4)-Node(p,4))<=Range))
%                     if(Node(q,5) ~= Node(p,5))
%                         plot(Node(p,3),Node(p,4),'xb');
%                         if(((rem(Node(p,3),10))<=Range-1) && ((rem(Node(p,4),10))<=Range-1))
%                             plot(Node(q,3),Node(q,4),'or')
%                         end
%                     end
% 
%                 end
%             end
%         end
%     end
    
     
        
    
    pause(0.1); 
    set(h2(),'Visible','off');
end
