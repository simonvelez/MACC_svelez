/* 
Parcial III
Simón Vélez Castillo
Algoritmos y Estructuras de Datos
Universidad del Rosario 2023
*/

#include <iostream>
#include <map>
#include <set>

using namespace std;

template<typename T>
class Nodo{
private:
  T dato;
  Nodo* next;

public:

 Nodo(T d){
     dato = d;
     next =  NULL;
 }
 
 ~Nodo(){
 }
 
 T get_dato(){
     return dato;
 }
 
 void set_dato(T d){
     dato = d;
 }
 
 Nodo* get_next(){
     return next;
 }
 
 void set_next(Nodo* n){
     next = n;
 }
 
    
};

template<typename T>
class Cola{
private:
  Nodo<T>* ptr;
  int size;

public:

    Cola(){
        ptr = NULL;
        size = 0;
    }
  
    ~Cola(){
        Nodo<T>* temp = ptr;
        if(ptr != NULL){
            Nodo<T>* temp_next = ptr->get_next();
            while(temp_next != NULL){
                delete temp;
                temp = temp_next;
                temp_next = temp->get_next();
            }
            delete temp; //Borrar el último nodo
        }
    }
    
    void add(T d){
        Nodo<T>* nodo = new Nodo<T>(d);
        
        if(ptr == NULL){//La lista está vacía
            ptr  = nodo;
        }else{//La lista no está vacía
            Nodo<T>* temp =  ptr;
            while(temp->get_next() != NULL){
                temp = temp->get_next();
            }
            temp->set_next(nodo);
        }
        size++;
    }
    
    void insert(T d, int i){
        if(i<=size && i>=0 && ptr != NULL){
            Nodo<T>* nodo = new Nodo<T>(d);
            if(i == 0){
                nodo->set_next(ptr);
                ptr = nodo;
            }else{
                int j = 0;
                Nodo<T>* temp =  ptr;
                while(j<i-1){
                    temp = temp->get_next();
                    j++;
                }
                nodo->set_next(temp->get_next());
                temp->set_next(nodo);
            }
            size++;
        }else{//Si el índice es incorrecto o la lista está vacía, se añade al final
            add(d);
        }
        
    }
    
    void print(){
        if(ptr == NULL){//La lista está vacía
            cout<<"La cola está vacía"<<endl;
        }else{//La lista no está vacía
            Nodo<T>* temp =  ptr;
            while(temp != NULL){
                //cout<<temp->get_dato()<<","<<temp->get_next()<<"\t";
                cout<<temp->get_dato()<<"\t";
                temp = temp->get_next();
            }
            cout<<endl;
        }
    }
    
    Nodo<T>* get(int i){
        if(i>=0 && i<size){
          int j=0;
          Nodo<T>* temp = ptr;
          while(j<i){
              temp = temp->get_next();
              j++;
          }
          return temp;
        }
        return NULL;
    }
    
        int get_size(){
            return size;
        }
        bool isEmpty(){
            if(size == 0){
                return true;
            }else{
                return false;
            }
        }
        void enqueue(T val){
            insert(val, 0);
        }
        T dequeue(){
            if (size == 0){
                cout<<"Error! (dequeue en lista vacía)"<<endl;
                return NULL;
            }
            if (size ==1){
                Nodo<T>* popped = get(size-1);
                ptr = NULL;
                size--;
                return popped->get_dato();
            }
            else{
                Nodo<T>* popped = get(size-1);
                get(size-2)->set_next(NULL);
                delete get(size-1);
                size--;
                return popped->get_dato();
            }
        }
        T peek(){
            if (size == 0){
                cout<<"Error! (peek en lista vacía)"<<endl;
                return NULL;
            }
            return get(size-1)->get_dato();
        }
        void clear(){
            if (size > 0){
                dequeue();
                clear();
            }
        }
};

bool verifica_contra(string pss){
    set<char> numeros;
    set<char> may;
    set<char> min;
    
    for (int i = 0; i<10; i++ ){  //Agrega números del 1 al 9 a numeros en char.
        numeros.insert(i + '0');
    }
    string temp_min = "abcdefghijklmnñopqrstuvwxyz";
    for (int i = 0; i<28; i++ ){  //Agrega las letras minúsculas a minus.
        min.insert(temp_min[i]);
    }
    string temp_may = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
    for (int i = 0; i<28; i++ ){  //Agrega las letrass mayústuclas a mayus.
        may.insert(temp_may[i]);
    }
        
    bool mayus = false, minus = false, digitos = false, largo = false; // Verificar que tenga mayúsculas, minúsculas, números y carácteres especiales
    for (int i=0; i<pss.length(); i++){
        if (numeros.count(pss[i])){
            digitos = true;
        }
        if (may.count(pss[i])){
            mayus = true;
        }
        if (min.count(pss[i])){
            minus = true;
        }
        if (pss.length() > 4){ //Si no es num, minúscula o mayúscula, es caracter especial
            largo = true;
        }
    }
    if (!digitos){
        cout<<"La contraseña debe incluir al menos un número. :("<<endl;
    }
    if (!minus){
        cout<<"La contraseña debe incluir al menos una minúscula. :("<<endl;
    }
    if (!mayus){
        cout<<"La contraseña debe incluir al menos una mayúscula. :("<<endl;
    }
    if (!largo){
        cout<<"La contraseña debe incluir al menos 5 caracteres. :("<<endl;
    }
    return digitos && minus && mayus && largo;
}



int main()
{
    Cola<string> c; // Cola con los usuarios
    map<string, string> mapa; //mapa donde se guardan las contraseñas
    
    int usuarios;
    cout <<"Ingrese cantidad de usuarios: ";
    cin>> usuarios;
    
    for (int i = 0; i<usuarios; i++){
        string temp = "";
        cout<<"Ingrese nombre del "<<i+1<< " usuario = ";
        cin>>temp;
        c.enqueue(temp);
        temp = "";
    }
    
     while (!c.isEmpty()){
         string pss;
         cout<<"Ingrese contraseña para el usuario " <<c.peek()<< " = ";
         cin>>pss;
         
         while(!verifica_contra(pss)){
            cout<<"Contraseña incorrecta\n"<<"Ingrese contraseña para el usuario " <<c.peek()<< " = ";
            cin >>pss; 
         }
         mapa[c.dequeue()] = pss;
     }
     
  map<string, string>::iterator it2 ;
  it2 = mapa.begin();
  
  while (it2 != mapa.end())
  {
    cout << "Usuario: " << it2->first << ", Contraseña: " << it2->second << endl;
    ++it2;
  }

    return 0;
}


