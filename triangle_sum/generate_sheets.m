m = [];
for k = 1:18 # 4 Seiten mit insgesamt 36 Bäumen
  m = append_triangle (m, 50);
  m = append_triangle (m, 100);
endfor

render_triangle ("magic_triangles_50_100.pdf", m);
