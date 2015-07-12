input FILEIO;

prologues := 3;
w = 0.5 mm;
u = 10.0 w;
curx := 0;

defaultfont := "cmtt10";
defaultscale := 1.2;

def t (expr a) =
	((a) scaled u shifted (w, w))
enddef;

def process (expr f) = begingroup
	numeric k, n;
	string p, s;
	k := 0;

	forever:
		read_line (f);
		exitif buf = EOF;
		n := length (buf) - 1;
		p := substring (0, 1) of buf;
		s := substring (1, n + 1) of buf;
		draw t ((0, k - 0.4) -- (0, k + 1.2));
		if p = "<":
			draw t ((0, k) -- (0, k + 0.85) -- (+(n * 0.45 + 0.3),
			    k + 0.85) -- (+(n * 0.45 + 0.3), k) -- cycle);
			dotlabel.urt (s, t ((0, k)));
		else:
			draw t ((0, k) -- (0, k + 0.85) -- (-(n * 0.45 + 0.3),
			    k + 0.85) -- (-(n * 0.45 + 0.3), k) -- cycle);
			dotlabel.ulft (s, t ((0, k)));
		fi;
		k := k - 1;
	endfor;
endgroup; enddef;

beginfig (1)
	process ("protocol.txt");
endfig;

end.
