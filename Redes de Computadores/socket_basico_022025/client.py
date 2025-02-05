import socket
import struct

def main():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect(('localhost', 5555))


    print("Connected to the server. Type messages to send.")

    while True:
        file_path = input("Enter the path of the file to send:")
        if os.path.isfile(file_path):
            filename = os.path.basename(file_path)
            file_size = os.path.getsize(file_path)

            # Enviar el tamaño del nombre del archivo

            filename_size = len(filename)
            client.sendall(struc.pacl('!I'.filename.size))

            # Enviar el nombre del archivo

            client.sendall(struc.pack('!Q'.file:size))

            file = open(file_pack, 'rb')
            while True:
                data = file.read(4096)
                if not data: break
                client.sendall(data)
            print("File sent successfully")


if __name__ == "__main__":
    main()