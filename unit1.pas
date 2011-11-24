unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids;
//  nnga;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Memo1: TMemo;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
  procedure Edit2Exit(Sender: TObject);
  procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: char);



  private
    { private declarations }
  public
    { public declarations }

  end; 

var
  Form1: TForm1; 
  Input_Neuron : Integer ;
  Output_Neuron : Integer;
  Hidden_Neuron : Array of Integer;
  ArrayCount : Integer= 0;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.Button2Click(Sender: TObject);
begin
  if Edit2.text <> '' then
  begin
     StringGrid1.Enabled := true;
      StringGrid1.RowCount :=StrToInt (Edit2.text);
  end;

end;
procedure Cek_Edit(Var EdBox : TEdit);
Var
  R : Real;
  Code : Integer;
Begin
    { Get text from TEdit control }
    Val(EdBox.Text, R, Code);
    { Val - Converts a string to a numeric representation. }

    { Error during conversion to Real? }
    If Code<>0 Then
    Begin
        R:=0;
        MessageDlg('Please check your input details ?', mtError, [mbOk], 0);
       // EdBox.Text := '0';
        { Get focus back to edit box }
        EdBox.SetFocus;
    End
End;

procedure TForm1.Button1Click(Sender: TObject);
var
   x: integer;
   y: Boolean;
    a:ansistring;
begin
     y:= false   ;
    // x:= ;
        for  x:=0 to  StrToInt(Edit2.text)-1 do
        begin
          a:= (StringGrid1.Cells[0,x]);
          if a='' then   y:=true
        end;

        if y=true then
        begin
             MessageDlg('Please check your input details ?', mtError, [mbOk], 0) ;
             StringGrid1.SetFocus;
        end
        else
            MessageDlg('Success', mtError, [mbOk], 0);
end;
procedure TForm1.Edit1Exit(Sender: TObject);
begin
  Cek_Edit(Edit1);
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #27, #8]) then
    Key := #0;
end;

procedure TForm1.Edit2Exit(Sender: TObject);
begin
  Cek_Edit(Edit2);
  Button2.enabled=true;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #27, #8]) then
    Key := #0;
end;


procedure TForm1.Edit3Exit(Sender: TObject);
begin
  Cek_Edit(Edit3);
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9', #27, #8]) then
    Key := #0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.StringGrid1Click(Sender: TObject);
begin
     if Edit2.text <> '' then
  begin
     StringGrid1.Enabled := true;
      StringGrid1.RowCount :=StrToInt (Edit2.text);
  end;
end;

procedure TForm1.StringGrid1KeyPress(Sender: TObject; var Key: char);
begin
  // #0: no key pressed
// #8: backspace
// #9: tab
// #13: enter
// #27: delete
begin
  if not (Key in ['0'..'9', #27, #8]) then
    Key := #0;
end;

end;

end.

