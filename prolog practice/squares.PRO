constants
        bgi_path = "BGI"
predicates
        Draw(string,integer,integer,integer,integer,integer)
        Draw(integer,integer,integer)   
goal
        initGraph(0, 0, New_Driver, New_Mode, bgi_path),
		setbkcolor (2),
		setcolor (60),
        getMaxX(MMx),getMaxY(MMy),
		line (0, 0, MMx, MMy),
        C=2,Mx=MMx div C,My=MMy div C,
        N=8,Sy=My div N,
        Draw(Sy,N,0),  
        getimage(0,0,Mx,My,BTMP),
        cleardevice(),
        Draw(BTMP,C,0,0,Mx,My).
clauses              
        Draw(_,C,_,_,_,_):-
                C<1,!.
        Draw(BTMP,C,Sx,Sy,Mx,My):-
                CC=C-1,SSx=Sx+Mx,
                putimage(Sx,Sy,BTMP,0),
                Draw(BTMP,CC,SSx,Sy,Mx,My).
        Draw(Sy,N,I):-
                I<N,II = I+1,
                AA=I*Sy,BB=II*Sy,!,
                rectangle(AA,AA,BB,BB),
                Draw(Sy,N,II).
        Draw(_,_,_):-!.