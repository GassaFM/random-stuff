input FILEIO;

%outputtemplate := "%j-%03c.eps";
%outputformat := "eps";
outputtemplate := "%j-%03c.svg";
outputformat := "svg";

prologues := 3;
w = 0.5 mm;
u = 20.0 w;

numeric awidth;
color acolor;

def tr (expr a) =
	((a) scaled 2 u yscaled 1)
enddef;

def draw_vertices (expr s) = begingroup
	string t;
	numeric i;
	pair c, d;
	d := (2 / 3, 0) rotated 30;
	c := d;
	d := d rotated 60;

	pickup pencircle scaled 2 w;
	i := 0;
	forever:
		fill tr (fullcircle scaled 0.5 shifted c) withcolor 0.5 white;
		exitif i >= length (s);
		t := substring (i, i + 1) of s;
		if t = "l":
			d := d rotated 60;
		elseif t = "b":
			d := d rotated 180;
		elseif t = "r":
			d := d rotated 300;
		fi;
		c := c + d;
		i := i + 1;
	endfor;
endgroup enddef;

def draw_path (expr s) = begingroup
	string t;
	numeric i;

	pickup pencircle scaled awidth;
	i := 0;
	forever:
		exitif i >= length (s);
		t := substring (i, i + 1) of s;
		if t = "l":
			d := d rotated 60;
		elseif t = "b":
			d := d rotated 180;
		elseif t = "r":
			d := d rotated 300;
		fi;
		drawarrow tr ((point 0.15 of (c -- (c + d))) --
		    (point 0.85 of (c -- (c + d)))) withcolor acolor;
		c := c + d;
		i := i + 1;

		xlo := min (xlo, xpart c);
		xhi := max (xhi, xpart c);
		ylo := min (ylo, ypart c);
		yhi := max (yhi, ypart c);
	endfor;
endgroup enddef;

def process (expr fin, fout) = begingroup
	numeric xlo, ylo, xhi, yhi;
	string p, q;
	pair c, d;
	read_line (fin);
	p := buf;
	read_line (fin); % EOF
	read_line (fout);
	q := buf;
	read_line (fout); % EOF

	pickup pencircle scaled w;
	for i := -10 upto +10:
		draw tr (((-10, i) -- (+10, i)) rotated 0);
		draw tr (((-10, i) -- (+10, i)) rotated 60);
		draw tr (((-10, i) -- (+10, i)) rotated 120);
	endfor;

%	draw_vertices (p);

	d := (2 / 3, 0) rotated 30;
	c := d;
	d := d rotated 60;
	fill tr (fullcircle scaled 0.5 shifted c) withcolor 0.8 white;
	xlo := xpart c;
	xhi := xpart c;
	ylo := ypart c;
	yhi := ypart c;
	linejoin := mitered;
	linecap := butt;

	ahlength := 6 w;
	ahangle := 75;
	awidth := 4 w;
	acolor := 0.6 white;
	draw_path (p);

	ahlength := 4 w;
	ahangle := 75;
	awidth := 2 w;
	acolor := 0.2 white;
	draw_path (q);

	xlo := xlo - 1.16;
	xhi := xhi + 1.16;
	ylo := ylo - 1.16;
	yhi := yhi + 1.16;

	clip currentpicture to tr ((xlo, ylo) -- (xlo, yhi) --
	    (xhi, yhi) -- (xhi, ylo) -- cycle);
endgroup enddef;

beginfig (1)
	process ("001.input", "001.output");
	currentpicture := currentpicture shifted -llcorner (currentpicture);
endfig;

beginfig (2)
	process ("002.input", "002.output");
	currentpicture := currentpicture shifted -llcorner (currentpicture);
endfig;

end.
