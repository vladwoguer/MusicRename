unit UnitCalculadora;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmCalculadora = class(TForm)
    edResultado: TEdit;
    bt7: TButton;
    bt8: TButton;
    bt9: TButton;
    btSoma: TButton;
    bt4: TButton;
    bt5: TButton;
    bt6: TButton;
    btSubtrair: TButton;
    bt1: TButton;
    bt2: TButton;
    bt3: TButton;
    btMultiplicar: TButton;
    btLimpar: TButton;
    bt0: TButton;
    btIgual: TButton;
    btDividir: TButton;


    procedure clickOperador(Sender: TObject);
    procedure NumeroClick(Sender: TObject);
    procedure btIgualClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
  private
    { Private declarations }
      FOperacao : char;
      FTotal: Double;
      FOperando1: Double;
      FOperando2: Double;
      FUltimoFoiIgual: boolean;
      FUltimoFoiSinal : boolean;
      function Calcular(Operando1 : Double; Operando2 : Double; Operacao : char ): Double;
      procedure Limpar;
      procedure BloquearSinais;
      procedure DesbloquearSinais;


  public
    { Public declarations }
  end;

var
  frmCalculadora: TfrmCalculadora;

implementation

{$R *.dfm}
procedure TfrmCalculadora.clickOperador(Sender: TObject);
begin
    FOperacao := TButton(Sender).Caption[1];
    FOperando1 := StrToFloat(edResultado.Text);
    FUltimoFoiSinal := true;
    BloquearSinais;
end;

procedure TfrmCalculadora.FormCreate(Sender: TObject);
begin
    FOperando1 := 0;
    FOperando2 := 0;
end;

procedure TfrmCalculadora.NumeroClick(Sender: TObject);
begin
    if FUltimoFoiIgual or FUltimoFoiSinal then
      begin
        edResultado.Text := TButton(Sender).Caption;
        FUltimoFoiIgual := false;
        FUltimoFoiSinal := false;
      end
    else
    begin
        if edResultado.Text = '0' then
            edResultado.Text := TButton(Sender).Caption
        else
            edResultado.Text := edResultado.Text + TButton(Sender).Caption;
    end;
end;

procedure TfrmCalculadora.btIgualClick(Sender: TObject);
begin
    DesbloquearSinais;
    FOperando2 := StrToFloat(edResultado.Text);
    FUltimoFoiIgual := true;
    edResultado.Text := FloatToStr(Calcular(FOperando1, FOperando2, FOperacao ));
end;

procedure TfrmCalculadora.btLimparClick(Sender: TObject);
begin
    Limpar;
end;

function TfrmCalculadora.Calcular(Operando1 : Double; Operando2 : Double; Operacao : char ): Double;
begin
    case Operacao of
      '+': Calcular := Operando1 + Operando2;
      '-': Calcular := Operando1 - Operando2;
      'x': Calcular := Operando1 * Operando2;
      '/': Calcular := Operando1 / Operando2;
    end;
end;
procedure TfrmCalculadora.Limpar;
begin
    FOperando1 := 0;
    FOperando2 := 0;
    FOperacao := '+';
    edResultado.Text := '0';

end;

 procedure TfrmCalculadora.BloquearSinais;
 begin
     btSoma.Enabled := false;
     btSubtrair.Enabled := false;
     btMultiplicar.Enabled := false;
     btDividir.Enabled := false;

 end;

 procedure TfrmCalculadora.DesbloquearSinais;
 begin
     btSoma.Enabled := true;
     btSubtrair.Enabled := true;
     btMultiplicar.Enabled := true;
     btDividir.Enabled := true;

 end;

end.