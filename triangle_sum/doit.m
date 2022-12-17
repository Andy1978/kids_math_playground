1;

function m = append_triangle (m, s, allow_neg = false)

  m(end + 1, :) = NA (1, 7);
  m(end, 1) = s;     
  
  if (allow_neg)
    # da würden auch negative Zahlen vorkommen
    r = randi (round (s * 0.8), 1, 3);
  else
    # erste Ecke zufällig bis 70% von der Summe
    r(1) = randi (round (s * 0.7));
  
    # zweite so wählen, dass nur positive Zahlen vorkommen
    r(2) = randi (s - r(1) - 1);

    # dritte genauso
    r(3) = randi (s - max(r(1:2)) - 1);
    r = r(randperm (3));
  endif
  
  m(end, 2:2:6) = r;     
     
  m(end,3) = m(end,1) - m(end,2) - m(end,4);
  m(end,5) = m(end,1) - m(end,4) - m(end,6);
  m(end,7) = m(end,1) - m(end,2) - m(end,6);
  
  # Zufällig drei auf NA setzen
  do
    idx = randi (6, 1, 3) + 1;
  until (numel (unique (idx)) == 3)
  m(end, idx) = NA;

endfunction

m = [];
for k = 1:6 # 2 Seiten mit insgesamt 12 Bäumen
  m = append_triangle (m, 50);
  m = append_triangle (m, 100);
endfor

render_triangle ("hello.pdf", m);
