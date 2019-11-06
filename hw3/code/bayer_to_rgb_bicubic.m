%% HW3-a
% Generate the rgb image from the bayer pattern image using linear and
% bicubic interpolation.
function rgb_img = bayer_to_rgb_bicubic(bayer_img)
    clc;
    img_size=size(bayer_img);
    r_channel=zeros(img_size);
    g1_channel=zeros(img_size);
    g2_channel=zeros(img_size);
    b_channel=zeros(img_size);
    window=["r", "g1"; "g2", "b"];
    repWindow=repmat(window, img_size/2);
    r_channel(repWindow=="r")=bayer_img(repWindow=="r");
    g1_channel(repWindow=="g1")=bayer_img(repWindow=="g1");
    g2_channel(repWindow=="g2")=bayer_img(repWindow=="g2");
    b_channel(repWindow=="b")=bayer_img(repWindow=="b");
    r=bicubic(r_channel);
    g1=rot90(bicubic(rot90(g1_channel)),3);
    g2=rot90(bicubic(rot90(g2_channel,3)));
    g=zeros(size(g1));
    avgg=(g1+g2)/2;
    g((repWindow=='b'))=avgg(repWindow=='b');
    g((repWindow=='r'))=avgg(repWindow=='r');
    g((repWindow=='g1'))=g1_channel(repWindow=='g1');
    g((repWindow=='g2'))=g2_channel(repWindow=='g2');
    b=rot90(bicubic(rot90(b_channel,2)),2);
    rgb_img=uint8(cat(3,r,g,b));
    figure
    imshow(rgb_img);
end

function result = bicubic(channel)
    padded=cat(1, channel(1:2,:), channel);
    padded=cat(1,padded, padded(size(padded,1)-1:size(padded,1),:));
    padded=cat(1,padded, padded(size(padded,1)-1,:));
    padded=cat(2,padded(:,1:2), padded);
    padded=cat(2, padded, padded(:,size(padded,2)-1:size(padded,2)));
    padded=cat(2, padded, padded(:,size(padded,2)-1));
    paddedCpy=padded;

%     X=[-1 0 1 8; 1 0 1 4; -1 0 1 2; 1 1 1 1];
    X=[-8 0 8 64; 4 0 4 16; -2 0 2 4; 1 1 1 1];
    Y=X';
    for i=3:size(padded,1)-3
        for j=3:size(padded,2)-3
            if padded(i,j)==0
                d=normalizedDistance(i,j);
                centerP=[i j]-d;
                Z=reshape(nonzeros(padded(centerP(1)-2:centerP(1)+4,centerP(2)-2:centerP(2)+4)),4,4);
                px=[d(1)^3; d(1)^2; d(1); 1];
                py=[d(2)^3 d(2)^2 d(2) 1];
                p=py*inv(Y)*Z*inv(X)*px;
                paddedCpy(i,j)=p;
            end
        end
    end
    result=paddedCpy(3:size(padded,1)-3,3:size(padded,2)-3);
end

function n=normalizedDistance(i,j)
    n=[0 0];
    if mod(i,2)==0
        n(1)=1;
    else
        n(1)=0;
    end
    if mod(j,2)==0
        n(2)=1;
    else
        n(2)=0;
    end
end
