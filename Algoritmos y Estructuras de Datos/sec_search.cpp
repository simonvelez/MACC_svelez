
//Búsqueda secuencial

#include<iostream>
#include<array>

using namespace std;

int main()
{
    int arr[10] = {1,51,54,15,678,37,18,67,87,948};
    bool found = false;
    int busc;
     int x = 0;
    
    while (x < 10){
        cout<<arr[x]<<" ";
        x++;
    }
    cout<<endl;
    x = 0;
    cout<<"Seleccione un número del arreglo para buscar: "<<endl;
    cin>>busc;
   
    while(arr[x] != busc){
        x++;
    }
    cout<<"El número está en la posición "<<x<<endl;
    
    return 0;
}
