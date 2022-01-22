# rick_and_morty

## Información general

Proyecto en flutter para consulta de la API https://rickandmortyapi.com con los personajes y sus
detalles de la serie Rick and Morty.

El proyecto consta de 2 ventanas:

    - ventana de scroll general de personajes
    - ventana de detalles de personaje seleccionado

Este proyecto está construido implementando Test Driven Development con Clean Architecture y
utilizando BLoC y provider para el manejo de estados. Además el proyecto cumple con Null Safety.

## Para compilar

Versión de Flutter: Channel stable, 2.5.3 Versión Dart: 2.14.4

    - para la instalación de flutter: https://docs.flutter.dev/get-started/install
    - En android studio, ir a preferencias, plugins y descargar flutter y dart (se debe reiniciar
      Android Studio).
    - una vez instalado flutter, en android studio ir a preferencias, lenguajes y frameworks, flutter y
     configurar la ruta donde se descargó Flutter.
    - En la terminal correr el comando 'flutter pub get' para cargar las dependencias del proyecto.
    - compilar en emulador o en dispositivo movil con permisos de desarrollador activados.

## Descarga el apk

Descarga el .apk del siguiente
Drive: https://drive.google.com/drive/folders/1LJav72AreNaDvu-ggosVHzcm10i27ybc?usp=sharing

El apk recomendado es app.apk sin embargo también pueden encontrar las versiones para arm64-v8a,
armeabi-v7a y x86_64 en el drive.

Trasladar el .apk al dispositivo movil y activar la configuración de seguridad para instalar
aplicaciónes desarrolladas por terceros.
