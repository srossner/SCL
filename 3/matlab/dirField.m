function dirField(p_, y_axis,x_axis)
    [p,q]=meshgrid( y_axis,x_axis);
    dP=p_(p);
    dQ=ones(size(q));
    L=sqrt((dP.^2)+(dQ.^2));
    quiver(q,p,dQ./L,dP./L,.5,'b'), axis tight;
end