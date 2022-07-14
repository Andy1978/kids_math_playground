function [m, num_NA] = solve (m)

  # Element 1 bestimmt den Operator
  if (m(1) == '*')
    op = @times;
    op_rev = @rdivide;
  elseif (m(1) == '+')
    op = @plus;
    op_rev = @minus;
  else
    error ("Typ '%c' unbekannt", m(1));
  endif
  
  do
    num_NA_prev = sum(isna (m(:)));

    ## zuerst rechts oben die Spaltenfaktoren/-summanden
    m = solve_row (m, op_rev);
    ## dann links unten die Zeilenfaktoren/-summanden
    m = solve_row (m.', op_rev).';

    # Dann die Kreuzungen
    for c = 2:columns (m)
      for r = 2:rows (m)
          if (isna (m(r, c)) && !isna (m(1, c)) && !isna (m(r, 1)))
            m (r, c) = op (m(1, c), m(r, 1));
          endif
      endfor
    endfor

    num_NA = sum(isna (m(:)));
  until (num_NA_prev == num_NA)

endfunction
