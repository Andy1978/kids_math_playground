## Höchste Ganzzahl in den Faktoren, Anzahl Spalten, Anzahl Reihen (ohne Faktoren)
function m = quiz (minn = 2, maxn = 10, nrows = 3, ncols = 3, t = '*')

  m = zeros (nrows + 1, ncols + 1);
  # links oben ist der typ (in Wirklichkeit der Operator 1 = *, 2 = +)
  m(1,1) = t;

  ## Faktoren zufällig ohne Wiederholungen erzeugen
  m(1, 2:end) = randperm (maxn - (minn - 1), ncols) + (minn - 1);
  m(2:end, 1) = randperm (maxn - (minn - 1), nrows) + (minn - 1);

  if (m(1,1) == '*')
    ## Produkte ausrechnen
    m(2:end, 2:end) = m(1, 2:end) .* m(2:end, 1);
  elseif (m(1,1) == '+')
    m(2:end, 2:end) = m(1, 2:end) .+ m(2:end, 1);
  endif

  m_orig = m;

  do

    ## zufälliges Element auswählen
    r = randi (nrows + 1, 1);
    c = randi (ncols + 1, 1);

    # Nur, wenn nicht schon NA (und auch m(1,1) ausschließen)
    if (! isna (m(r, c)) && (r != 1 || c != 1))
      # Kopie erstellen und Element löschen
      tmp = m;
      tmp (r, c) = NA;
      
      # noch lösbar?
      [tmp_solved, n] = solve (tmp);
      
      ## Wenn noch lösbar, dann so weiter machen
      if (n == 0)
        m = tmp;
      endif
    endif

    # Anzahl der nicht NA (also mit Zahlen besetzte Stellen)
    # Die scheinen (nur ausprobiert), minimal nrows + ncols zu werden
    n = sum (!isna (m(:))) - 1;

  until (n == nrows + ncols);

  #endfor
  
  # sanity check
  [solved, n] = solve (m);
  assert (m_orig, solved);
  assert (n, 0);
  
  #n = sum (!isna (m(:)))

endfunction
