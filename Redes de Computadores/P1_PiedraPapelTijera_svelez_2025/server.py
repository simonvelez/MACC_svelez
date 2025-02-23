"""
Proyecto de Primer Corte - Programación de Sockets

Piedra Papel Tijera

Simón Vélez Castillo
"""

# Ejecutar para iniciar el servidor

import socket
import threading
import random
import time

opciones = ["piedra", "papel", "tijera"]
salas = [] # Lista de salas de juego activas, cada una con dos jugadores
cola = [] # Lista de jugadores esperando entrar a una sala

# Partida entre dos clientes
def partida_clientes(c1, c2):
    puntos1, puntos2 = 0, 0

    while True:
        try:
            c1.send(f"Tu puntaje actual: {puntos1}".encode('utf-8'))
            c2.send(f"Tu puntaje actual: {puntos2}".encode('utf-8'))
            c1.send("Seleccione piedra, papel o tijera [piedra/papel/tijera]\n".encode('utf-8'))
            c2.send("Seleccione piedra, papel o tijera [piedra/papel/tijera]\n".encode('utf-8'))

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

            # Imprimir resultados y sumar puntos
            if resultado == "empate":
                c1.send("¡Empate! No hay ganadores. Ganas 1 punto :O".encode('utf-8'))
                c2.send("¡Empate! No hay ganadores. Ganas 1 punto :O".encode('utf-8'))
                puntos1 += 1
                puntos2 += 1
            elif resultado == elec1:
                c1.send(f"¡Ganaste con {elec1}! Bien jugado. Ganaste 3 puntos :3".encode('utf-8'))
                puntos1 += 3
                c2.send(f"Tu {elec2} no fue la mejor decisión. Perdiste 1 punto :(".encode('utf-8'))
                puntos2 -= 1
            elif resultado == elec2:
                c1.send(f"Tu {elec1} no fue la mejor decisión. Perdiste 1 punto :(".encode('utf-8'))
                puntos1 -= 1
                c2.send(f"¡Ganaste con {elec2}! Bien jugado. Ganaste 3 puntos :3".encode('utf-8'))
                puntos2 += 3

            # Preguntarles si desean jugar de nuevo
            c1.send("¿Quieres jugar de nuevo? [Y/N]".encode('utf-8'))
            c2.send("¿Quieres jugar de nuevo? [Y/N]".encode('utf-8'))
            continuar1 = c1.recv(1024).decode('utf-8').lower()
            continuar2 = c2.recv(1024).decode('utf-8').lower()

            if continuar1 == "n" or continuar2 == "n":
                c1.send(f"¡Muchas gracias por jugar! Tu puntaje es: {puntos1}. ¡Bien hecho! :D".encode('utf-8'))
                c2.send(f"¡Muchas gracias por jugar! Tu puntaje es: {puntos2}. ¡Bien hecho! :D".encode('utf-8'))
                break

        except:
            print("Un jugador se desconectó. Cerrando lobby.")
            c1.close()
            c2.close()
            break


# Partida contra el servidor
def partida_server(client_socket):
    while True:
        try:
            # Elección del Jugador
            client_socket.send("Seleccione piedra, papel o tijera [piedra/papel/tijera]".encode('utf-8'))
            elec = client_socket.recv(1024).decode('utf-8').strip().lower()
            if elec == "": # Si el usuario no da input elige al azar
                elec = random.choice(opciones)
                client_socket.send(f"Elegiste aleatoriamente... {elec}\n".encode('utf-8'))
            while elec not in opciones:
                client_socket.send("Comando inválido, escriba 'piedra', 'papel' o 'tijera': ".encode('utf-8'))
                elec = client_socket.recv(1024).decode('utf-8').strip().lower()

            
            # Elección del server
            client_socket.send("Esperando al servidor...\n".encode('utf-8'))
            time.sleep(0.5)
            elec_server = random.choice(opciones)
            client_socket.send(f"¡El servidor eligió {elec_server}!\n".encode('utf-8'))
            
            # Determinar el ganador
            client_socket.send(f"{elec} vs {elec_server}".encode('utf-8'))
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
                client_socket.send("¡Empate! No hay ganadores. :O".encode('utf-8'))
            elif resultado == elec:
                client_socket.send(f"¡Ganaste con {elec}! Bien jugado. :3".encode('utf-8'))
            else:
                client_socket.send(f"Tu {elec} no fue la mejor decisión. :(".encode('utf-8'))
            
            # Preguntar si desea jugar de nuevo
            client_socket.send("¿Quieres jugar de nuevo? [Y/N]".encode('utf-8'))
            continuar = client_socket.recv(1024).decode('utf-8').lower()

            if continuar == "n":
                client_socket.send(f"¡Muchas gracias por jugar! :D".encode('utf-8'))
                break

        except:
            print("Error cargando la partida.")
            client_socket.close()
            break

def handle_client(client_socket):
    try:
        menu = ("Bienvenido!\n"
                "Seleccione el modo de juego:\n"
                "1. Multijugador\n"
                "2. Jugar contra el servidor (Bot)\n"
                "Escribe '1' o '2': ")
        client_socket.send(menu.encode('utf-8'))
        modo = client_socket.recv(1024).decode('utf-8').strip()
    except Exception:
        print("Error al leer el modo:")
        client_socket.close()
        return

    if modo == '1': # Multijugador
        # Irá añadiendo jugadores a la cola hasta poder empezar una partida

        cola.append(client_socket)
        print("Jugador esperando en la fila...")
        
        while len(cola) >= 2:
            c1 = cola.pop(0)
            c2 = cola.pop(0)

            # Crear un nuevo hilo con la sala de juego
            partida = threading.Thread(target=partida_clientes, args=(c1, c2))
            partida.start()
            salas.append(partida)
            
        time.sleep(1)
    elif modo == '2': # Contra el servidor
        partida_server(client_socket)
    else:
        client_socket.send("Opción inválida. Conéctese de nuevo.\n".encode('utf-8'))
        client_socket.close()

 


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