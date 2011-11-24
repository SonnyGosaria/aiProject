unit nnga;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math;

type
    TIntegerArray = array of integer;

    { TNeuralNetwork }

    TNeuralNetwork = class
    private
      weights      : array of array of real; //0: input-hidden1, 1: hidden1-hidden2, n: output
      inputNeuron  : integer; //count of input neuron  (automatically +1 for bias)
      hiddenNeuron : TIntegerArray; //count of hidden neuron (automatically +1 for bias)
      outputNeuron : integer; //count of output neuron (automatically +1 for bias)
      neuronCount : array of integer; //would be calculated automatically in makeNeuralNetwork

      //get real index of weights
      function getRealIndex(fromLayer,fromNeuron,toNeuron:integer):integer;
      //get weight between 2 neurons
      function getWeight(fromLayer,fromNeuron,toNeuron:integer):real;
      //set weight between 2 neurons
      procedure setWeight(fromLayer,fromNeuron,toNeuron:integer; value:real);
    protected
      //you can override this function for custom activation function
      function activate(input:real):real;
    public
      //generate random weights as parameter given
      procedure makeNeuralNetwork(inputNeuronValue : integer; hiddenNeuronValue : TIntegerArray; outputNeuronValue:integer);
      //forward to generate output
      procedure calculate_forward(neuralNetwork : TNeuralNetwork; input: array of real; var delta : array of real);
      //the backprop process, use delta from calculate_forward to adjust weight of neuralNetwork
      procedure calculate_backprop(delta : array of real);
    end;


implementation

function TNeuralNetwork.getRealIndex(fromLayer, fromNeuron,
toNeuron: integer): integer;
var
   fromNeuronCount, toNeuronCount : integer;
begin
   fromNeuronCount := length(self.weights[fromLayer]);
   toNeuronCount := length(self.weights[fromLayer+1]);
   getRealIndex := fromNeuron * toNeuronCount + toNeuron;
end;

function TNeuralNetwork.getWeight(fromLayer, fromNeuron,
toNeuron: integer): real;
begin
  getWeight :=
    self.weights[fromLayer,self.getRealIndex(fromLayer,fromNeuron,toNeuron)];
end;

procedure TNeuralNetwork.setWeight(fromLayer, fromNeuron, toNeuron: integer;
value:real);
begin
  self.weights[fromLayer,self.getRealIndex(fromLayer,fromNeuron,toNeuron)]:=
    value;
end;

function TNeuralNetwork.activate(input: real): real;
begin
  //yang penting ada dulu, nanti dibenerin atau bikin class baru terus dioverride :D
 // activate = input;
end;

procedure TNeuralNetwork.makeNeuralNetwork(inputNeuronValue : integer;
hiddenNeuronValue : TIntegerArray; outputNeuronValue:integer);
var
   i, j : integer;
begin
   //NOTE FOR JAVA PROGRAMMER : in java we use 'This', in lazarus or delphi we use 'self' instead
   self.inputNeuron:=inputNeuronValue;
   self.outputNeuron:=outputNeuronValue;
   self.hiddenNeuron:=hiddenNeuronValue;
   setlength(self.weights, 1+length(self.hiddenNeuron));

   //neuron count for each layer
   setlength(self.neuronCount, 2+length(self.hiddenNeuron));
   for i := 0 to length(self.neuronCount)-1 do
   begin
     //Tentukan panjang dari masing-masing weights
     if i = 0 then
        self.neuronCount[i]:=inputNeuronValue
     else if i = length(self.weights)-1 then
        self.neuronCount[i]:=outputNeuronValue
     else
        self.neuronCount[i]:=hiddenNeuronValue[i+1];
   end;

   //weights between each layer
   for i := 0 to length(self.weights) do
   begin
     //the last weights are used for bias
     //that's why we use neuronCount[i]+1
     setlength(self.weights[i],(self.neuronCount[i]+1)*self.neuronCount[i+1]);
     for j := 0 to length(self.weights[i]) do
     begin
       Randomize;
       self.weights[i][j]:=random(3);
     end;
   end;
end;

procedure TNeuralNetwork.calculate_forward(neuralNetwork : TNeuralNetwork;
input: array of real; var delta : array of real);
var
  currentNeuronValue : array of real;
  nextNeuronValue : array of real;
  sumOfInput : real;
  countNeuronOfCurrentLayer : integer;
  countNeuronOfNextLayer : integer;
  i,j,k : integer;
begin
  //please consider this before go any further:
  //layer of weight = layer of neuron - 1
  //weight  : 0,1,2,3
  //neuron  : 0,1,2,3,4

  //for each weights
  for i := 0 to length(self.weights) do
  begin
    countNeuronOfCurrentLayer:=self.neuronCount[i];
    countNeuronOfNextLayer:=self.neuronCount[i+1];

    //set currentNeuronValue
    setlength(currentNeuronValue,countNeuronOfCurrentLayer);
    if(i<>0)then
    begin
      //current = before's next
      for j := 0 to countNeuronOfCurrentLayer-1 do
      begin
        if j = countOfNeuronValue-1 then  //this is bias
          currentNeuronValue[j] := 1
        else
          currentNeuronValue[j] := nextNeuronValue[j];
      end;
    end
    else if(i=0)then
    begin
      //current = input
      for j := 0 to countNeuronOfCurrentLayer-1 do
      begin
        if j<length(input) then //from input
          currentNeuronValue[j] := input[j]
        else if j = countNeuronOfCurrentLayer-1 then  //this is bias
          currentNeuronValue[j] := 1
        else  //in the case of incomplete input
          currentNeuronValue[j] := 0;
      end;
    end;

    //set nextNeuronValue = 0
    setlength(nextNeuronValue,countNeuronOfNextLayer);
    for j := 0 to countNeuronOfNextLayer-1 do
    begin
      nextNeuronValue[j] := 0;
    end;

    //get real nextNeuronValue
    for j := 0 to countNeuronOfNextLayer-1 do
    begin
      sumOfInput := 0;
      for k := 0 to countNeuronOfCurrentLayer-1 do
      begin
        sumOfInput := sumOfInput + (self.activate(currentNeuronValue[k]) * self.getWeight(i,k,j));
      end;
      nextNeuronValue[j]:=sumOfInput;
    end;
  end;
end;

procedure TNeuralNetwork.calculate_backprop(delta : array of real);
begin

end;






 end.




