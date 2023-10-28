/* 
Ejercicio: Gestor de contraseñas con mapas
Simón Vélez
Algoritmos y Estructuras de Datos
Universidad del Rosario, 2023
*/


#include <iostream>
#include <map>
#include <set>
using namespace std;

void print(map<string, string> m){
  map<string, string>::iterator it = m.begin();
  while (it != m.end())
  {
    cout << "Usuario: " << it->first << ", Contraseña: " << it->second << endl;
    ++it;
  }
}

int main()
{
    // Sets con los conjuntos para identificar letras y números
    set<char> numeros;
    set<char> mayus;
    set<char> minus;
    map<string, string> m; //mapa donde se guardan las contraseñas
    
    for (int i = 0; i<10; i++ ){  //Agrega números del 1 al 9 a numeros en char.
        numeros.insert(i + '0');
    }
    string temp_min = "abcdefghijklmnñopqrstuvwxyz";
    for (int i = 0; i<28; i++ ){  //Agrega las letras minúsculas a minus.
        minus.insert(temp_min[i]);
    }
    string temp_may = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
    for (int i = 0; i<28; i++ ){  //Agrega las letrass mayústuclas a mayus.
        mayus.insert(temp_may[i]);
    }
    
    string temp;
    cout<<"¿Agregar un usuario nuevo? (Y: sí, N: no)"<<endl;
    cin>>temp;
    
    while (temp == "Y" || temp == "y" || temp == "si"){
        
        string usua = "";
        string contra = "";
        cout<<"Ingrese el nuevo nombre de usuario: "<<endl;
        cin>>usua;
        cout<<"Ingrese la nueva contraseña: "<<endl;
        cin>>contra;
        
        bool may = false, min = false, num = false, punt = false; // Verificar que tenga mayúsculas, minúsculas, números y carácteres especiales
        for (int i=0; i<contra.length(); i++){
            if (numeros.count(contra[i])){
                num = true;
            }
            if (mayus.count(contra[i])){
                may = true;
            }
            if (minus.count(contra[i])){
                min = true;
            }
            if (not (numeros.count(contra[i]) or mayus.count(contra[i]) or minus.count(contra[i]))){ //Si no es num, minúscula o mayúscula, es caracter especial
                punt = true;
            }
        }
        if (may and min and num and punt and contra.length() > 4){
            m[usua] = contra;
        }else{
            cout<<"La contraseña debe incluir por lo menos una mayúscula, una mínuscula, un carácter especial, un número y 5 caracteres.";
        }
      print(m);
      cout<<endl<<"- - - - - - - - - - - - - - - - - - -"<<endl;
      cout<<"¿Agregar un usuario nuevo? (Y: sí, N: no)"<<endl;
      cin>>temp;
    }
    cout<<"Usuarios y contraseñas finales: "<<endl;
    print(m);
    
    return 0;
}
