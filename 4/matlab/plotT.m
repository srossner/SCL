function [ output_args ] = plotT( N_x, N_y, T )
% plot Solution 

dt_x = 1/(N_x + 1) ;
dt_y = 1/(N_y + 1);
x_ = 0:dt_x:1;
y_ = 0:dt_y:1;

[ m , n] = size(T);


if n == 1
    
    my_Sol = reshape(T,[N_x , N_y]);
   
    my_Sol = [ zeros( 1, length( my_Sol ) + 2) ;...
            zeros( length( my_Sol ) , 1) my_Sol zeros( length( my_Sol ), 1) ; ...
            zeros( 1, length( my_Sol ) + 2)];
    
    figure
    surfc( y_,x_,my_Sol);
    
else
    figure
    surfc( y_,x_,T);
end


end

