function [ M ] = createM( N_x, N_y )

h_x_2 = 1/(N_x+1)^2;
h_y_2 = 1/(N_y+1)^2;

numRC = N_x*N_y;

M = zeros( numRC, numRC);

for i = 1:numRC
    for j = 1:numRC
        if i == j
            M(i,j) = -2 * ((1/h_x_2)  + 1/(h_y_2) );
      %  elseif i == j -1 || i == j+1 
      %      M(i,j) = 1/h_x_2;
        elseif i == j - N_x || i == j + N_x
            M(i,j) = 1/h_y_2;
        end            
    end
end

for i = 1:N_x-1
    for j = 1:N_y
        M(i+(j-1)*N_x, i+(j-1)*N_x+1) = 1/h_x_2;
        M(i+(j-1)*N_x+1, i+(j-1)*N_x) = 1/h_x_2;
    end
end



end

