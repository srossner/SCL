function [ output_args ] = plotT( N_x, N_y, T , String_Worksheet )
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
    
    my_Plot = figure;
    set(my_Plot,'name',  sprintf( '%s: N_x: %d , N_x: %d', String_Worksheet, N_x, N_y),...
    'numbertitle','off');
    %set title of plot
    title( sprintf( 'Graph forN_x: %d , N_x: %d', N_x, N_y ));
    surfc( y_,x_,my_Sol);
    
    my_Plot = figure;
    set(my_Plot,'name',  sprintf( '%s: N_x: %d , N_x: %d', String_Worksheet, N_x, N_y),...
    'numbertitle','off');
    %set title of plot
    title( sprintf( 'Graph forN_x: %d , N_x: %d', N_x, N_y ));
    contour( y_,x_,my_Sol);
    
else
    my_Plot = figure;
    set(my_Plot,'name',  sprintf( '%s: N_x: %d , N_x: %d', String_Worksheet, N_x, N_y),...
    'numbertitle','off');
    %set title of plot
    title( sprintf( 'Graph for N_x: %d , N_x: %d ', N_x, N_y ));
    surfc( y_,x_,T);
    
    my_Plot = figure;
    set(my_Plot,'name',  sprintf( '%s: N_x: %d , N_x: %d', String_Worksheet, N_x, N_y),...
    'numbertitle','off');
    %set title of plot
    title( sprintf( 'Graph for N_x: %d , N_x: %d ', N_x, N_y ));
    contour( y_,x_,T);
end


end

