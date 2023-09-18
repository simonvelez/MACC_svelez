//Parcial 1 Algoritmos y Estructuras de Datos 2023
// Simón Vélez Castillo

#include<iostream>

using namespace std;

class envio{
    int mangas;
    int prefectura;
    envio* next;

public:

 envio(){
     prefectura = 0;
     mangas = 0;
     next = NULL;
 }
 envio(int parametro01, int parametro02){
     mangas = parametro01;
     prefectura = parametro02;
     next = NULL;
 }
 ~envio(){
 }
 int get_prefectura(){
     return prefectura;
 }
 
 int get_mangas(){
     return mangas;
 }
 
 envio* get_next(){
        return next;
    }
 
 void set_prefectura(int pre){
     prefectura = pre;
 }
 
  void set_mangas(int man){
     mangas = man;
 }
 void set_next(envio* n){
        next = n;
    }
};

class Lista{
private:
    envio* ptr;
    int size;

public:

    Lista(){
        ptr = NULL;
        size = 0;
    }
 
    void agregar_elemento (int parametro01, int parametro02){
        envio* nodo = new envio(parametro01,parametro02);
        if (ptr == NULL){
            ptr = nodo;
        }else{
            envio* temp =  ptr;
            while(temp->get_next() != NULL){
                temp = temp->get_next();
            }
            temp->set_next(nodo);
        }
        size++;
    }
    
    
    void print(){
        if(ptr == NULL){
            cout<<"La lista está vacía"<<endl;
        }else{
            envio* temp = ptr;
        
            
            cout<<"-----------------------"<<endl;
            while(temp != NULL){
               
                cout<<"(Mangas : "<<temp->get_mangas()<<" , Prefectura: "<<temp->get_prefectura()<< ")"   <<"\n";
                temp = temp->get_next();
            }
            cout<<"-----------------------";
            cout<<endl;
        }
    }
    
    envio* get(int i){
        if(i>=0 && i<size){
          int j=0;
          envio* temp = ptr;
          while(j<i){
              temp = temp->get_next();
              j++;
          }
          return temp;
        }
        return NULL;
    }
    
};

int main()
{
    //Semilla de numeros aleatorios (se recomienda no cambiarla)
    srand(9605);
    int envios;
    int prefecturas = 47;
    // Se solicita al usuario ingresar la cantidad de envios para las simulaciones
    cout<<"Inserte la cantidad de envíos para las simulaciones: ";
    cin>> envios;
    
    
    //Creacion de las listas de simulacion para guardar las simulaciones
    Lista simu01;
    Lista simu02;
    
    //llenar  la simulacion 1 (lista) de elementos aleatorios 
    for (int i =0; i<envios; i++){
        simu01.agregar_elemento(rand()%11,rand()%47);
    }
    
    //Imprimir la simulacion 1
    cout<<"Simulación 01: "<<endl;
    simu01.print();
    
    //llenar  la simulacion 2 (lista) de elementos aleatorios 
    for (int i =0; i<envios; i++){
        simu02.agregar_elemento(rand()%11,rand()%47);
    }
    
    //Imprimir la simulacion 2
    cout<<"Simulación 02: "<<endl;
    simu02.print();
    //Imprimir los librillos dediferencia comparando las simulaciones 
    //(Se recomienda la estructura de doble for y 3 condicionales)
    //Usted puede proponer cualquier solucion que cumpla con el enunciado
    double s1, s2;
    for (int i=0; i<prefecturas; i++){
        for (int j=0; j<envios; j++){
            if (simu01.get(j)->get_prefectura() == i){
                s1 += simu01.get(j)->get_mangas();
            }
            if (simu02.get(j)->get_prefectura() == i){
                s2 += simu02.get(j)->get_mangas();
            }
        }
        
        if(s1 != s2){
            cout<<endl<< "En la prefectura " << i <<" se enviaron " << (s2-s1)*10<< " librillos de diferencia con respecto a la 2da simulacion"<< endl;
        }
        s1 = 0;
        s2 = 0;
    }
    
    
    cout<<"---------------------------------------------"<<endl;
    cout<<"Diferencias entre arreglos y vectores: "<<endl;
    string r1[] = {"Los arreglos tienen tamaño fijo.", "Los arreglos pueden tener varias dimensiones (matrices), los vectores son unidimensionales.", "Los vectores son un tipo de arreglo, pero los arreglos no son tipos de vectores."};
    for(int i =0; i<3; i++){
        cout<< "Respuesta "<<i+1<<": "<<r1[i]<<endl;
    }
    cout<<"---------------------------------------------"<<endl;
    cout<<"Diferencias entre listas y vectores: "<<endl;
    string r2[] = {"Los vectores se guardan seguidos en memoria, los elementos de las listas se pueden guardar en dif. direcciones.", "Cada nodo de la lista tiene info y apuntador, mientras que cada elemento del vector solo tiene info.", "La estructura de las listas es mucho más laxa, permitiendo listas circulares o doble enlazadas, lo que no permiten los vectores."};
    for(int i =0; i<3; i++){
        cout<< "Respuesta "<<i+4<<": "<<r2[i]<<endl;
    }
    cout<<"---------------------------------------------"<<endl;
    cout<<"¿Para que sirve el constructor en una clase?"<<endl;
    cout<< "Respuesta 7: " <<"Sirve para asignarle los datos a la clase, ya sea los indicados por el usuario/programa o unos por defecto para que la clase pueda trabajar."<<endl;
    cout<<"---------------------------------------------"<<endl;
    cout<<"¿Cuántos constructores se pueden tener en una clase?"<<endl;
    cout<< "Respuesta 8: " <<"Dos, uno que se llama si el usuario no da argumentos y otro que se llama si el usuario sí los da."<<endl;
    cout<<"---------------------------------------------"<<endl;
    cout<<"¿Para qué sirven los apuntadores en C++?"<<endl;
    cout<< "Respuesta 9: " <<"Para referenciar direcciones de memoria, acceder a ellas y modificarlas."<<endl;
    cout<<"---------------------------------------------"<<endl;
    cout<<"¿Qué significa que en una variable se le asigne NULL?"<<endl;
    cout<< "Respuesta 10: "<<"Significa que su valor, independientemente de su tipo, es vacío."<<endl;
   
    return 0;
}