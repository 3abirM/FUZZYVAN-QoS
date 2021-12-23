function [distance,energy,nw_liftime,throughput]=UrbanCitySimu()
citysize=100;
NumOfNodes=100;
axis([0 citysize+1 0 citysize+1]);
hold on
blksiz=30;
Eini=1;% in joules
% Range=(3*(blksiz/2))/2;
Range=20;
breadth = 0; 
display_node_numbers = 1;
% src_node=5;
src_node=round(1+(NumOfNodes-1).*rand);
src_node1=src_node;
dst_node=round(1+(NumOfNodes-1).*rand);
% dst_node=35;
%% uicontrol
                H = uicontrol('Style', 'listbox', ...
                    'Units', 'normalized', ...
                    'Position', [0.6 0.2 0.3 0.68], ...
                    'String', {'Path Establishing...'});
                drawnow;
%                 pause(1.0);
%%
%%%%%%%%%%%%creating road network%%%%%%%%%
for len = 0:citysize
    if(rem(len,10)~=0)
        for breadth = 0:citysize
            if(rem(breadth,10)~=0)
                h1 = plot(len,breadth,':g');
            end
        end   
    end
    breadth = breadth+1; 
end
%%%%%%%%%%%%%%%%END1%%%%%%%%%%%%%%%%%%%%%%%%%%
Node = zeros(NumOfNodes,6); % 1:X, 2:Y, 3:updatedX, 4:updatedY, 5:direction
%%%%%%%%%%%%%%%%%%%%%get random nodes%%%%%%%%%%%%%%%%%
for node_index = 1:NumOfNodes
    TempX = randint(1,1,[0,citysize]); 
    if (rem(TempX,10)==0)
        %sprintf('TempX = %d\n',TempX);
        Node(node_index,1) = TempX;       %X co-ordinate in 1st column
        Node(node_index,2) = randint(1,1,[0,citysize]); %Y co-ordinate in 2nd column
        %sprintf('%d IF: X=%d Y=%d',node_index, Node(node_index,1),Node(node_index,2))
    else
        Node(node_index,2) = 10*(randint(1,1,[0,citysize/10])); %Y co-ordinate in 2nd column 
        Node(node_index,1) = randint(1,1,[0,citysize]); %X co-ordinate
        %sprintf('%d ELSE: X= %d Y= %d',node_index, Node(node_index,1),Node(node_index,2))
    end
end
%% Assign Positions to RSUs
m=1;
temp=1472014;
for ii=blksiz/2:2*blksiz:citysize
    n=1;
    for jj=blksiz/2:2*blksiz:citysize
        rsu.position{m,n}=[ii,jj]; % RSU's Position
        rsu.ID{m,n} =  temp;% RSU's ID
        plot(ii,jj,'xr','Linewidth',2)
        text(ii+1,jj, num2str(rsu.ID{m,n}))
        n=n+1;
        temp=temp+1;
    end
    m=m+1;    
end
m=round((citysize/(2*blksiz))+1);
for ii=blksiz/2+blksiz:2*blksiz:citysize
    n=1;
    for jj=blksiz/2+blksiz:2*blksiz:citysize
        rsu.position{m,n}=[ii,jj];% RSU's Position
        rsu.ID{m,n} =  temp;% RSU's ID
        plot(ii,jj,'xr','Linewidth',2)
        text(ii+1,jj, num2str(rsu.ID{m,n}))
        n=n+1;
        temp=temp+1;
    end
    m=m+1;    
end
rsu.origID=rsu.ID;
% combine nodes position and RSU positions in a single matrix
temp=reshape(rsu.position,numel(rsu.position),1);
temp=temp(~cellfun(@isempty, temp)); % delete empty cell in the matrix
for ii=1:numel(temp)
    temp1(ii,:)=temp{ii};
end
node_rsu=[Node;repmat(temp1,1,3)]; % combined matrix for rsu and nodes location
clear temp temp1

%%
%sprintf('Number of Nodes %d',NumOfNodes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%labels = cell2str(num2str([1:NumOfNodes]'));
%h1 = ones(NumOfNodes,1);
h2 = ones(NumOfNodes,1);
h4 = ones(1,1);
counter=1;
for n = 0:citysize
    for node_index = 1:NumOfNodes
        
        if(rem(Node(node_index,1),10)~=0)
            h2(node_index) = plot(Node(node_index,1)+n*(2*(rem(node_index,2))-1), Node(node_index,2),'.k');
               
            node_rsu(node_index,3) = Node(node_index,1)+n*(2*(rem(node_index,2))-1); 
            node_rsu(node_index,4) = Node(node_index,2);
            node_rsu(node_index,5) = rem(node_index,2)+2;
            if node_index==src_node1
                plot(node_rsu(node_index,3), node_rsu(node_index,4),'og');
                h7=text(node_rsu(node_index,3), node_rsu(node_index,4)+1,num2str(src_node1));
%                 hold on
            end
            if node_index==dst_node
                plot(node_rsu(node_index,3), node_rsu(node_index,4),'dm');
                h9=text(node_rsu(node_index,3), node_rsu(node_index,4)+1,num2str(dst_node));
%                 hold on
            end
        else
            h2(node_index) = plot(Node(node_index,1),Node(node_index,2)+n*(2*(rem(node_index,2))-1),'.k');
           
            node_rsu(node_index,3) = Node(node_index,1);
            node_rsu(node_index,4) = Node(node_index,2)+n*(2*(rem(node_index,2))-1);
            node_rsu(node_index,5) = rem(node_index,2);
            if node_index==src_node1
                plot(node_rsu(node_index,3), node_rsu(node_index,4),'og');
                h7=text(node_rsu(node_index,3), node_rsu(node_index,4)+1,num2str(src_node1));
%                 hold on
            end
             if node_index==dst_node
                plot(node_rsu(node_index,3), node_rsu(node_index,4),'dm');
                 h9=text(node_rsu(node_index,3), node_rsu(node_index,4)+1,num2str(dst_node));
%                 hold on
            end
        end
    end
end