"""
Proyecto de Primer Corte - Programación de Sockets

Piedra Papel Tijera

Simón Vélez Castillo
"""

# Ejecutar para iniciar el servidor

import socket
import threading
import random

opciones = ["piedra", "papel", "tijera"]
salas = [] # Lista de salas de juego activas, cada una con dos jugadores
cola = [] # Lista de jugadores esperando entrar a una sala

# Partida entre dos clientes
def partida_clientes(c1, c2):
    c1.send("Seleccione piedra, papel o tijera [piedra/papel/tijera]\n".encode('utf-8'))
    c2.send("Seleccione piedra, papel o tijera [piedra/papel/tijera]\n".encode('utf-8'))

    while True:
        try:
            # Elección de los jugadores
            elec1 = c1.recv(1024).decode('utf-8').lower()
            elec2 = c2.recv(1024).decode('utf-8').lower()
            if elec1 == "": # Si el usuario no da input elige al azar
                elec1 = random.choice(opciones)
                c1.send(f"Elegiste aleatoriamente... {elec1}".encode('utf-8'))
            if elec2 == "":
                elec2 = random.choice(opciones)
                c2.send(f"Elegiste aleatoriamente... {elec2}".encode('utf-8'))

            # Asegurarse de que el input sea válido
            while elec1 not in opciones:
                c1.send("Comando inválido, escriba 'piedra', 'papel' o 'tijera'".encode('utf-8'))
                elec1 = c1.recv(1024).decode('utf-8').lower()
            while elec2 not in opciones:
                c2.send("Comando inválido, escriba 'piedra', 'papel' o 'tijera'".encode('utf-8'))
                elec2 = c2.recv(1024).decode('utf-8').lower()

            # Determinar el ganador
            c1.send(f"{elec1} vs {elec2}".encode('utf-8'))
            c2.send(f"{elec2} vs {elec1}".encode('utf-8'))

            resultado = ""
            if elec1 == elec2:
                resultado = "empate"
            elif (elec1 == "piedra" and elec2 == "papel") or (elec2 == "piedra" and elec1 == "papel"):
                resultado = "papel"
            elif (elec1 == "piedra" and elec2 == "tijera") or (elec2 == "piedra" and elec1 == "tijera"):
                resultado = "piedra"
            elif (elec1 == "papel" and elec2 == "tijera") or (elec2 == "papel" and elec1 == "tijera"):
                resultado = "tijera"

            # Imprimir resultados
            if resultado == "empate":
                c1.send("¡Empate! No hay ganadores.".encode('utf-8'))
                c2.send("¡Empate! No hay ganadores.".encode('utf-8'))
            elif resultado == elec1:
                c1.send(f"¡Ganaste con {elec1}! Bien jugado. :3".encode('utf-8'))
                c2.send(f"Tu {elec2} no fue la mejor decisión. :(".encode('utf-8'))
            elif resultado == elec2:
                c1.send(f"Tu {elec1} no fue la mejor decisión. :(".encode('utf-8'))
                c2.send(f"¡Ganaste con {elec2}! Bien jugado. :3".encode('utf-8'))

        except:
            print("Un jugador se desconectó. Cerrando lobby.")
            c1.close()
            c2.close()
            break


# Partida contra el servidor
def partida_server(c1):
    pass

def handle_client(client_socket):
    # Irá añadiendo jugadores a la cola hasta poder empezar una partida

    cola.append(client_socket)
    print("Jugador esperando en la fila...")
    
    while len(cola) >= 2:
        c1 = cola.pop()
        c2 = cola.pop()

        # Crear un nuevo hilo con la sala de juego
        partida = threading.Thread(target=partida_clientes, args=(c1, c2))
        partida.start()
        salas.append(partida)


def main():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(('localhost', 5555))
    server.listen(10) # Permitir varias partidas simultáneas
    print("Server started, waiting for connections...")

    while True:
        client_socket, addr = server.accept()
        print(f"Connection from {addr} has been established!")
        client_handler = threading.Thread(target=handle_client, args=(client_socket,))
        client_handler.start()

if __name__ == "__main__":
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
    main()