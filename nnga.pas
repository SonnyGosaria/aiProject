unit Unit2; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math;

type
    //TODO : consider to use class
    TNeuralNetwork = class
    private
      weights      : array of array of real; //0: input-hidden1, 1: hidden1-hidden2, n: output
      inputNeuron  : integer; //count of input neuron
      hiddenNeuron : array of integer; //count of hidden neuron
      outputNeuron : integer; //count of output neuron

    public
      //generate random weights as parameter given
      procedure makeNeuralNetwork(inputNeuron : integer; hiddenNeuron : array of integer; outputNeuron:integer);
      //forward to generate output
      procedure calculate_forward(neuralNetwork : TNeuralNetwork; input: array of real; var delta : array of real);
      //the backprop process, use forward to generate output, find delta by compare it with desiredOutput
      //do calculation to adjust weight of neuralNetwork
      procedure calculate_backprop(var neuralNetwork : TNeuralNetwork; desiredOutput : array of real);
    end;


implementation

procedure TNeuralNetwork.makeNeuralNetwork(inputNeuron : integer; hiddenNeuron : array of integer; outputNeuron:integer);
var
   i, j : integer;
   neuronCount : array of integer;
begin
   //NOTE FOR JAVA PROGRAMMER : in java we use 'This', in lazarus or delphi we use 'self' instead
   self.inputNeuron:=inputNeuron;
   self.outputNeuron:=outputNeuron;
   self.hiddenNeuron:=hiddenNeuron;
   setlength(self.weights, 1+length(self.hiddenNeuron));

   //neuron count for each layer
   setlength(neuronCount, 2+length(self.hiddenNeuron));
   for i := 0 to length(neuronCount-1) do
   begin
     //Tentukan panjang dari masing-masing weights
     if i = 0 then
        neuronCount[i]:=inputNeuron
     else if i = length(self.weights)-1 do
        neuronCount[i]:=outputNeuron
     else
        neuronCount[i]:=hiddenNeuron[i+1];
   end;

   //weights between each layer
   for i := 0 to length(self.weights) do
   begin
     setlength(self.weights[i],neuronCount[i]*neuronCount[i+1]);
     for j := 0 to length(self.weights[i]) do
     begin
       Math.Randomize;
       self.weights[i][j]:=Math.Random;
     end;
   end;
end;

procedure TNeuralNetwork.calculate_forward(neuralNetwork : TNeuralNetwork; input: array of real; var delta : array of real);
begin

end;

procedure TNeuralNetwork.calculate_backprop(var neuralNetwork : TNeuralNetwork; desiredOutput : array of real);
begin

end;

end.

