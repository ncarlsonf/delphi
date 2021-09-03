unit uRotacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TfrmRotacao = class(TForm)
    ed1: TEdit;
    ed2: TEdit;
    ed3: TEdit;
    btnCodificar: TButton;
    btnDecodificar: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    seDeslocamento: TSpinEdit;
    cbDirecao: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edByte: TEdit;
    edBin: TEdit;
    btnByteToBin: TButton;
    btnBinToByte: TButton;
    Label7: TLabel;
    Label8: TLabel;
    procedure btnCodificarClick(Sender: TObject);
    procedure btnDecodificarClick(Sender: TObject);
    procedure btnByteToBinClick(Sender: TObject);
    procedure btnBinToByteClick(Sender: TObject);
    procedure edByteKeyPress(Sender: TObject; var Key: Char);
    procedure edByteExit(Sender: TObject);
    procedure edBinKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRotacao: TfrmRotacao;
  textoCodificado: AnsiString;

implementation

{$R *.dfm}

uses
    Math;


// Convertendo um byte para número binário representado por uma string
function ByteToBin(b: Byte): AnsiString;
var
    b1, b2, b3, b4, b5, b6, b7, b8: Byte;
begin
    b1 := b and 1;   // 00000001
    b2 := (b and 2) shr 1;   // 00000010
    b3 := (b and 4) shr 2;   // 00000100
    b4 := (b and 8) shr 3;   // 00001000
    b5 := (b and 16) shr 4;  // 00010000
    b6 := (b and 32) shr 5;  // 00100000
    b7 := (b and 64) shr 6;  // 01000000
    b8 := (b and 128) shr 7; // 10000000

    Result :=
        IntToStr(b8)
        +IntToStr(b7)
        +IntToStr(b6)
        +IntToStr(b5)
        +IntToStr(b4)
        +IntToStr(b3)
        +IntToStr(b2)
        +IntToStr(b1);
end;

// convertendo um número binário representado por uma string para um byte
function BinToByte(b: AnsiString): Byte;
var
    i: Integer;
begin
    Result := 0;
    b := Trim(b);
    while Length(b) < 8 do
        b := '0' + b;
    b := Copy(b, 1, 8);
    for i := Length(b) downto 1 do
    begin
        if (Copy(b, i, 1) = '1') then
        begin
            Result := Result + Trunc(Power(2, (8 - i)));
        end;
    end;
end;


// obter o valor em byte/decimal a partir de um número binário representado por uma string passada em edBin
procedure TfrmRotacao.btnBinToByteClick(Sender: TObject);
begin
    if Trim(edBin.Text) <> '' then
    begin
        edByte.Text := IntToStr(BinToByte(edBin.Text));
    end;
end;

// obter um número binário representado por uma string a partir de um byte passado em edByte
procedure TfrmRotacao.btnByteToBinClick(Sender: TObject);
begin
    if (Trim(edByte.Text) <> '')
        and(StrToInt(edByte.Text) >= 0)
        and (StrToInt(edByte.Text) <= 255) then
    begin
        edBin.Text := ByteToBin(StrToInt(edByte.Text));
    end;
end;

// codificando
procedure TfrmRotacao.btnCodificarClick(Sender: TObject);
var
    str, strRes: AnsiString;
    i: Integer;
    b, deslocamento: Byte;
begin
    {
    shr: shift right (deslocar para a direita)
    shl: shift left (deslocar para a esquerda)

    Ex.:
      O byte 127d (127 decimal) em bits é representado por 0111111b (01111111 binário).
      Sendo assim, caso eu desloque para a direita em 3 bits o byte 127d, ou 01111111b
      o seu novo valor será 00001111b, ou 15d.

    Então 127d shr 3 (ou 01111111b shr 3)
    01111111b >> 1: 00111111 >> 2: 00011111 >> 3: 00001111
    Resulta portanto em 15d (ou 00001111b)
    }
    deslocamento := seDeslocamento.Value;
    str := AnsiString(ed1.Text);
    strRes := '';
    for i := 1 to Length(str) do
    begin
        b := Ord(Copy(str, i, 1)[1]);
        if cbDirecao.ItemIndex = 1 then
            b := (b shr deslocamento) + (b shl (8 - deslocamento))
        else
            b := (b shl deslocamento) + (b shr (8 - deslocamento));
        b := b and Byte(255);
        strRes := strRes + AnsiChar(b);
    end;
    textoCodificado := strRes;
    ed2.Text := strRes;
end;

procedure TfrmRotacao.btnDecodificarClick(Sender: TObject);
var
    str, strRes: AnsiString;
    i: Integer;
    b, deslocamento: Byte;
begin
    deslocamento := seDeslocamento.Value;
    str := AnsiString(ed2.Text);
    strRes := '';
    for i := 1 to Length(str) do
    begin
        b := Ord(Copy(str, i, 1)[1]);
        // aqui inverte o sentido, desloca direita vs esquerda o contrário da codificação
        if cbDirecao.ItemIndex = 1 then
            b := (b shl deslocamento) + (b shr (8 - deslocamento))
        else
            b := (b shr deslocamento) + (b shl (8 - deslocamento));
        b := b and Byte(255);
        strRes := strRes + AnsiChar(b);
    end;
    textoCodificado := strRes;
    ed3.Text := strRes;
end;

procedure TfrmRotacao.edBinKeyPress(Sender: TObject; var Key: Char);
begin
    if not(Key in ['0'..'1']) then
        Key := #0;
end;

procedure TfrmRotacao.edByteExit(Sender: TObject);
begin
    edByte.Text := Trim(edByte.Text);
    if edByte.Text <> '' then
    begin
        try
            if StrToInt(edByte.Text) > 255 then
            begin
                ShowMessage('O valor de um byte pode ser de 0 a 255');
                edByte.SetFocus();
            end;
        except
            edByte.SetFocus();
        end;
    end;
end;

procedure TfrmRotacao.edByteKeyPress(Sender: TObject; var Key: Char);
begin
    if not(Key in ['0'..'9']) then
        Key := #0;
end;

end.
