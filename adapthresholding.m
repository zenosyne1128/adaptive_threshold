function out=adapthresholding(in,w,h)
intImg=zeros(w,h);
r=10;out=in;t=15;
for i=1:w
    sum=0;
    for j=1:h
        sum=sum+in(i,j);
        if i==1
            intImg(i,j)=sum;
        else 
            intImg(i,j)=intImg(i-1,j)+sum;
        end
    end
end
for i=1:w
    for j=1:h
            x1=i-r;
            x2=i+r;
            y1=j-r;
            y2=j+r;
            if x1<1
                x1=1;
            end
            if y1<1
                y1=1;
            end
            if x2>w
                x2=w;
            end
            if y2>h
                y2=h;                            %ȡֵ������ʱ��ֵΪ�߽�
            end
            count=(x2-x1+1)*(y2-y1+1);
            if x1==1 && y1==1
                sum=intImg(x2,y2);
            elseif x1==1 && y1>1
                sum=intImg(x2,y2)-intImg(x2,y1-1);
            elseif y1==1 && x1>1
                sum=intImg(x2,y2)-intImg(x1-1,y2); %�߽粿�ֵĲ��ֻ���ͼ��
            else
                sum=intImg(x2,y2)-intImg(x2,y1-1)-intImg(x1-1,y2)+intImg(x1-1,y1-1);
            end
            if(in(i,j)*count)<(sum*(100-t)/100)
                out(i,j)=0;
            else
                out(i,j)=255;
            end
    end
end

