// Online C++ Compiler - Build, Compile and Run your C++ programs online in your favorite browser

#include<iostream>
#include <math.h>
#include <stdlib.h>

using namespace std;
class Punto{
private:    
    int x;
    int y;
    int d;
public:
    Punto(){
        x=0;
        y=0;
        d=0;
    }
    
    Punto(int y1, int x1, int d1){
        x=x1;
        y=y1;
        d=d1;
    }
    
    int get_x(){
        return x;
    }
    
    int get_y(){
        return y;
    }
    
    void giro_der(){
        d =  (4+d+1)%4;
    }
    
    void giro_izq(){
        d =  (4+d-1)%4;
    }
    
    Punto avanzar(){
        int x = get_x();
        int y = get_y();
        switch(d){
            case 0: //Norte
                y = y-1;
            break;
            
            case 2: //Sur
                y = y+1;
            break;
            
            case 1: //Este
                x = x+1;
            break;
            
            case 3: //Oeste
                x = x-1;
            break;
        }
        return Punto(y,x,d);
    }
    
    bool comparar(Punto p){
        return (x == p.get_x() && y == p.get_y());
    }
    
    string to_string(){
        return "("+std::to_string(y)+","+std::to_string(x)+")";
    }
    
    Punto& operator=(const Punto& f) { 
		x = f.x;
		y = f.y;
		d = f.d;
		return *this;
	}
    
    void print(){
        cout<<to_string();
    }
    
    friend std::ostream& operator<<(std::ostream& os, Punto& b) {
		return os << b.to_string();
	}
	
	friend std::ostream& operator<<(std::ostream& os, Punto* b) {
		return os << b->to_string();
	}
    
};

void print_mat(int** m, int  f, int c){
    for (int i = 0; i < f; i++) {
        for(int j=0; j<c ; j++){
            cout << m[i][j] << "\t";
        }
        cout << endl;
    }
    cout << endl;
}

bool laberinto(int** m, Punto p, Punto salida){
    int n;
    n = 2;
    while (not p.comparar(salida)){
        m[p.get_x()][p.get_y()] = 7;
        m[salida.get_x()][salida.get_y()] = 9;
        
        p.avanzar();
        
        print_mat(m,6,6);
        n = n-1;
        if (n == 0){
            return p.comparar(salida);
            }
    }
    return p.comparar(salida);
    }
int main()
{
    int m1[6][6] = {{0,0,0,0,0,0},{0,0,1,1,0,0},{1,1,1,0,0,0},{0,0,1,0,1,1},{0,1,1,1,1,0},{0,0,0,0,0,0}};
    
    int** m = new int*[6];
    
    for(int i=0; i<6; i++){
        m[i] = new int[6];
        for(int j=0; j<6; j++){
            m[i][j] = m1[i][j];
        }
    }
    
    
    
    laberinto(m, Punto(rand()%6,rand()%6,1), Punto(rand()%6,rand()%6,1));
    print_mat(m,6,6);
    
    
    return 0;
}