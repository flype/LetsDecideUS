# lestdecide.us

Pregunta, vota y consulta los resultados directamente desde tu correo electrónico.


## Qué es lestdecide.us

Es un nuevo amigo a incluir en tu lista de correo.

Es un sistema totalmente transparente y ligero para poder hacer **encuestas por email** a tu grupo de amigos o a tu lista de correo e ir almacenando las respuestas recibidas.


## Limitaciones

En esta primera fase nos centraremos en las preguntas que pueden ser votadas de manera binaria esto es con **+1** o **-1**


## Para usarlo con tu grupo de amigos

Simplemente envía un email con la pregunta y pon a tus amigos en copia incluyendo ademas a tu nuevo amigo:

 bot@letsdecide.us
 
Tus amigos deberán contestar a tu pregunta igualmente poniendo a todos en copia y también a vuestro nuevo amigo.

La votación se deberá poner en cualquier punto del cuerpo del mensaje, eso sí, en una sola línea.

**Por ahora sólo se admiten votaciones con +1 ó -1**.


## Para usarlo en tu lista de correo

Tienes que añadir en tu lista de correo a tu nuevo amigo:

 bot@letsdecide.us
 
Añádelo directamente sin email de confirmación ya que no le hará caso. Tampoco lo configures en modo digest o no entenderá nada.


## Comandos

En cualquier hilo de una pregunta, y siempre **incluyendo a todo en mundo copia**, **o a la lista de correo** en caso de estar en una lista, puedes enviar uno de estos comandos:

Para ver el **estado actual de vuestra votación**:

  ::results::
  
Tu nuevo amigo contestará con los resultados de la votación recogidos hasta ahora.

Por otro lado con el comando:

  ::web::
  
Tu nuevo amigo os devolverá un link desde el que podréis acceder a una **página web** para ver el estado actual de vuestra votación.


## Interface web

Aunque el correo electrónico es suficiente para poder usar a tu nuevo amigo también tenéis una página web dónde podéis ver el estado actual de vuestra votación

Simplemente pídele a tu nuevo amigo la url de la página de vuestra votación con el comando:

  ::web::

Recuerda que para que un comando funcione tienes que enviar el mail contestando al hilo de la encuesta, esto es, respetando el asunto y poniendo a todo el mundo en copia.

## Ejemplo práctico de un grupo de amigos

### Inicio de la pregunta

Alguien envía un email con este título "*Os gusta esta camiseta?*", y pone en copia a *pepe@domain.com*, *juan@domain.com*, *marta@domain.com* y a nuestro nuevo amigo: **bot@letsdecide.us**.

En el cuerpo del mensaje pone lo que quiera, lo importante para nuestro amigo es el asunto: **tiene que acabar en interrogante**.


### Primera votación

A *juan@domain.com* le parece buena idea y así que responde al email usando el **reply_all**, es decir, contestando a todos, incluido nuestro nuevo amigo, no se le ocurre cambiar el asunto del mensaje y lo deja como estaba.

En el cuerpo de la respuesta pone lo que quiere pero deja bien clara su opinión dejando una línea cualquiera para su flamante:

 +1
 
### Segunda votación

A *marta@domain.com* no le parece buena idea y tampoco le apetece explayarse mucho así que simplemente responde al mensaje con todos en copia y pone su escueto pero significativo:

 -1
 
### Un comentario

*pepe@domain.com* tiene dudas y todavía no quiere contestar así que contesta al hilo exponiendo sus dudas, pone en copia a todo el mundo, incluyendo nuestro amigo, pero al no decantarse con un +1 o un -1 nuestro nuevo amigo **no contabiliza ningún voto**.


### Los resultados

Cualquiera de los participantes y en cualquier momento puede preguntar a nuestro nuevo amigo como va la votación, para eso usa el comando **::results::** pero se asegura de enviar el comando en el mismo hilo de la conversación, esto es, respondiendo a uno de los mensajes del hilo, y sin cambiar el asunto y poniendo a todos en copia, incluyendo, por supuesto a nuestro nuevo amigo. 

Nuestro amigo contestará, tarde o temprano, con un email con los resultados.

Aunque se hayan solicitado los resultados **se puede seguir votando**, y solicitar los resultados cuantas veces haga falta.


## Ejemplo práctico de una lista de correo

### Dar de alta a nuestro nuevo amigo

Nuestro nuevo amigo tiene que escuchar todo lo que va ocurriendo en la lista, además de poder escribir en ella para poder contestar a los comandos.

Hay que darle de alta en la lista en modo **no-digest**, osea que no le lleguen todos los emails de un día en un sólo mail, y que además **no se le envíe un mail de confirmación** porque no le hará mucho caso.


### Inicio de la pregunta

Nuestro nuevo amigo recibirá todos los correos pero no hará mucho caso, sólo atenderá a los mensajes cuyo **asunto acabe en interrogante**.

Entonces cuando quieras realizar una encuesta a la lista bastará con que el asunto del mensaje acabe en interrogante.

Entonces, *juan@lista.com* envía su preguntita a la lista "*Os gusta esta camiseta?*", y no pone a nadie más en copia, **sólo a la lista**. Esto es importante pues es la manera que tiene nuestro amigo de diferenciar de si se está enviando la pregunta a una lista o a un grupo de amigos.


### Las votaciones

Las respuestas o votaciones se van sucediendo como en el caso del '*Ejemplo práctico de un grupo de amigos*'.


### Los resultados

Al igual que en el '*Ejemplo práctico de un grupo de amigos*', cualquier miembro de la lista puede solicitar en cualquier momento el estado actual de las votaciones enviando una respuesta al hilo con el comando **::results::**.

El mail hay que enviarlo a la lista y no directamente a nuestro amigo.

La respuesta de nuestro amigo se enviará también a la lista.

