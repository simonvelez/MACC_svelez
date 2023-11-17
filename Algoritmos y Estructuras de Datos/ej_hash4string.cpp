/* 
Ejercicio: Función hash para strings
Simón Vélez
Algoritmos y Estructuras de Datos
Universidad del Rosario, 2023
*/

#include <iostream>
#include <list>
#include<array> 
using namespace std;

class HashMapTable {
    // size of the hash table
    int table_size;
    // Pointer to an array containing the keys
    list < string >* table;

    public:
    // creating constructor of the above class containing all the methods
    HashMapTable (int ts) {
      this->table_size = ts;
      table = new list < string >[table_size];
    }
 
    // hash function to compute the index using table_size and key
    int hashFunction (string key){
        int resultado = 0;
        for (int i = 0; i < key.length(); i++){
            resultado = resultado*i + key[i];
        }
        return resultado % table_size;
    }
    // insert function to push the keys in hash table
    void insertElement (string key) {
        int index = hashFunction (key);
        while (not(table[index].empty())){
            if (index < table_size+1){
                index++;
            }else{
                index = 0;
            }
        }
        table[index].push_back(key);
        
    }
 
    // delete function to delete the element from the hash table
    void deleteElement (string key) {
        int index = hashFunction (key);
        // finding the key at the computed index
        list < string >::iterator i;
        for (i = table[index].begin (); i != table[index].end (); i++){
            if (*i == key)
                break;
        }
        // removing the key from hash table if found
        if (i != table[index].end ())
            table[index].erase (i);
    }


    // display function to showcase the whole hash table
    void displayHashTable (){
    for (int i = 0; i < table_size; i++){
        cout << i;
        // traversing at the recent/ current index
        for (auto j:table[i])
            cout << " ==> " << j;
        cout << endl;
        }
    }

};

int main () {
 
    // array of all the keys to be inserted in hash table
    string arr[20] = {"Mario", "oiraM", "Ava", "Caleb", "Sophia", "Mason", "Harper", "Aiden", "Isabella", "Lucas", "Mia", "Jackson", "Emma", "Liam", "Addison", "Noah", "Grace", "Owen", "Lily", "Wyatt"};
    int n = 20;
 
    // table_size of hash table as 6
    HashMapTable ht (n);
     
    for (int i = 0; i < n; i++)
        ht.insertElement (arr[i]);
   
   cout <<n<<"\n";
   // displaying the final data of hash table
    cout <<"------------------------------\n";
    ht.displayHashTable ();
 
    return 0;
}
