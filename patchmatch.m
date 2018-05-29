function [img]=patchmatch(imgA,imgB,w)
[m,n,l]=size(imgA);
offset=zeros(m-2*w,n-2*w,2);

for i=1+w:m-w   %initilize
    for j=1+w:n-w
        p=randperm(m-2*w);                             
        q=randperm(n-2*w);
        sd1=ssd(imgA(i-w:i+w,j-w:j+w,:),imgB(p(1):p(1)+2*w,q(1):q(1)+2*w,:));
        sd2=ssd(imgA(i-w:i+w,j-w:j+w,:),imgB(p(2):p(2)+2*w,q(2):q(2)+2*w,:));
        sd3=ssd(imgA(i-w:i+w,j-w:j+w,:),imgB(p(3):p(3)+2*w,q(3):q(3)+2*w,:));
        [sdmin,offind]=min([sd1,sd2,sd3]);
        offset(i,j,:)=[p(offind)+w,q(offind)+w];
    end
end
for ir=1:5
    if mod(ir,2)==0  %even
for i=m-w-1:-1:1+w
    for j=n-w-1:-1:1+w
        ib=offset(i,j,1);
        jb=offset(i,j,2);
        ibx=offset(i+1,j,1);
        jbx=offset(i+1,j,2);
        iby=offset(i,j+1,1);
        jby=offset(i,j+1,2);
        d1=ssd(imgA(i-w:i+w,j-w:j+w,:),imgB(ib-w:ib+w,jb-w:jb+w,:));
        dx=ssd(imgA(i-w:i+w,j-w:j+w,:),imgB(ibx-w:ibx+w,jbx-w:jbx+w,:));
        dy=ssd(imgA(i-w:i+w,j-w:j+w,:),imgB(iby-w:iby+w,jby-w:jby+w,:));
        d=[d1 dx dy];
        [dmin,index]=min(d);
        switch index
            case 1
                offset(i,j,:)=offset(i,j,:);
            case 2
                offset(i,j,:)=offset(i+1,j,:);
            case 3
                offset(i,j,:)=offset(i,j+1,:);
        end
        wid=[offset(i,j,1)-1,offset(i,j,2)-1,m-offset(i,j,1)-1,n-offset(i,j,2)-1];
        wth=min(wid);
        is=0;
        v=[offset(i,j,1) offset(i,j,2)];
        a=1/2;
        while (wth*a^is)>=1
            R=2*rand(1,2)-1;
            u=v+(wth*a^is)*R;
            is=is+1;
        end
        u=round(u);
        if u(1)<=w
            u(1)=w+1;
        end
        if u(1)>=m-w
            u(1)=m-w-1;
        end
        if u(2)<=w
            u(2)=w+1;
        end
        if u(2)>=n-w
            u(2)=n-w-1;
        end
        offset(i,j,1)=u(1);
        offset(i,j,2)=u(2);
        imgA(i,j,:)=imgB(u(1),u(2),:);    
    end
end      
        else
 for i=2+w:m-w  %odd
    for j=2+w:n-w
        ib=offset(i,j,1);
        jb=offset(i,j,2);
        ibx=offset(i-1,j,1);
        jbx=offset(i-1,j,2);
        iby=offset(i,j-1,1);
        jby=offset(i,j-1,2);
        d1=ssd(imgA(i-w:i+w,j-w:j+w,:),imgB(ib-w:ib+w,jb-w:jb+w,:));
        dx=ssd(imgA(i-w:i+w,j-w:j+w,:),imgB(ibx-w:ibx+w,jbx-w:jbx+w,:));
        dy=ssd(imgA(i-w:i+w,j-w:j+w,:),imgB(iby-w:iby+w,jby-w:jby+w,:));
        d=[d1 dx dy];
        [dmin,index]=min(d);
        switch index
            case 1
                offset(i,j,:)=offset(i,j,:);
            case 2
                offset(i,j,:)=offset(i-1,j,:);
            case 3
                offset(i,j,:)=offset(i,j-1,:);
        end
        wid=[offset(i,j,1)-1,offset(i,j,2)-1,m-offset(i,j,1)-1,n-offset(i,j,2)-1];
        wth=min(wid);
        is=0;
        v=[offset(i,j,1) offset(i,j,2)];
        a=1/2;
        while (wth*a^is)>=1
            R=2*rand(1,2)-1;
            u=v+(wth*a^is)*R;
            is=is+1;   
        end
        u=round(u);
        if u(1)<=w
            u(1)=w+1;
        end
        if u(1)>=m-w
            u(1)=m-w-1;
        end
        if u(2)<=w
            u(2)=w+1;
        end
        if u(2)>=n-w
            u(2)=n-w-1;
        end
        offset(i,j,1)=u(1);
        offset(i,j,2)=u(2);
        imgA(i,j,:)=imgB(u(1),u(2),:);   
    end
 end
    end
   imwrite(imgA,['result\',num2str(ir),'.jpg']);
end
img=imgA;
end
    
    
    
                