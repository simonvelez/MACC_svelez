import socket

def main():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect(('localhost', 5555))

    print("¡Conectado al servidor! esperando al otro jugador...")

    while True:
        # Recibir los mensajes de server.py
        response = client.recv(1024).decode('utf-8')
        print(response)

        if "Seleccione" in response: # Para filtrar los mensajes donde el server está pidiendo que el usuario haga un input
            message = input("> ").lower()
            client.send(message.encode('utf-8'))    
        
        elif "Bienvenido" in response:
            modo = input("> ").lower()
            client.send(modo.encode('utf-8'))    

        elif "¿Quieres jugar de nuevo?" in response:
            continuar = input("> ").lower()
            client.send(continuar.encode('utf-8'))

            if continuar == "n":
                print("Saliendo del juego...")
                break

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