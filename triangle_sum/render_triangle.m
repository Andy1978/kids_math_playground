# in m die Werte für den Stern und dann im Uhrzeigersinn beginnend von der Spitze
function render_triangle (pdf_fn, m)

  fn = tempname ();
  fid = fopen (fn, "w");
  fputs (fid, "\\documentclass[a4paper]{article}\n\
\\usepackage[inner=2.5cm,outer=1.5cm,top=0.5cm,bottom=0.5cm,includeheadfoot]{geometry}\n\
\\usepackage{tikz}\n\
\\usetikzlibrary{shapes,snakes}\n\
\\pagenumbering{gobble} % no page numbering\n\
\\begin{document}\n\
\\begin{tikzpicture}\n");

  # Start
  p0 = [0 0];

  # Kantenlänge des Dreiecks
  l = 5;

  for j = 1:rows (m)
    if (j > 1 && ! mod (j - 1, 6))
      fprintf (fid, "\\\end{tikzpicture}\n");
      fprintf (fid, "\\newpage\n");
      fprintf (fid, "\\begin{tikzpicture}\n");
      p0(2) = 0;
    endif
    ms = m(j,:);
    add_triangle (fid, ms, l, p0);
    p0(1) += (l * 1.8);
    if (! mod (j, 2))
      p0(1) = 0;
      p0(2) += (l * 1.8);
    endif
  endfor

  fprintf (fid, "\\\end{tikzpicture}\n\\end{document}");
  fclose (fid);

  oldpwd = pwd ();
  cd ("/tmp");
  cmd = sprintf ("pdflatex -interaction=nonstopmode \"%s\" 2>&1", fn);
  [s, out] = system (cmd);
  cd (oldpwd);
  if (s)
    error ("Call to '%s' failed with '%s'", cmd, out);
  endif
  movefile ([fn ".pdf"], pdf_fn);
  # fixme: cleanup /tmp

endfunction

function add_triangle (fid, m, l, p0)

  s30 = sin(30*pi/180)*l/2;
  c30 = cos(30*pi/180)*l/2;

  # nur Differenzen
  p = [p0(1) p0(2);
       0, -l/3;
       s30, -c30;
       s30, -c30;
       -l/2, 0;
       -l/2, 0;
       s30, c30;
       s30, c30;];

  p = cumsum (p);
  assert (rows (p), 8);
  assert (columns (m), 7);

  for k = 1:7 # Star und 6 Kreise
    if (k == 1)
      fprintf (fid, "\\node[draw,star,minimum size=2cm,inner sep=0pt] ")
    else
      fprintf (fid, "\\node[draw,circle,minimum size=1.5cm,inner sep=0pt] ")
    endif
    fprintf (fid, " (%i) at (%i,%i) {$%s$};\n", k, p(k,1), p(k,2), merge (isna(m(k)), "", mat2str(m(k))))
  endfor

  # Linien zwischen den Kreisen
  for k = 2:7
    fprintf (fid, "\\draw[-] (%i) -- (%i);\n", k, merge (k == 7, 2, k + 1));
  endfor

endfunction
