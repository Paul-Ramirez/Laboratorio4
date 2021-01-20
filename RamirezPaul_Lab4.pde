/*
*Laboratorio #4
*Aprendizaje de Maquina e Interfaces
*Nombre: Ramirez Paul
*Instrucciones: Imprimir los puntos del conjunto de entrenamiento 
*               correspondientes a la regresi´on lineal (pesoestatura) y 
*               la tendencia lineal o exponencial.
*               Al ingresar un nuevo valor por comunicaci´on serial al sistema electr´onico, realizar el pron´ostico (en
*               depedencia de la interfaz si se desea una tendencia lineal o exponencial) y graficarlo en la interfaz
*               con un color diferente a lo ya visto del conjunto de entrenamiento.
*/


import processing.serial.*;
import ddf.minim.*;
//comunicacion serial
Serial port;

//matriz de datos;
int matriz[][]={
  {170,67},
  {180,80},
  {170,65},
  {178,75},
  {160,55},
  {163,60},
  {165,63},
  {170,70},
  {164,62},
  {176,77},
  {164,60},
  {170,76},
  {170,56},
  {168,60},
};

///variables algoritmo regresion lineal
int col=0;//moverse en columnas
int fil=0;//moverse en filas
float Ex=0;//sum de x
float Ey=0;//sum de y
float Exy=0;//sumatoria de xy
float Ex2=0;//sum de x^2
float Ex_2=0;//sum de sum de x al cuadrado
int n=14;//tamaño de muestras
float Bo;//ordenada en el origen
float m;//pendiente
String dato;//recibir estatura
int estatura;//convertir dato
float peso=0;
float m1;//aux


void setup(){
 size(1300,800); 
 port= new Serial(this, "COM10",9600);//habilitar puerto com10
 
 ////algoritmo regresion lineal
 for(;fil<n;fil++){
    Ex=Ex+matriz[fil][0];
    Ey=Ey+matriz[fil][1];
    Exy=Exy+(matriz[fil][0]*matriz[fil][1]);
    Ex2=Ex2+pow(matriz[fil][0],2);
  }
  Ex_2=pow(Ex,2);
  Bo=((Ex2*Ey)-(Ex*Exy))/((n*Ex2-Ex_2));
  m1=(n*Exy)-(Ex*Ey);//aux de desborde
  m=(m1)/(n*Ex2-Ex_2);
  println("El modelo es:");
  println("y= "+Bo+"+"+(m)+"x");

}
//comunicacion serial con arduino
void serialEvent (Serial port) {
 estatura=port.read();//leer dato del puerto
 println("Estatura: "+estatura);
 peso=m*estatura+Bo;
 println("El peso es: "+peso+" kg");
}

void draw(){
  background(255);
  stroke(#D8D2D2);
  strokeWeight(3);
  line(0,180,1300,180);
  //titulos
  textSize(40);
  fill(#1385A0);
  text("Laboratorio #4 - Ramirez Paul", 340,40);
  text("Regresión Lineal", 475,95);
  textSize(25);
  text("Gráfica PesoXEstatura", 500,150);
  
  //dibujo de cuadricula eje x
  stroke(#D8D2D2);
  strokeWeight(2);
  line(82,700-50,980,700-50);
  line(80,700-100,980,700-100);
  line(80,700-50*3,980,700-50*3);
  line(80,700-50*4,980,700-50*4);
  line(80,700-50*5,980,700-50*5);
  line(80,700-50*6,980,700-50*6);
  line(80,700-50*7,980,700-50*7);
  line(80,700-50*8,980,700-50*8);
  line(80,700-50*9,980,700-50*9);
  line(80,700-50*10,980,700-50*10);
  
  //dibujo de cuadricula eje y
  stroke(#D8D2D2);
  strokeWeight(2);
  line(80+150,200,80+150,700);
  line(80+150*2,200,80+150*2,700);
  line(80+150*3,200,80+150*3,700);
  line(80+150*4,200,80+150*4,700);
  line(80+150*5,200,80+150*5,700);
  line(80+150*6,200,80+150*6,700);
  
  //titulo ejes
  textSize(20);
  fill(#F5169C);
  text("P\nE\nS\nO\nk\ng\n",10,400);
  text("E S T A T U R A cm",450,790);
  
  //linea de tendencia
  stroke(2);
  stroke(#52F063);
  line(155*30-4570,700-49.4635*5,185*30-4570,700-84.8545*5);
  
  //lineas del eje
  stroke(0);
  strokeWeight(3);
  line(80,200,80,700);
  line(80,700,980,700);
  
  //valores del eje y
  textSize(20);
  fill(0);
  text("10",40,700-50);
  text("20",40,700-50*2);
  text("30",40,700-50*3);
  text("40",40,700-50*4);
  text("50",40,700-50*5);
  text("60",40,700-50*6);
  text("70",40,700-50*7);
  text("80",40,700-50*8);
  text("90",40,700-50*9);
  
  ///texto eje x
  textSize(20);
  text("155",60,750);
  text("160",60+150,750);
  text("165",60+150*2,750);
  text("170",60+150*3,750);
  text("175",60+150*4,750);
  text("180",60+150*5,750);
  text("185",60+150*6,750);
  //text("190",60+150*7,750);
  
  //graficacion de puntos
  //ellipse(pos,pos,tam,tam);
  fill(0,0,255);
  stroke(#D8D2D2);
  ellipse((168*30)-4570,700-60*5,10,10); 
  ellipse((170*30)-4570,700-56*5,10,10); 
  ellipse((170*30)-4570,700-76*5,10,10); 
  ellipse((164*30)-4570,700-60*5,10,10); 
  ellipse((176*30)-4570,700-77*5,10,10); 
  ellipse((164*30)-4570,700-62*5,10,10);
  ellipse((170*30)-4570,700-70*5,10,10); 
  ellipse((165*30)-4570,700-63*5,10,10); 
  ellipse((163*30)-4570,700-60*5,10,10); 
  ellipse((160*30)-4570,700-55*5,10,10); 
  ellipse((178*30)-4570,700-75*5,10,10); 
  ellipse((170*30)-4570,700-65*5,10,10); 
  ellipse((180*30)-4570,700-80*5,10,10); 
  ellipse((170*30)-4570,700-67*5,10,10); 
  
  ///obtencion del peso estimado
  
  fill(255,0,0);
  noStroke();
  ellipse((estatura*30)-4570,700-peso*5,10,10);//graficar dato recibido
  
  //impresion en interfaz
  textSize(19);
  fill(#023946);
  text("El modelo es:",1000,350);
  text("y = "+m+"x"+" "+Bo,1000,390);
  text("Estatura Ingresada: "+estatura+" cm",1000,450);
  text("Peso Estimado: "+peso+" kg",1000,500);
  
 
}
