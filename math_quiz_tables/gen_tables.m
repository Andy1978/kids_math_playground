# Speicher für alle Tabellen
global mstack;

function append (nmin, nmax, nrows, ncols, typ)
  global mstack;
  mstack = cat (3, mstack, quiz (nmin, nmax, nrows, ncols, typ));
endfunction

mstack = {};
for k = 1:40
  append (1, 10, 3, 3, '+');  # Additionen 1:10
  append (2, 5, 3, 3, '*');   # Multiplikationen 2:5
endfor
render_stack ("easy_3x3_add10_mul5.pdf", mstack, 2)

mstack = {};
for k = 1:40
  append (1, 50, 3, 3, '+');  # Additionen 1:50
  append (2, 10, 3, 3, '*');  # Multiplikationen 2:10
endfor
render_stack ("medium_3x3_add50_mul10.pdf", mstack, 2)

mstack = {};
for k = 1:60
  append (1, 10, 4, 4, '+');  # Additionen 1:10
endfor
render_stack ("easy_4x4_add10.pdf", mstack, 2)

mstack = {};
for k = 1:240
  append (2, 10, 2, 2, '*');  # Multiplikationen 2:5
endfor
render_stack ("easy_2x2_mul10.pdf", mstack, 3)

mstack = {};
for k = 1:60
  append (2, 10, 4, 4, '*');  # Multiplikationen 2:10
endfor
render_stack ("easy_4x4_mul10.pdf", mstack, 2)

mstack = {};
for k = 1:16
  append (1, 500, 3, 3, '+');  # Additionen 1:500
endfor
render_stack ("medium_3x3_add500.pdf", mstack, 2)

