import socket

def main():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect(('localhost', 5555))

    print("Connected to the server. Type messages to send.")

    while True:
        message = input("You: ")
        client.send(message.encode('utf-8'))

if __name__ == "__main__":
    main()