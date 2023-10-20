
/* 
Ejercicio: Notación Polaca Invertida
Simón Vélez
Algoritmos y Estructuras de Datos
Universidad del Rosario, 2023
*/

#include<iostream>
#include <string.h>

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

Pila<int> polacinv(Pila<string> polac){ //Retorna la pila de resultados de una pila en polaco inverso
    Pila<int> res; 
    Pila<int> temp; //Pila para los cálculos de cada expresión
    float tam =  polac.get_size();
    float vals = tam; //Expresiones válidas
    bool val = true;
    string expr = polac.peek();
    
    while (not polac.isEmpty()){
        val = true;
        expr = polac.peek();
        temp.clear();
        for (int j = 0; j< expr.size(); j++){ //Iterar sobre cada elemento de la expresión
            if (val = false){
                vals--;
                polac.pop();
                break;
            }
            int a = 0;
            int b = 0;
            if (isdigit(expr[j])){
                temp.push(int(expr[j]-'0'));
            }else{
                if (temp.get_size() > 1){
                    switch(expr[j]){
                        case '+':
                            b = temp.pop();
                            a = temp.pop();
                            temp.push(a+b);
                            break;
                        case '-':
                            b = temp.pop();
                            a = temp.pop();
                            if (b>a){
                                val = false;
                            }else{
                                temp.push(a-b); 
                            }
                            break;
                        case '*':
                            b = temp.pop();
                            a = temp.pop();
                            temp.push(a*b);
                            break;
                        case '/':
                            b = temp.pop();
                            a = temp.pop();
                            if (b==0){
                                val = false;
                            }else{
                                temp.push(a/b); 
                            }                       
                            break;
                        default:
                            val = false; // Si el elem no es un número ni un signo, la expresión es inválida
                    }
                }else{
                    val = false; // Si se quiere hacer una operación con menos de dos elementos, la expresión es inválida
                }
            }
            
        }
        if (temp.get_size()==1){
            res.push(temp.peek());
        }else{
            vals--;
        }
        polac.pop();

    }
    cout<<"La pila tiene "<<vals<<" expresiones válidas de "<<tam<<", un "<<(vals/tam)*100<<"%."<<endl;
    return res;
}

int main()
{
    int num_exp; 
    cout<<"¿Cuántas expresiones se quieren leer?"<<endl;
    cin>>num_exp;
    
    Pila<string> polac;
    if (num_exp > 0){ //Agregar las expresiones a la pila Polaca Invertida
        for(int i=1; i<num_exp+1; i++){
           string temp = "";
           cout<<"Ingrese la expresión número "<<i<<endl;
           cin>>temp;
           polac.push(temp);
        }
    }else{
        cout<<"Inserte un número válido de expresiones. :("<<endl<<endl;
        main();
    }
    cout<<"Expresiones agregadas:"<<endl;
    polac.print();
    cout<<"Resultados al evaluar las expresiones: "<<endl;
    polacinv(polac).print(); 
    
    return 0;
}
