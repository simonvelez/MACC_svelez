
// Ordenamiento secuencial

#include<iostream>
#include <algorithm>

using namespace std;

int main()
{
    int n = 20, x = 0, aux;
    int ar[n] = {20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1};
    
    while (x < n){
        cout<<ar[x]<<" ";
        x++;
    }cout<<endl;
   
    for (int i = 0; i < n; i++){
        for (int j = 0; j < n; j++){
            if (ar[i] < ar[j]){
                aux = ar[i];
                ar[i] = ar[j];
                ar[j] = aux;
            }
        }
    }
    
    x = 0;
    while (x < n){
        cout<<ar[x]<<" ";
        x++;
    }
    
    return 0;
}
