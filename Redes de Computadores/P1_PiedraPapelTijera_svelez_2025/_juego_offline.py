"""
Proyecto de Primer Corte - Programación de Sockets

Piedra Papel Tijera

Simón Vélez Castillo
"""

# Versión offline - No hace parte de la entrega del proyecto

import random
import time

# Versión contra el servidor

# Créditos iniciales
print(
      "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n",
      "Piedra Papel Tijera\n",
      "Proyecto Corte 1 - Programación de Sockets\n",
      "Redes de Computadores\n",
      "Simón Vélez Castillo, Universidad del Rosario",
      "Febrero 2025\n"
      "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n"
      )

puntos = 0
opciones = ["piedra", "papel", "tijera"]
while True:
    
    # Ver el puntaje actual
    print(f"Has ganado {puntos} puntos.")
    time.sleep(0.5)

    # Elección del Jugador
    elec = input("Seleccione piedra, papel o tijera [piedra/papel/tijera]\n").lower()
    if elec == "": # Si el usuario no da input elige al azar
        elec = random.choice(opciones)
        print(f"Elegiste aleatoriamente... {elec}")
    while elec not in opciones:
        elec = input("Comando inválido, escriba 'piedra', 'papel' o 'tijera'\n").lower()

    
    # Elección del server
    print("Esperando al servidor...\n")
    time.sleep(0.5)
    elec_server = random.choice(opciones)
    print(f"¡El servidor eligió {elec_server}!")
    
    # Determinar el ganador
    print(f"{elec} vs {elec_server}")
    resultado = ""
    if elec_server == elec:
        resultado = "empate"
    elif (elec == "piedra" and elec_server == "papel") or (elec_server == "piedra" and elec == "papel"):
        resultado = "papel"
    elif (elec == "piedra" and elec_server == "tijera") or (elec_server == "piedra" and elec == "tijera"):
        resultado = "piedra"
    elif (elec == "papel" and elec_server == "tijera") or (elec_server == "papel" and elec == "tijera"):
        resultado = "tijera"
        
    # Imprimir resultados
    time.sleep(0.5)
    if resultado == "empate":
        print("¡Empate! No hay ganadores. +1 punto")
        puntos += 1
    elif resultado == elec:
        print(f"¡Ganaste con {elec}! Bien jugado. +3 puntos :3")
        puntos += 3
    else:
        print(f"Tu {elec} no fue la mejor decisión. -1 punto :(")
        puntos -= 1
    
    # Empezar nueva partida
    seguir = input("¿Quieres jugar de nuevo? [Y/N]\n").lower()
    if seguir == "n":
        break

# Texto final
print("¡Muchas gracias por jugar!")
print(f"Tu puntaje final es: {puntos}. ¡Bien hecho! :D")