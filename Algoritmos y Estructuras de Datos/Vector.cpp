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
        
        void sec_sort(){
            int n = size, aux;
            for (int i = 0; i < n; i++){
                for (int j = 0; j < n; j++){
                    if (v[i] < v[j]){
                        aux = v[i];
                        v[i] = v[j];
                        v[j] = aux;
                        }
                }
            }
        }
        
        void bubble_sort(){
            bool swap = true;
            int n = size-1, aux;
            
            for (int i = 0; i < size; i++){
                if (swap == false){
                    break;
                }
                swap = false;
                for (int j = 0; j < n; j++){
                    if (v[j] > v[j+1]){
                        aux = v[j];
                        v[j] = v[j+1];
                        v[j+1] = aux;
                        swap = true;
                        }
                }
                n--;
            }
        }
        
        void max_heap(int n, int i){ // n tamaño, i elem a evaluar
            int temp, largest = i, der = 2*(i+1), izq = 2*(i+1)-1;
            
            if(izq < n && v[izq] > v[largest]){
                largest = izq;
            }
            if (der < n && v[der] > v[largest]){
                largest = der;
            }
            if (largest != i){
                temp = v[largest];
                v[largest] = v[i];
                v[i] = temp;
                max_heap(n, largest);
            }
        }
        
        void heap_sort(){
            int n = size, max_father = (n/2)-1, temp;
            
            for (int i = max_father; i>=0; i--){
                max_heap(n,i);
            }
            
            for (int i=1; i<n;i++){
                temp = v[0];
                v[0] = v[n-i];
                v[n-i] = temp;
                max_heap(n-i,0);
            }
        }
        
        void merge(int s, int e){
            int mid = (s+e)/2, len1 = mid-s+1, len2 = e-mid, mainind = s;
            int *first = new int[len1], *second = new int[len2];
            
            for (int i=0; i<len1; i++){
                first[i] = v[mainind++];
            }
            mainind = mid+1;
            for (int i=0; i<len2; i++){
                second[i] = v[mainind++];
            }
            
            int index1 = 0, index2 = 0;
            mainind = s;
            
            while(index1 < len1 && index2 < len2){
                if(first[index1] < second[index2]){
                    v[mainind++] = first[index1++];
                }else{
                    v[mainind++] = second[index2++];
                }
            }
            while (index1 < len1){
                v[mainind++] = first[index1++];
            }
            while (index1 < len1){
                v[mainind++] = second[index2++];
            }
            delete[]first;
            delete[]second;
        }
        
        
        void priv_merge_sort(int s, int e){
            if (s>= e){
                return;
            }
            int mid = (s+e)/2;
            priv_merge_sort(s,mid);
            priv_merge_sort(mid+1,e);
            merge(s,e);
        }
        
        void merge_sort(){
            priv_merge_sort(0,size);
        }
        
        int sec_search(int n){
                int x = 0;
                 while(v[x] != n){
                    x++;
                 }return x;
        }
        
        int binary_search(int n){
            int inf = 0, sup = size, mid;
                while(inf <= sup){
                       mid = (inf+sup)/2;
                       if (v[mid] == n){
                           break;
                       }if(v[mid] > n) {
                           sup = mid;
                       }if(v[mid] < n){
                           inf = mid;
                       }
                }
            return mid;
        }
            
        
};

int main()
{
    //Crear y llenar vector V
    Vector<int> v = Vector<int>();
    int size = 40;
    for(int i = 0; i<size; i++){
        v.add(rand()%size);
    }
    
    
    v.print();
    v.merge_sort();
    v.print();
    cout<<"39 está en la posición (sec search): "<<v.sec_search(39)<<endl;
    cout<<"39 está en la posición (binary search): "<<v.binary_search(39)<<endl;
    cout<<"La capacidad es: "<<v.get_capacidad()<<endl;
    
  return 0;
}
