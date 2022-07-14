function m = solve_row (m, op)

  # rechts oben die Spaltenfaktoren
  for c = 2:columns (m)
    if (isna (m(1, c)))
      for r = 2:rows (m)
        if (!isna (m (r, c)) && ! isna (m (r, 1)))
          m (1, c) = op (m (r, c), m (r, 1));
        endif
      endfor
    endif
  endfor
  
endfunction
