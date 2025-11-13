# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
#
# Implementación Regla de Shoelace y un ejemplo
#
# Juan José Reina Reyes y Simón Vélez Castillo
#
# Octubre 2025
# Entrega 4to corte - Análisis Numérico y Computación Científica
# Universidad del Rosario 2025
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# Implementación  - - - - - - - - - - - - - - - - - - - - - - - - -

import matplotlib.pyplot as plt

def areaShoelace (vertices): 
    # vertices: polígono con vértices (x_1, y_1), ... , (x_n, y_n)   
    n = len(vertices)
    suma_det = 0 # Suma total de los determinantes

    if n < 3: # Si hay menos de tres vértices no hay polígono :(
        return 0.0

    for i in range(n):
        x_i, y_i = vertices[i]
        
        # Usamos (i + 1) % n para que el último punto apunte al primero
        x_sig, y_sig = vertices[(i + 1) % n]
        
        # El término es (x_i * y_{i+1}) - (x_{i+1} * y_i)
        termino = (x_i * y_sig) - (x_sig * y_i)
        
        suma_det += termino
    
    area = 0.5 * abs(suma_det)
    
    return area

def grafArea(vertices, nomPol="Polígono"):
    # Graficar el polígono y el área calculada

    # vertices: polígono con vértices (x_1, y_1), ... , (x_n, y_n) 
    # nomPol: nombre del polinomio (por defecto "Polígono")
    
    x_coords = [v[0] for v in vertices]
    y_coords = [v[1] for v in vertices]
    
    # Añadir el primer vértice al final para cerrar la línea en el gráfico
    x_coords.append(vertices[0][0])
    y_coords.append(vertices[0][1])
    
    area = areaShoelace(vertices) # Calcular el área
    
    # Crear la gráfica
    etiqueta_leyenda = f"{nomPol} (Área = {area:.2f} u²)"
    
    plt.figure(figsize=(8, 6))
    
    plt.plot(x_coords, y_coords, marker='o', linestyle='-', color='blue', 
             label=etiqueta_leyenda)
             
    # Rellenar el polígono con los vértices originales
    plt.fill(x_coords[:-1], y_coords[:-1], color='lightblue', alpha=0.5)

    # Etiquetas de vértices
    for i, (x, y) in enumerate(vertices):
        plt.text(x, y, f'V{i+1} ({x}, {y})', fontsize=9, ha='right')
    
    # Títulos de los ejes y de la gráfica
    plt.title(f"Visualización del {nomPol}")
    plt.xlabel("Coordenada X")
    plt.ylabel("Coordenada Y")
    plt.grid(True)
    plt.axis('equal')

    # Visualización
    plt.legend()
    plt.show()


# Casos de ejemplo  - - - - - - - - - - - - - - - - - - - - - - -

# Caso 1: Pentágono
pentag = [(-2, -2), (-1, 3), (3, 4), (5, 0), (1, -4)]
print(f"El área del caso 1 es {areaShoelace(pentag)} u^2.")

# Caso 2: Decágono con coordenadas racionales
decag = [(-101.0, -63.25), (-72.5, -94.5), (-39.75, -75.5), (-9.0, -48.25), (91.5, -88.75), (114.25, -18.0), (58.25, -12.5), (47.0, 93.0), (33.5, 64.5), (-102.5, 22.0)]
print(f"El área del caso 2 es {areaShoelace(decag)} u^2.")

# Caso 3: El monstruo de los 100 vértices
monstruo = [(-120.5, -12.0), (-92.5, -13.75), (-87.75, -18.5), (-74.25, -16.75), (-4.0, 0.25), (-112.25, -35.25), (-69.5, -38.0), (-81.5, -46.5), (-105.25, -66.25), (-94.0, -63.0), (-108.5, -73.25), (-63.5, -45.25), (-32.0, -26.5), (-89.25, -73.25), (-72.25, -69.75), (-40.25, -43.25), (-120.5, -121.25), (1.75, -6.25), (-19.75, -29.75), (-86.5, -119.25), (-69.5, -99.5), (-27.5, -52.0), (-60.25, -112.0), (-3.75, -20.5), (-22.0, -113.5), (0.25, -53.25), (10.0, -93.5), (24.5, -76.25), (18.0, -25.75), (18.75, -25.75), (34.0, -75.25), (42.5, -89.25), (37.75, -64.0), (58.0, -95.75), (41.0, -57.25), (52.75, -66.0), (54.0, -64.5), (84.25, -111.0), (105.0, -123.0), (97.25, -112.0), (14.0, 1.5), (89.0, -77.75), (89.0, -33.0), (122.25, -46.25), (50.0, -10.75), (75.75, -15.5), (109.75, -23.75), (95.75, -7.0), (86.75, 0.25), (99.75, -0.25), (103.5, 2.75), (89.25, 13.75), (54.75, 13.25), (78.5, 18.75), (68.25, 19.5), (111.5, 31.25), (53.25, 19.75), (116.75, 49.5), (65.75, 34.0), (117.25, 77.5), (115.75, 81.0), (92.75, 70.0), (105.5, 80.5), (104.5, 86.0), (84.0, 69.25), (103.5, 90.75), (110.25, 106.5), (105.5, 119.75), (72.5, 83.0), (53.25, 62.0), (72.5, 107.75), (57.5, 85.0), (64.5, 102.5), (39.0, 60.25), (37.25, 101.5), (35.25, 116.0), (23.5, 91.75), (16.25, 122.0), (12.25, 57.0), (9.75, 95.0), (10.5, 44.75), (10.0, 47.25), (0.5, 98.0), (-12.0, 103.25), (-14.25, 92.0), (-24.25, 92.75), (-53.5, 68.25), (-46.5, 56.5), (-39.75, 47.75), (-77.25, 78.5), (-59.0, 59.75), (-31.25, 36.5), (-32.25, 33.5), (-47.25, 43.0), (-71.25, 51.25), (-63.0, 28.5), (-99.25, 27.25), (-121.75, 24.75), (-45.0, 5.25), (-46.5, 5.25)]   
print(f"El área del caso 3 es {areaShoelace(monstruo)} u^2.")

# Visualizaciones (quitar el comentario para visualizar)

#grafArea(pentag, "Caso 1: Pentágono")
#grafArea(decag, "Caso 2: Decágono con coordenadas racionales")
grafArea(monstruo, "Caso 3: El monstruo de los 100 vértices")