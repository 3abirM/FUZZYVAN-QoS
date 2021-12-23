%This function aims to obtain an array of the neighbor nodes

function [distance,neighbors,neighborscount,count,overspeed,tot]=FindNeighbors(numberofnodes,x,y,TR,time)

 distance=zeros(numberofnodes,numberofnodes);
     neighbors=zeros(numberofnodes,numberofnodes);
     neighborscount=zeros(numberofnodes,1);
     acceleration=zeros(numberofnodes);
     count=0;
     
     minSpeed=80;
     maxSpeed=120;
avgVel=(minSpeed+maxSpeed)/2;
avgSpeed=((minSpeed+maxSpeed)/2)/100;

overspeeding=0;
total=0;
vlc=0;
       

 for i=1:numberofnodes
     
     a=0;
       % b=50;
       b=500;
%      coordinate=round(a+(b-a).*rand(numberofnodes,2));
      x=round(a+(b-a).*rand(numberofnodes,1));
      y=round(a+(b-a).*rand(numberofnodes,1));
 

    velocity(i)=(80+(100-80).*rand(1,1)); 
    
    VelPercentage(i)=((velocity(i)*100)/avgVel)/100;
    
   
    total=total+1;
    %disp('avg:');
    %disp(avgSpeed);
    %disp('vel%:');
    %disp(VelPercentage(i));
    if VelPercentage(i)>avgSpeed     
      overspeeding=overspeeding+1;  
    end
   
 end

 vlc=mean(VelPercentage);
 randomPoints=zeros(overspeeding); 
 
 num=0;
 res=1;
 
 
 for i=1:overspeeding
 %for i=1:numberofnodes
     
       if time==0
           acceleration(i)=0;
       else
       acceleration(i)=velocity(i)/time;
       end
      
       
       %Those two sentences are used exclusively for the over/under
       %speeding model to modify the position of the vehicles according to
       %their new velocities
       x(i)=(x(i)+VelPercentage(i)*time)+0.5*(acceleration(i)*(time*time));
       y(i)=(y(i)+VelPercentage(i)*time)+0.5*(acceleration(i)*(time*time));
      
 end
 
   for i=1:numberofnodes
    for j=1:numberofnodes
      
        distance(i,j)=sqrt((x(j)-x(i))*(x(j)-x(i))+(y(j)-y(i))*(y(j)-y(i)));
      
        if(distance(i,j)<TR && i~=j) 
         
            neighbors(i,j)=1;
            neighborscount(i)=neighborscount(i)+1;
            count=count+1;
       
        end
        

    end
   end
   
   overspeed=mean(overspeeding);
   tot=mean(total);

return;