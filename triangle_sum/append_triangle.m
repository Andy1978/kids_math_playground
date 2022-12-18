function m = append_triangle (m, s, allow_neg = false)

  m(end + 1, :) = NA (1, 7);
  m(end, 1) = s;

  do
    # Mit den Ecken könnten auch negative Zahlen auf den Kanten vorkommen
    m(end, 2:2:6) = randi (round (s * 0.9), 1, 3);
    # Werte in der mitte der Kanten berechnen
    m(end,3) = m(end,1) - m(end,2) - m(end,4);
    m(end,5) = m(end,1) - m(end,4) - m(end,6);
    m(end,7) = m(end,1) - m(end,2) - m(end,6);
  until (min (m) > 0 || allow_neg) # kleinste Zahl 1 sicherstellen

  # Zufällig drei nodes auf NA setzen
  do
    idx = randi (6, 1, 3) + 1;

    # Einen Vektor aufbauen um die Anzahl an NAs an einer Kante zu berechnen
    x = zeros (1, 7);
    x(idx) = 1;
    x(end) = x(1);

    # Anzahl der NA auf einer der drei Kanten
    num_NA_on_edge = sum (x([1:3;3:5;5:7]), 2);

  # Sicherstellen, dass es drei unterschiedliche nodes sind
  # und mindestens ein NA auf jeder Kante liegt
  until (numel (unique (idx)) == 3 && min (num_NA_on_edge) > 0)

  m(end, idx) = NA;

endfunction
