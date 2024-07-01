Deployar:

Para deplyar, debemos ir deployando cada contrato desde el que no tiene dependencias para el final (DAO). Entonces:
Vamos a deployar Member.sol
Luego, deployamos Ojeador.sol
Después, deployamos JugadoresAFichar.sol utilizando la address del contrato deployado de Ojeador
Finalmente, deployamos DAO.sol utilizando todas las address de los contratos deployados anteriormente.
Como añadido, seteamos DAO en member con el setter.

Interactuar:

En nuestro caso, utilizamos REMIX, así que podemos interactuar desde diferentes direcciones allí. En primer caso, debemos agregar jugadores a la prelista (ubicada en el contrato de JugadoresAFichar. A partir de ahí, podemos crear propuestas para votarlas y luego ejecutarlas. Considerar que para que una propuesta de ejecute, debemos tener balance (consideramos manageFounds para que el chairman pueda realizar inversiones).
