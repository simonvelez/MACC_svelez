"""
Proyecto de Primer Corte - Programación de Sockets

Piedra Papel Tijera

Simón Vélez Castillo
"""

import random

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

while True:
    opciones = ["piedra", "papel", "tijera"]
    
    # Elección del Jugador
    elec = input("Seleccione piedra, papel o tijera [piedra/papel/tijera]\n").lower()
    while elec not in opciones:
        elec = input("Comando inválido, escriba 'piedra', 'papel' o 'tijera'\n").lower()
    
    # Elección del server
    elec_server = random.choice(opciones)
    
    # Determinar el ganador
    resultado = ""
    if elec_server == elec:
        resultado = "empate"
    elif (elec == "piedra" and elec_server == "papel") or (elec_server == "piedra" and elec == "papel"):
        result = 'papel'
    elif (elec == "piedra" and elec_server == "tijera") or (elec_server == "piedra" and elec == "tijera"):
        result = 'piedra'
    elif (elec == "papel" and elec_server == "tijera") or (elec_server == "papel" and elec == "tijera"):
        result = 'tijera' 
        
    # Imprimir resultados
    
    if resultado == "empate":
        print("¡Empate! No hay ganadores.")
    elif resultado == elec:
        print(f"¡Ganaste con {elec}! Bien jugado :3")
    else:
        print(f"Tu {elec} no fue suficiente para ganar. Inténtalo de nuevo :(")
    
    # Empezar nueva partida
    if input("¿Quieres jugar de nuevo? [Y/N]\n").lower == "n":
        break
    