import 'dart:math';

int generat_nombre_mystere() {
  var rng = new Random();
  int result = rng.nextInt(98);
  return (rng.nextInt(result + 1));
}
