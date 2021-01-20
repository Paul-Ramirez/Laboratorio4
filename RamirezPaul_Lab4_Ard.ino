/*
 * Laboratorio 4
 * Nombre: Ramirez Paul
 * Fecha: 20/01/2021
 * Algoritmo de Regresión Lineal
 * Aprendizaje de Maquina e Interfaces
 *Instrucciones: Imprimir los puntos del conjunto de entrenamiento 
 *               correspondientes a la regresi´on lineal (pesoestatura) y 
 *               la tendencia lineal o exponencial.
 *               Al ingresar un nuevo valor por comunicaci´on serial al sistema electr´onico, realizar el pron´ostico (en
 *               depedencia de la interfaz si se desea una tendencia lineal o exponencial) y graficarlo en la interfaz
 *               con un color diferente a lo ya visto del conjunto de entrenamiento.
 */
#include <SoftwareSerial.h>

SoftwareSerial serial2(2,3);//rx,tx

//matriz de datos
int matriz[14][2]={
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
int col=0;//moverse en columnas
int fil=0;//moverse en filas
int Ex=0;//sum de x
int Ey=0;//sum de y
long int Exy=0;//sumatoria de xy
long int Ex2=0;//sum de x^2
long int Ex_2=0;//sum de sum de x al cuadrado
int n=14;//tamaño de muestras
float Bo;//ordenada en el origen
float m;//pendiente
String dato;//recibir estatra
int estatura;//convertir dato
float peso;
int m1;//aux

void setup() {
  Serial.begin(9600);
  serial2.begin(9600);
  //creacion del modelo
  for(;fil<n;fil++){
    Ex=Ex+matriz[fil][0];
    Ey=Ey+matriz[fil][1];
    Exy=Exy+(matriz[fil][0]*matriz[fil][1]);
    Ex2=Ex2+pow(matriz[fil][0],2);
  }
  Ex_2=pow(Ex,2);
  Bo=(float(Ex2*Ey)-float(Ex*Exy))/(float(n*Ex2-Ex_2));
  m1=(n*Exy)-(Ex*Ey);//aux de desborde
  m=(float(m1))/(float(n*Ex2-Ex_2));
  Serial.println("El modelo es:");
  Serial.println(String("y= ")+String(Bo)+String("+")+String(m)+String("x"));
  Serial.println("Ingrese su estatura: ");

}

void loop() {
  if(Serial.available()>0){
    dato=Serial.readString();
    estatura=dato.toInt();
    serial2.write(estatura);
    peso=m*estatura+Bo;
    Serial.println(" ");
    Serial.println(String("Su peso es: ")+String(peso)+String("kg"));
    Serial.println("Ingrese su estatura: ");
  }
}
