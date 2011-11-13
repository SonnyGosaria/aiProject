unit Unit2; 

{$mode objfpc}{$H+}

interface

type
    //TODO : consider to use class
    TNeuralNetwork = record
      wights      : array[0..2] of array of real; //0: input, 1: hidden, 2: output
      inputLayer  : integer; //count of input layer
      hiddenLayer : integer; //count of hidden layer
      outputLayer : integer; //count of output layer
    end;

//generate random weights as parameter given
function makeNeuralNetwork(inputLayer, hiddenLayer, outputLayer) : TNeuralNetwork;
//forward to generate output
function forward(neuralNetwork : TNeuralNetwork; input: array of real) : array of real;
//the backprop process, use forward to generate output, find delta by compare it with desiredOutput
//do calculation to adjust weight of neuralNetwork
procedure backprop(var neuralNetwork : TNeuralNetwork; desiredOutput : array of real);

uses
  Classes, SysUtils, Math;

implementation

end.

