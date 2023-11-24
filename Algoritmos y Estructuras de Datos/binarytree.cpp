/* 
Árbol binario
Simón Vélez
Algoritmos y Estructuras de Datos
Universidad del Rosario, 2023
*/

#include <iostream>
using namespace std;

struct Nodo{
    int dato;
    Nodo* izq;
    Nodo* der;
};

Nodo* crear_nodo(int n){
    Nodo* nodito = new Nodo();
    nodito->dato = n;
    nodito->izq = NULL;
    nodito->der = NULL;
   
    return nodito;
}
void insertar(Nodo*& arbol,int n){
    if(arbol == NULL){
        Nodo *nuevo_nodo = crear_nodo(n);
        arbol = nuevo_nodo;
    }else{
        if((arbol->dato) < n){
            insertar(arbol->der,n);
        }
        else{
            insertar(arbol->izq,n);
        }
    }
}

void treeprint(){
    
}
void treebuscar(Nodo*& arbol, int valor){
    if (arbol == NULL){
        cout <<"no existe el dato";
        return;
    }
     if (arbol->dato == valor){
        cout<<"el dato es "<<valor;
        return;
    }
     else if (valor > arbol->dato){
        treebuscar(arbol->der, valor);
    }
    else{
        treebuscar(arbol->izq, valor);
    }
    
    
}

int main()
{
    Nodo *arbolito = NULL;
    insertar(arbolito, 10);
    insertar(arbolito, 9);
    insertar(arbolito, 11);
    treebuscar(arbolito, 0);
    

    return 0;
} 
