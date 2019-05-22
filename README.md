# Guessing-Guru (RUBY)

El juego para adivinar un numero de cuatro cifras (que no se repiten) consiste en que el "pensador" piensa un numero de 4 cifras (como "1234" o "9072"). El "adivinador" prueba de adivinar el numero diciendo un numero de 4 cifras y el "pensador" le dice cuantas cifras están en el lugar correcto y cuantas en el lugar incorrecto
Ejemplo:
(El pensador piensa el numero: 1234)
Adivinador: 1273...
Pensador: respuesta 2 bien, 1 regular (ya que el 1 y el 2 están en el lugar correcto y el 3 esta en el lugar incorrecto)
Adivinador: 8564...
Pensador: respuesta 1 bien, 0 regular (ya que el 4 están en el lugar correcto y no hay números en el lugar incorrecto)
Adivinador: 4321...
Pensador: respuesta 0 bien, 4 regular (ya que no hay cifras en el lugar correcto y todos los números están en el lugar incorrecto)
Adivinador: 1234...
Pensador: respuesta 4 bien, 0 regular (ya que todo los números están en el lugar correcto). JUEGO TERMINADO!


correr en terminal -> ruby lib/human_router.rb la computadora piensa el numero y un humano lo trata de adivinar

correr en terminal -> ruby lib/machine_router.rb humano piensa el numero y la computadora lo trata de adivinar
