
// Clase Vector Pila (Stack)

#include<iostream>

using namespace std;

template <typename T>
class Pila{
    private:
        int size;
        int capacidad;
        T* v;
    public:
        void initiate_pila(int c){
            v = new T[c];
        }
        Pila(int n){
            size =0;
            capacidad =n;
            initiate_pila(n);
        }
        Pila(){
            
            size=0;
            capacidad =10;
            initiate_pila(capacidad);
        }
        ~Pila(){
            delete[] v;
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

        void print(){
            
            for(int i =0; i<size; i++){
                cout<<v[i]<<"\t";
            }
            cout<<endl;
        }
        Pila<T>& operator=( Pila<T>& f){
            capacidad = f.capacidad;
            size=f.size;
            initiate_pila(capacidad);
            
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
        
        friend std::ostream& operator<<(std::ostream& os, Pila<T>& b){
            return os << b.to_string();
        }
        
        // Métodos de la pila
        int get_size(){
            return size;
        }
        
        bool isEmpty(){
            if (size == 0){
                return true;
            }else{
                return false;
            }
        }
        
        void push(T valor){
            if(size == capacidad){
                incrementar_capacidad();
            }
            v[size++] = valor;
        }
            
        T pop(){
            if (size == 0){
                cout<<"Error! (pop en lista vacía)"<<endl;
                return NULL;
            }
            else{
                T popped = v[size-1];
                T* new_v = new T[size-3];
                for(int i =0;i<(size-1);i++){
                    new_v[i]=v[i];
                }
                T* old_v =v;
                v = new_v;
                delete[] old_v;
                return popped;
            }
        }
        
        T peek(){
            return v[size-1];
        }
        void clear(){
            if (size > 10){
                pop();
                clear();
            }
        }
};

int main()
{
    Pila<int> p = Pila<int>();
    
    int size = 40;
    for(int i = 0; i<size; i++){
        p.push(rand()%size);
    }
    
    p.print();
    cout<<p.get_size()<<"  "<<p.isEmpty()<<"  "<<p.peek()<<endl;
    p.pop();
    p.print();
    
    return 0;
}
