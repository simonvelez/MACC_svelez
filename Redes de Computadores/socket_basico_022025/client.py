import socket
import struct
import cv2
import numpy as np
import os

def main():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)


    print("Connected to the server. Type messages to send.")

    while True:
        size = server.recv(16).decode('utf-8')
        if not size:
            break
        data = b''
        while len(data) < size:
            packet = server.recv(size)
            if not packet:
                break
            data += packet
        frame_data = np.frombuffer(data, dtype= np.uint8)
        frame = cv2.imdecode(frame_data, cv2.IMREAD_COLOR)
        cv2.imshow('Video', frame)
        cv2.waitkey(1)    
    
        # Código envío de archivos 050225
        # file_path = input("Enter the path of the file to send:")
        # if os.path.isfile(file_path):
        #     filename = os.path.basename(file_path)
        #     file_size = os.path.getsize(file_path)

        #     # Enviar el tamanno del nombre del archivo

        #     filename_size = len(filename)
        #     client.sendall(struct.pack('!I',filename_size))

        #     # Enviar el nombre del archivo

        #     client.sendall(struct.pack('!Q',file_size))

        #     file = open(file_path, 'rb')
        #     while True:
        #         data = file.read(4096)
        #         if not data: break
        #         client.sendall(data)
        #     print("File sent successfully :3")
        #     file.close()


if __name__ == "__main__":
    main()