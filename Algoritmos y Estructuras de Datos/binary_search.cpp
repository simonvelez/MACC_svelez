//Búsqueda binaria
#include<iostream>

using namespace std;

int main()
{
    int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
    bool found = false;
    int x=0, inf = 0, sup = 15, mid, busc;
    
    while (x < 15){
        cout<<arr[x]<<" ";
        x++;
    }
    cout<<endl<<"Seleccione un número del arreglo para buscar: "<<endl;
    cin>>busc;
   
    while(inf <= sup){
       mid = (inf+sup)/2;
       if (arr[mid] == busc){
           break;
       }if(arr[mid] > busc) {
           sup = mid;
       }if(arr[mid] < busc){
           inf = mid;
       }
    }
    cout<<"El número está en la posición "<<mid<<endl;
    return 0;
}
