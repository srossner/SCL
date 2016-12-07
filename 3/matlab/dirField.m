function dirField(p_)
    [p,q]=meshgrid(-20:1:20,-20:1:20);
    dP=p_(p);
    dQ=ones(size(q));
    L=sqrt((dP.^2)+(dQ.^2));
    quiver(q,p,dQ./L,dP./L,.5,'r'), axis tight;
end