function [new_pad_img,k_test_arr] = layer_synthesise(img_input,pos_row,pos_col,rows,cols,w,epsilon)%%w denotes side of square used preferably odd
                                                                                            %%pos_row and pos_col give the position of img_comparision in given_image. 

new_pad_img=img_input;
                                                                                            


%%[rows_main,cols_main]=size(given_image)

img_comparision=img_input(pos_row:pos_row+rows-1,pos_col:pos_col+cols-1);

size_of_req_patches=neighbourhood(rows,cols,w);

 no_of_horiz_patches=rows-w+1;
 no_of_cols_patches=cols-w+1;
 
 k_test=zeros(2*rows+2*cols+4,1);

for k=1:2*rows+2*cols+4
 row_start=size_of_req_patches(k,1);
 row_end=size_of_req_patches(k,2);
        
 col_start=size_of_req_patches(k,3);
 col_end=size_of_req_patches(k,4);
 
 start_square_row=size_of_req_patches(k,5);
 
 start_square_col=size_of_req_patches(k,6);
            
 no_of_rows=row_end-row_start+1; %%denotes no_of_rows and cols to be used in patch 
 no_of_cols=col_end-col_start+1;
 
 
 %start_square_row+row_start-1
%  start_square_row+row_end-1
%  start_square_col+col_start-1
%  start_square_col+col_end-1
% 
 %no_of_horiz_patches*no_of_cols_patches/10
 comp_matrix=zeros(no_of_horiz_patches*no_of_cols_patches,no_of_rows*no_of_cols);
 centre_pixels=zeros(no_of_horiz_patches*no_of_cols_patches,1);
 
 orig_patch=reshape(img_comparision(start_square_row+row_start-1:start_square_row+row_end-1,start_square_col+col_start-1:start_square_col+col_end-1),[1,no_of_rows*no_of_cols]);
 
 for i = 1:no_of_horiz_patches
    for j= 1: no_of_cols_patches
        
      comp_matrix((i-1)*no_of_cols_patches+j,:) = reshape(img_comparision(i+row_start-1:i+row_end-1,j+col_start-1:j+col_end-1),[1,no_of_rows*no_of_cols]);
      %% note resaping is done column by column wise i.e. listing of elements into new 1D array 
      
      centre_pixels((i-1)*no_of_cols_patches+j)= img_comparision(i+(w-1)/2,j+(w-1)/2);
      
        
 
      
    end
 end
 
 index=knnsearch(comp_matrix,orig_patch,'k',round(no_of_horiz_patches*no_of_cols_patches/50),'IncludeTies',true);
 %index=knnsearch(comp_matrix,orig_patch,'k',1,'IncludeTies',true);
 index=cell2mat(index);
 
 min_distance=norm(comp_matrix(index(1),:)-orig_patch)/sqrt(no_of_rows*no_of_cols-1);
 
 fin_index=[];
 
 for elm = index
 
     distance=norm(comp_matrix(elm,:)-orig_patch)/sqrt(no_of_rows*no_of_cols-1);
     if (distance>(1+epsilon)*min_distance)
         %fin_index=[fin_index,elm];--not required just used for testing
         break
     else
         fin_index=[fin_index,elm];
         
     end
     
 end
 
 %max_distance=norm(comp_matrix(fin_index(length(fin_index)),:)-orig_patch)/sqrt(no_of_rows*no_of_cols-1);
 
  
  %ratio=( max_distance -min_distance)/min_distance
  length(fin_index);
  k_test(k)=length(fin_index);
  if (length(fin_index)==round(no_of_horiz_patches*no_of_cols_patches/50))
      disp 'k has to be increased';
  end   
 posi=randi(length(fin_index));
 
 if (k<=cols+2)
     new_pad_img(pos_row-1,pos_col+k-2)=centre_pixels(fin_index(posi));
 
 elseif (k<=cols+rows+3)
      new_pad_img(pos_row+(k-cols-1)-2,pos_col+cols)=centre_pixels(fin_index(posi));
 
 elseif (k<=2*cols+rows+4)
      
      new_pad_img(pos_row+rows,pos_col+cols-(k-cols-rows-3))=centre_pixels(fin_index(posi));
     
 elseif (k<=2*cols+2*rows+4)
      
      new_pad_img(pos_row+rows-(k-2*cols-rows-4),pos_col-1)=centre_pixels(fin_index(posi));
      
 end    
 
 
 k_test_arr=k_test;
 
     
 
 
end








end
