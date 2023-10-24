/* 
Ejercicio: Gestor de contraseñas con mapas
Simón Vélez
Algoritmos y Estructuras de Datos
Universidad del Rosario, 2023
*/


#include <iostream>
#include <map>
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
    string temp;
    cout<<"¿Agregar un usuario nuevo? (Y: sí, N: no)"<<endl;
    cin>>temp;
    map<string, string> m;
    while (temp == "Y" || temp == "y" || temp == "si"){
        
        string usua = "";
        string contra = "";
        cout<<"Ingrese el nuevo nombre de usuario: "<<endl;
        cin>>usua;
        cout<<"Ingrese la nueva contraseña: "<<endl;
        cin>>contra;
        
        bool may = false, min = false, num = false, punt = false; // Verificar que tenga mayúsculas, minúsculas, números y carácteres especiales
        for (int i=0; i<contra.length(); i++){
            if (isdigit(contra[i])){
                num = true;
            }
            if (isupper(contra[i])){
                may = true;
            }
            if (islower(contra[i])){
                min = true;
            }
            if (not (islower(contra[i]) or isupper(contra[i]) or isdigit(contra[i]))){ //Si no es num, minúscula o mayúscula, es caracter especial
                punt = true;
            }
        }
        if (may and min and num and punt and contra.length() > 3){
            m[usua] = contra;
        }else{
            cout<<"La contraseña debe incluir por lo menos una mayúscula, una mínuscula, un carácter especial, un número y 4 caracteres.";
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
