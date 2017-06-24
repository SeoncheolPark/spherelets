function [label,ncls,centers,innprod,consts,MSE,RegMSE,Xhat,labelhat]=locquad(Xtrain,Xtest,epsilon1,epsilon2,epsilon3,lambda)
   % split data
   label=split(Xtrain,epsilon1,epsilon2);
   % draw all clusters
   ncls=max(label);
   %view(3);
   hold on
   for i=1:ncls
        %figure
        plot(Xtrain(find(label==i),1),Xtrain(find(label==i),2),'*');
        %plot3(Xtrain(find(label==i),1),Xtrain(find(label==i),2),Xtrain(find(label==i),3),'*');
   end
   
   
   % paste pieces together until no two pieces are close
   label=mergeclusters(Xtrain,label,epsilon3,lambda);
   ncls=max(label);
   
    
   
   % assign scattered points to the nearest cluster
   if ncls>0
        is=find(label==-1);
        for j=1:size(is)
            i=is(j);
            dist=zeros(ncls,1);
            for k=1:ncls
                index=find(label==k);
                cls=Xtrain(index,:);
                dist(k)=distance(cls,Xtrain(i,:),lambda);
            end
            ind=min(find(dist==min(dist)));
            label(i)=ind;
        end
   
        % merge again
        label=mergeclusters(Xtrain,label,3*epsilon3,lambda);
        ncls=max(label);

        % store clusters, centers, innerproducts and constants
        centers=zeros(ncls,size(Xtrain,2));
        consts=zeros(ncls,1);
        innprod=zeros(ncls,1);
        %view(3);
        %hold on
        %for i=1:ncls
        %plot(X(find(label==i),1),X(find(label==i),2),'*');
            %plot3(X(find(label==i),1),X(find(label==i),2),X(find(label==i),3),'*');
        %end
        for i=1:ncls
            currentX=Xtrain(find(label==i),:);
            [center,ind,const,SS]=fit(currentX);
            centers(i,:)=center.';
            innprod(i)=ind;
            consts(i)=const;
            %syms x y
            %if ind==-1
                % f(x,y)=(x-center(1))^2+(y-center(2))^2-const^2;
                %xmin=min(currentX(:,1));
                %xmax=max(currentX(:,1));
                %ymin=min(currentX(:,2));
                %ymax=max(currentX(:,2));
                %p=ezplot(f,[xmin,xmax,ymin,ymax]);
                %set(p,'LineWidth',2,'Color', 'black');
                %drawcircles(currentX,center,const);
            %else if ind==1
                %f(x,y)=-(x-center(1))^2+(y-center(2))^2-const^2;
                %xmin=min(currentX(:,1));
                %xmax=max(currentX(:,1));
                %ymin=min(currentX(:,2));
                %ymax=max(currentX(:,2));
                %ezplot(f,[xmin,xmax,ymin,ymax]);
                %else if ind==2
                    % f(x,y)=(x-center(1))^2-(y-center(2))^2-const^2;
                    %xmin=min(currentX(:,1));
                    %xmax=max(currentX(:,1));
                    %ymin=min(currentX(:,2));
                    %ymax=max(currentX(:,2));
                    %ezplot(f);
                    %end
                %end
            %end    
        end
        [MSE,RegMSE,Xhat,labelhat]=Serror(Xtest,label,ncls,centers,innprod,consts);
        %view(3)
        %hold on
        %for i=1:max(labelhat)
            %figure
            %plot(Xhat(find(labelhat==i),1),Xhat(find(labelhat==i),2),'*');
            %plot3(Xhat(find(labelhat==i),1),Xhat(find(labelhat==i),2),Xhat(find(labelhat==i),3),'*');
        %view(3)
        %hold on
        %plot3(Xhat(:,1),Xhat(:,2),Xhat(:,3),'*');
        %plot3(Xtest(:,1),Xtest(:,2),Xtest(:,3),'*');
   end
   
   % if algorithm fails
   if ncls<1
       MSE=Inf;
       centers=[];
       innprod=[];
       consts=[];
       RegMSE=Inf;
       Xhat=Xtest;
       labelhat=zeros(size(Xtest,1),1);
   end
return
