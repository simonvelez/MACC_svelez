/* 
Estructuras de datos: Cola (En vector)
Simón Vélez
Universidad del Rosario, 2023
*/

#include<iostream>
#include <algorithm>

using namespace std;

template <typename T>
class Cola{
    private:
        int size;
        int capacidad;
        T* v;
    public:
        void initiate_cola(int c){
            v = new T[capacidad];
        }
        Cola(int n){
            size =0;
            capacidad =n;
            initiate_cola(n);
        }
        Cola(){
            
            size=0;
            capacidad =10;
            initiate_cola(capacidad);
        }
        ~Cola(){
            delete[] v;
        }
        int get_size(){
            return size;
        }
        int get_capacidad(){
            return capacidad;
        }
        T get(int i){
            if(i>=0 && i<size){
                return v[i];
            }
            else{
                return NULL;
            }
        }
        void incrementar_capacidad(){
            capacidad*=2;
            T* new_v = new T[capacidad];
            for(int i =0;i<size;i++){
                new_v[i]=v[i];
            }
            T* old_v =v;
            v = new_v;
            delete[] old_v;
        }
        void add(T valor){
            if(size == capacidad){
                incrementar_capacidad();
            }
            v[size++] = valor;
        }
        void print(){
            
            for(int i =0; i<size; i++){
                cout<<v[i]<<"\t";
            }
            cout<<endl;
        }
        Cola<T>& operator=( Cola<T>& f){
            capacidad = f.capacidad;
            size=f.size;
            initiate_cola(capacidad);
            
            for(int i =0; i<size;i++){
                v[i]=f.get(i);
            }
            return *this;
        }
        string to_string(){
            string s = "";
            for(int i =0; i<size;i++){
                s=s + std::to_string(v[i]) + "\t";
            }
            return s;
        }
        
        friend std::ostream& operator<<(std::ostream& os, Cola<T>& b){
            return os << b.to_string();
        }
        
        bool isEmpty(){
            
        }
        void enqueue(T val){
            
        }
        T dequeue(){
            
        }
        T peek(){
            
        }
        void clear(){
            
        }
};

int main()
{
    //Crear y llenar cola c
    Cola<int> c = Cola<int>();
    int tam = 40;
    for(int i = 0; i<tam; i++){
        c.add(rand()%tam);
    }
    
    
    c.print();
    
    return 0;
}