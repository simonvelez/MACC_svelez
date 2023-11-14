/* 

Proyecto - Solitario

Valeria Arce
Juliana Contreras
Santiago Jorigua
Simón Vélez

Algoritmos y Estructuras de Datos
Universidad del Rosario, 2023

*/

#include<iostream>

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
class Lista{
private:
  Nodo<T>* ptr;
  int size;

public:

    Lista(){
        ptr = NULL;
        size = 0;
    }
  
    ~Lista(){
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
    
    void multiadd(int size, T d[]){
        for (int i = 0; i<size; i++){
            add(d[i]);
        }
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
            cout<<"La lista está vacía"<<endl;
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
    
};

template<typename T>
class Pila{
private:
  Nodo<T>* ptr;
  int size;

public:

    Pila(){
        ptr = NULL;
        size = 0;
    }
  
    ~Pila(){
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
            cout<<"La pila está vacía"<<endl;
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
    void push(T val){
        insert(val, size);
    }
    T pop(){
        if (size == 0){
            cout<<"Error! (pop en lista vacía)"<<endl;
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
        Nodo<T>* nod_temp = get(size-1);
        return nod_temp->get_dato();
    }
    void clear(){
        if (size > 0){
            pop();
            clear();
        }
    }
    
};

class Mazo{
private:
    string suit[52] = {"AC","2C","3C","4C","5C","6C","7C","8C","9C","10C","JC","QC","KC","AD","2D","3D","4D","5D","6D","7D","8D","9D","10D","JD","QD","KD","AT","2T","3T","4T","5T","6T","7T","8T","9T","10T","JT","QT","KT","AP","2P","3P","4P","5P","6P","7P","8P","9P","10P","JP","QP","KP"}; //Todas las cartas disponibles
    Pila<string> mazo;
    int size;
    
public:
    Mazo(){
        size = 52;
        for (int i = 0; i < size; i++){
            mazo.push(suit[i]);
        }
    }
    Mazo(int tam, bool shuffled){
        size = tam;
        if (shuffled == true){
            for (int i = 0; i < size; i++){
                mazo.push(suit[rand()%52]);
            }
        }else{
            for (int i = 0; i < size; i++){
                mazo.push(suit[i]);
            }   
        }
    }
    
    void print(){
        mazo.print();
    }
    
    void shuffle(){
        Lista<string> temp;
        int rand_seq[size]; // Secuencia de números aleatorios no repetitivos
        
        for (int i = 0; i<size; i++){
            rand_seq[i] = i;
        }
        
        for (int i = 0; i<size; i++){
            temp.add(mazo.pop());
        }
        
        for (int i = 0; i<size; i++){
        
        }
    }
};

int main()
{
    Mazo m(11, false);
    m.print();
    return 0;
}