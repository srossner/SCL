function xfinal = NewtonsMethod(G, G_, InitialGuess)
    error = 1;
    xfinal = InitialGuess;
    while(error>1e-4)
        xinitial = xfinal;
        xfinal = xinitial - (G(xinitial,InitialGuess)/G_(xinitial,InitialGuess));
        error = abs(xfinal - xinitial);
    end
end