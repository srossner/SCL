function worksheet5

Nx = [3 7 15 31];
Ny = [3 7 15 31];
TimeStep = [1/64 1/128 1/256 1/512 1/1024 1/2048 1/4096];
Tstart = 0;
accuracy = 1e-6;

%Calling Explicit Euler for various time steps
for Tend = 1:4
count =1;
figure('Name',strcat('Method:Explicit Euler  EndTime=',num2str(Tend),'/8 seconds'),'NumberTitle','off')
for j =1:4
for i= 1:7
    subplot(4,7,count);
    PreTemp = zeros(Nx(j)+2,Ny(j)+2);
    PreTemp(2:Nx(j)+1,2:Ny(j)+1) = ones(Nx(j),Ny(j));
    TempExplicit = explicitEuler( PreTemp , Tstart , Tend/8 , TimeStep(i) , Nx(j) , Ny(j) );
    z = 1/(Nx(j)+1);
    surf(0:z:1,0:z:1,TempExplicit);
    title(strcat('Nx,Ny=',num2str(Nx(j)),'  dt=1/', num2str(32*(2^i))));
    count = count+1;
end
end
end

%Calling Implicit Euler for various time steps
for Tend = 1:4
figure('Name',strcat('Method:Implicit Euler  EndTime=',num2str(Tend),'/8 seconds  ','  Time Step = 1/64'),'NumberTitle','off')
for j =1:4
    subplot(2,2,j);
    PreTemp = zeros(Nx(j)+2,Ny(j)+2);
    PreTemp(2:Nx(j)+1,2:Ny(j)+1) = ones(Nx(j),Ny(j));
    TempImplicit = implicitEuler( PreTemp , Tstart , Tend/8 , 1/64 , Nx(j) , Ny(j), accuracy );
    z = 1/(Nx(j)+1);
    surf(0:z:1,0:z:1,TempImplicit);
    title(strcat('Nx,Ny=',num2str(Nx(j))));
end
end


end