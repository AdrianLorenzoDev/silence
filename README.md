# Silence 🌳🌧

A 3D scene with 3D objects, lights and particles. Created using [Processing](https://processing.org).
> **Adrián Lorenzo Melián** - *Creando Interfaces de Usuario*, [**ULPGC**](https://www.ulpgc.es).
> adrian.lorenzo101@alu.ulpgc.es

<div align="center">
 <img src=images/demo.gif alt="Creator demo"></img>
 <p>Figura 1 - Demostración de la ejecución de la aplicación</p>
</div>

***

## Índice
* [Introducción](#introduction)
* [Instrucciones de uso](#instructions) 
* [Implementación](#implementation)
    * [Luces](#lights)
    * [Lluvia](#rain)
* [Herramientas y recursos utilizados](#tools-and-resources)
* [Referencias](#references)

## Introducción <a id="introduction"></a>
El objetivo de esta práctica es **la creación de un escena que incorpore objetos en tres dimensiones, luces, texturas y una cámara en movimiento.**

## Instrucciones de uso<a id="instructions"></a>
Para navegar por la escena se dispone de distintos controles. Con las teclas `W`, `A`, `S` y `D` puedes **mover la cámara hacia adelante, hacia atrás y hacia los lados**. Con las `Arrow keys` **puedes rotar la cámara en el eje X y el eje Y.**

## Implementación <a id="implementation"></a>

### Luces <a id="lights"></a>

El objetivo a la hora de realizar la iluminación era el de **conseguir que la farola que se encuentra en la escena diera la sensación de encontrarse iluminando el escenario.**

Para conseguir esto, **se introdujo en el interior de la lámpara de la farola una esfera, y se estableció su emisión de luz con la función `emissive()`.** En combinación con una luz de ambiente y una pequeña luz de punto, se crea la sensación de que la lámpara de la farola está emitiendo luz.

A esto, se **ha añadido un pequeño efecto de parpadeo a la luz.** Cada cierto intervalo de tiempo, la iluminación se atenúa considerablemente durante medio segundo.

```java 
if (frameCount % (60 * 7) == 0) { 
  isLightOn = false; 
} else if (frameCount % 30 == 0) {
  isLightOn = true; 
}

lightFalloff(0.2, 0, 0.000009);

pushMatrix();
translate(lightPosition.x, lightPosition.y, lightPosition.z);

if (isLightOn) {
  emissive(240, 240, 240);
  ambientLight(240, 240, 240);
  spotLight(240, 240, 240, lightPosition.x, lightPosition.y, lightPosition.z, benchPosition.x, benchPosition.y, benchPosition.z, 1, 1);
} else {
  emissive(50, 50, 50);
  ambientLight(50, 50, 50);
  spotLight(50, 50, 50, lightPosition.x, lightPosition.y, lightPosition.z,  benchPosition.x, benchPosition.y, benchPosition.z, 1, 1);
}

sphere(20);
popMatrix();
```

#### Lluvia <a id="rain"></a>

Para crear el sistema de partículas de lluvia, se ha creado **la clase que representa una única gota**, denominada `Drop`. Este componente en el lienzo es un rectángulo de tamaño de valor aleatorio en un rango determinado. 

La primera vez que la gota es generada, esta **se coloca en una posición aleatorio entre el intervalo límite que el usuario elija.** Cada vez que se dibuja una de estas gotas en el lienzo, esta se mueve hacia abajo un poco, simulando así el movimiento. Cuando llega al valor de límite superior en la componente Y, **la gota pasa a volver a situarse alrededor del límite inferior de la componente Y en una posición pseudoaleatoria con valor en el intervalo del resto de las componentes.**

```java
private void fall() {
  position.y += speed;
  if (position.y >= end.y) {
    position.x = random(start.x, end.x);
    position.y = random(start.y, start.y+10);
    position.z = random(start.z, end.z);
  }
}
public void run() {
  fall();
  pushMatrix();
  translate(position.x, position.y, position.z);
  fill(12, 183, 242);
  box(size.x, size.y, size.z);
  popMatrix();
}
```

Finalmente el sistema de lluvia está formado por **un conjunto de gotas, cuya ejecución consiste en dibujar iterativamente todas las gotas que posee el sistema.**

## Herramientas y recursos utilizados <a id="tools-and-resources"></a>

- [*Tree*. Model by Google](https://poly.google.com/view/6pwiq7hSrHr) - Modelo de árbol construido en Google Blocks bajo licencia Creative Commons BY.
- [*Bench*. Model by Google](https://poly.google.com/view/6HQPOMqyQTv) - Modelo de banco construido en Google Blocks bajo licencia Creative Commons BY.
- [*Lamp post.* Model by Google](https://poly.google.com/view/ez9fM9NvtRB) - Modelo de farola construido en Google Blocks bajo licencia Creative Commons BY.
- [*Ground leaves*. Texturelib](http://texturelib.com/#!/category/?path=/Textures/ground/ground%20leaves) - Fuente de texturas de libre uso.
- [Giphy](https://giphy.com) - Herramienta usada para la creación de gifs a partir de los frames de la aplicación.

## Referencias <a id="references"></a>
- ***Guión de Prácticas 2019/20**, Creando Interfaces de Usuario*. Modesto F. Castrillón Santana, J Daniel Hernández Sosa.


