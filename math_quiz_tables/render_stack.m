function render_stack (pdf_fn, m, cols = 3)

  fn = tempname ();
  fid = fopen (fn, "w");
  fputs (fid, "\
\\documentclass[a4paper]{article}\n\
\\usepackage[inner=2.5cm,outer=1.5cm,top=0.5cm,bottom=0.5cm,includeheadfoot]{geometry}\n\
\\usepackage[thinlines]{easytable} % https://ctan.joethei.xyz/macros/latex/contrib/easy/doc/doctable.pdf\n\
\\pagenumbering{gobble} % no page numbering\n\
\\begin{document}\n");

  m_orig = m;
  pages = size (m, 3);

  for p = 1:pages

    m = m_orig{p};

   if (p > 1)
     if (mod (p - 1, cols))
       fprintf (fid, "\\hspace{15mm}\n");
     else
       fprintf (fid, "\\vspace{5mm}\n\n");
     endif
   endif

    ## Header
    fprintf (fid, "\\Large\n\\begin{TAB}(e,1.5cm,1.5cm){c|");
    for k = 1:columns(m)-1
      fprintf (fid, "c:")
    endfor
    fprintf (fid, "}{c|");
    for k = 1:rows(m)-1
      fprintf (fid, "c:")
    endfor
    fprintf (fid, "}\n");

    ## Rows
    for r = 1:rows(m)
      for c = 1:columns(m)
        v = m(r, c);
        if (r == 1 && c == 1)
          if (v == '*')
            s = "$\\cdot$";
          else
            s = ["$", char(v), "$"];
          endif
        elseif (isna (v))
          s = "";
        else
          s = sprintf ("%i", v);
        endif
        fprintf (fid, "%s", s);
        if (c != columns(m))
          fprintf (fid, " & ");
        endif
      endfor
      fprintf (fid, "\\\\\n");
    endfor
    fprintf (fid, "\\end{TAB}\n");

  endfor

  fprintf (fid, "\\end{document}");  
  fclose (fid);
  
  oldpwd = pwd ();
  cd ("/tmp");
  cmd = sprintf ("pdflatex -interaction=nonstopmode \"%s\" 2>&1", fn)
  [s, out] = system (cmd);
  if (s)
    error ("Call to '%s' failed with '%s'", cmd, out);
  endif
  cd (oldpwd);
  movefile ([fn ".pdf"], pdf_fn);
  # fixme: cleanup /tmp

endfunction
