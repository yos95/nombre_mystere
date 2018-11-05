
  bool etat_partie = true;
var nb_essais = 0;

 String check_mystere (int nombre,int  nombre_mystere){

var check ;
if (nombre == nombre_mystere){
  check = 'Vous avez trouver le nombre mystere en $nb_essais fois ';
  etat_partie = false;
  return (check);
}
else  if (nombre < nombre_mystere){
  check = 'Le nombre mystere et plus grand';

  return (check);
}
else if (nombre > nombre_mystere){
   check = 'Le nombre mystere et plus petit';

  return (check);
}

}
