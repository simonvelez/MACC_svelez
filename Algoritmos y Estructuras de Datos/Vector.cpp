#include<iostream>
#include <algorithm>

using namespace std;

template <typename T>
class Vector{
    private:
        int size;
        int capacidad;
        T* v;
    public:
        void initiate_vector(int c){
            v = new T[capacidad];
        }
        Vector(int n){
            size =0;
            capacidad =n;
            initiate_vector(n);
        }
        Vector(){
            
            size=0;
            capacidad =10;
            initiate_vector(capacidad);
        }
        ~Vector(){
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
        Vector<T>& operator=( Vector<T>& f){
            capacidad = f.capacidad;
            size=f.size;
            initiate_vector(capacidad);
            
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
        
        friend std::ostream& operator<<(std::ostream& os, Vector<T>& b){
            return os << b.to_string();
        }
            
        
};

int main()
{
    
    Vector<int> v = Vector<int>();
    
    for(int i = 0; i<35; i++){
        v.add(i);
    }
    
    
    /*Vector<string> v = Vector<string>();
    
    for(int i = 0; i<25; i++){
        v.add(""+i);
    }*/
    
    v.print();
    cout<<endl;
    cout<<"La capacidad es: "<<v.get_capacidad()<<endl;
    
    cout<<endl;
    
    cout<<v<<"\n";
    
    
    
    Vector<int> w ;
    w=  v;
    
    w.print();
    
    cout<<"El otro vector es: "<<w;
    return 0;
}

