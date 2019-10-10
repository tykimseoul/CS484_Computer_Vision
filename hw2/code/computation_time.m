filter_sizes=[3:2:15]
image_sizes=linspace(0.175, 1, size(filter_sizes,2))
image=imread('RISDance.jpg');
result=zeros([size(filter_sizes, 2) size(image_sizes, 2)])

i_idx=1;
for i=filter_sizes
    j_idx=1;
    filter=ones(i)/i^2;
    for j=image_sizes
        scaled=imresize(image, j);
        tic;
        filtered=imfilter(scaled, filter, 'conv');
        t=toc;
        result(i_idx, j_idx) = t;
        j_idx=j_idx+1;
    end
    i_idx=i_idx+1;
end

surf(filter_sizes, image_sizes, result)
xlabels = string(filter_sizes) + ' x ' + string(filter_sizes)
ylabels = string(round(size(image, 1)*size(image, 2)*image_sizes.^2/1000000, 2)) + ' MP'
set(gca,'Xtick',filter_sizes)
set(gca,'Ytick',image_sizes)
xticklabels(xlabels)
yticklabels(ylabels)
ztickformat('%.2f s')
xlabel('filter size')
ylabel('image size')
zlabel('elapsed time')
