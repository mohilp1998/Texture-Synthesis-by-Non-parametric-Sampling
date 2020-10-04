img = (imread('tex3.png'));
img_grey=rgb2gray(img);

%img_grey=img;
img_grey=im2double(img_grey)*255;

[row_size,column_size] = size(img_grey);
img_small=img_grey;
%img_small=zeros(floor(row_size/8),floor(column_size/8));

% for i = 1:floor(row_size/8)
%     for j=1:floor(column_size/8)
%         if i%8==0
%             if j%8==1
%               img_small(i,j)=img_grey(i,j);
%             end 
%             
%          
%         end
%     end
% end    

[row_size,column_size]=size(img_small);

k = 15;
img_new = zeros(row_size+2*k,column_size+2*k);
img_new(k+1:k+row_size,k+1:k+column_size) = img_small;
pos_row = k+1;
pos_column = k+1;
W = 23;
epsilon = 0.03;
img_orig=img_new;
%imshow(uint8(img_new));

for i = 1:k
    % call the function here ------------
    [img_new,k_array]=layer_synthesise(img_new,pos_row,pos_column,row_size,column_size,W,epsilon);
    
    pos_row = pos_row - 1;
    pos_column = pos_column - 1;
    row_size = row_size + 2;
    column_size = column_size + 2;
end

img_combined=cat(2,uint8(img_orig),uint8(img_new));
imshow(img_combined);
