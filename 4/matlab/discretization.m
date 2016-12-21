function [ Matrix, Vector ] = discretization( Nx, Ny, p )
hx = 1/(Nx+1);
hy = 1/(Ny+1);
Matrix = zeros(Nx*Ny);
Vector = zeros(Nx*Ny,1);
    for i=1:Nx*Ny
        if(mod(i-1,Nx)~=0)
            Matrix( i, i-1 ) = 1/(hx^2);
        end
        Matrix( i, i ) = (-2/(hx^2)) + (-2/(hy^2));
        if(i<Nx*Ny && mod(i,Nx)~=0)
            Matrix( i, i+1 ) = 1/(hx^2);
        end
        if(i>Nx)
            Matrix( i, i-Nx ) = 1/(hy^2);
        end
        if(i<=(Ny-1)*Nx)
            Matrix( i, i+Nx ) = 1/(hy^2);
        end
        if(mod(i,Nx)~=0)
            Vector(i) = p(hx*mod(i,Nx),hy*ceil(i/Nx));
        else
            Vector(i) = p(hx*Nx,hy*ceil(i/Nx));
        end
    end
end