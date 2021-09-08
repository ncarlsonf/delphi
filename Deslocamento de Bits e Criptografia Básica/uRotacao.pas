unit uRotacao;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.StdCtrls, Vcl.Samples.Spin;

type
    TDirecao = (Esquerda, Direita);

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
        lbBits: TLabel;
        lbDeslocando: TLabel;
        lbColocando: TLabel;
        edByte: TEdit;
        edBin: TEdit;
        btnByteToBin: TButton;
        btnBinToByte: TButton;
        Label7: TLabel;
        Label8: TLabel;
        btnInvert: TButton;
        btnRevert: TButton;
        btnFlip: TButton;
        edByte2: TEdit;
        edBin2: TEdit;
        Button1: TButton;
        Button2: TButton;
        seMascara: TSpinEdit;
        Label9: TLabel;
        edWithMask: TEdit;
        Label10: TLabel;
        Label11: TLabel;
        edKey: TEdit;
        procedure btnCodificarClick(Sender: TObject);
        procedure btnDecodificarClick(Sender: TObject);
        procedure btnByteToBinClick(Sender: TObject);
        procedure btnBinToByteClick(Sender: TObject);
        procedure edByteKeyPress(Sender: TObject; var Key: Char);
        procedure edByteExit(Sender: TObject);
        procedure edBinKeyPress(Sender: TObject; var Key: Char);
        procedure btnInvertClick(Sender: TObject);
        procedure btnRevertClick(Sender: TObject);
        procedure btnFlipClick(Sender: TObject);
        procedure edWithMaskKeyPress(Sender: TObject; var Key: Char);
        procedure edWithMaskExit(Sender: TObject);
        procedure Button1Click(Sender: TObject);
        procedure Button2Click(Sender: TObject);
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
    // bits
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

    Result := IntToStr(b8) + IntToStr(b7) + IntToStr(b6) + IntToStr(b5) + IntToStr(b4) + IntToStr(b3) + IntToStr(b2) + IntToStr(b1);
end;

// Ex.: 00010101 (21d) => 10101000 (168d)
function ByteRevert(b: Byte): Byte;
var
    // bits
    b1, b2, b3, b4, b5, b6, b7, b8: Byte;
begin
    b1 := b and 1 shl 7;   // 00000001
    b2 := (b and 2) shl 5;   // 00000010
    b3 := (b and 4) shl 3;   // 00000100
    b4 := (b and 8) shl 1;   // 00001000
    b5 := (b and 16) shr 1;  // 00010000
    b6 := (b and 32) shr 3;  // 00100000
    b7 := (b and 64) shr 5;  // 01000000
    b8 := (b and 128) shr 7; // 10000000

    Result := b1 + b2 + b3 + b4 + b5 + b6 + b7 + b8;
end;

// Ex.: 00010101 (21d) => 11101010 (234d)
function ByteInvert(b: Byte): Byte;
var
    // bits
    b1, b2, b3, b4, b5, b6, b7, b8: Byte;
begin
    b1 := (b and 1);   // 00000001
    b2 := ((b and 2) shr 1);   // 00000010
    b3 := ((b and 4) shr 2);   // 00000100
    b4 := ((b and 8) shr 3);   // 00001000
    b5 := ((b and 16) shr 4);  // 00010000
    b6 := ((b and 32) shr 5);  // 00100000
    b7 := ((b and 64) shr 6);  // 01000000
    b8 := ((b and 128) shr 7); // 10000000

    if b1 = 0 then
        b1 := 1
    else
        b1 := 0;
    if b2 = 0 then
        b2 := 2
    else
        b2 := 0;
    if b3 = 0 then
        b3 := 4
    else
        b3 := 0;
    if b4 = 0 then
        b4 := 8
    else
        b4 := 0;
    if b5 = 0 then
        b5 := 16
    else
        b5 := 0;
    if b6 = 0 then
        b6 := 32
    else
        b6 := 0;
    if b7 = 0 then
        b7 := 64
    else
        b7 := 0;
    if b8 = 0 then
        b8 := 128
    else
        b8 := 0;

    Result := b1 + b2 + b3 + b4 + b5 + b6 + b7 + b8;
    {
    Poderia ser:

        Result := not b;

    Mas a idéia aqui neste exemplo é ver o que acontece com cada bit em separado.
    }
end;

// Ex.: 01100101 (101d) => 01010110 (86d)
function ByteFlip(b: Byte): Byte;
var
    b1, b2, b3, b4, b5, b6, b7, b8: Byte;
begin
    b1 := b and 1 shl 4;   // 00000001
    b2 := (b and 2) shl 4;   // 00000010
    b3 := (b and 4) shl 4;   // 00000100
    b4 := (b and 8) shl 4;   // 00001000
    b5 := (b and 16) shr 4;  // 00010000
    b6 := (b and 32) shr 4;  // 00100000
    b7 := (b and 64) shr 4;  // 01000000
    b8 := (b and 128) shr 4; // 10000000

    Result := b1 + b2 + b3 + b4 + b5 + b6 + b7 + b8;
    {
    Poderia também ser:

        Result := (b shl 4) + (b shr 4);

    Mas a idéia aqui neste exemplo é ver o que acontece com cada bit em separado.
    }
end;

// direção: 0 esquerda, 1 direita; deslocamento: número de bits a se deslocar
function ByteRotate(b: Byte; direcao: TDirecao; deslocamento: Integer): Byte;
var
    str, strRes: AnsiString;
    i: Integer;
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
    if deslocamento < 1 then
        deslocamento := 1;
    if deslocamento > 7 then
        deslocamento := 7;

    if direcao = Esquerda then
        Result := (b shl deslocamento) + (b shr (8 - deslocamento))
    else
        Result := (b shr deslocamento) + (b shl (8 - deslocamento));
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
    if (Trim(edByte.Text) <> '') and (StrToInt(edByte.Text) >= 0) and (StrToInt(edByte.Text) <= 255) then
    begin
        edBin.Text := ByteToBin(StrToInt(edByte.Text));
    end;
end;

// codificando
procedure TfrmRotacao.btnCodificarClick(Sender: TObject);
var
    str, strRes: AnsiString;
    i, bits: Integer;
    b, deslocamento: Byte;
    key: AnsiString;
    direcao: TDirecao;
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
    key := Trim(AnsiString(edKey.Text));
    deslocamento := seDeslocamento.Value;
    str := AnsiString(ed1.Text);
    strRes := '';
    for i := 1 to Length(str) do
    begin
        b := Ord(Copy(str, i, 1)[1]);
        b := b xor Byte(i);
        b := b xor Length(key);
        if key <> '' then
        begin
            b := b xor Ord(key[((i - 1) mod Length(key)) + 1]);
            bits := (Ord(key[((i - 1) mod Length(key)) + 1]) mod 7) + 1;
            b := ByteRotate(b, Esquerda, bits);
        end;
        if cbDirecao.ItemIndex = 0 then
            direcao := Direita
        else
            direcao := Esquerda;
        b := ByteRotate(b, direcao, seDeslocamento.Value);
        b := ByteInvert(b);
        b := ByteRevert(b);
        b := ByteFlip(b);
        b := b and Byte(255);
        strRes := strRes + AnsiChar(b);
    end;
    textoCodificado := strRes;
    ed2.Text := strRes;
end;

procedure TfrmRotacao.btnDecodificarClick(Sender: TObject);
var
    str, strRes: AnsiString;
    i, bits: Integer;
    b, deslocamento: Byte;
    key: AnsiString;
    direcao: TDirecao;
begin
    key := Trim(AnsiString(edKey.Text));
    deslocamento := seDeslocamento.Value;
    str := AnsiString(ed2.Text);
    strRes := '';
    for i := 1 to Length(str) do
    begin
        b := Ord(Copy(str, i, 1)[1]);
        b := b and Byte(255);
        b := ByteFlip(b);
        b := ByteRevert(b);
        b := ByteInvert(b);
        if cbDirecao.ItemIndex = 0 then
            direcao := Esquerda
        else
            direcao := Direita;
        b := ByteRotate(b, direcao, seDeslocamento.Value);
        if key <> '' then
        begin
            bits := (Ord(key[((i - 1) mod Length(key)) + 1]) mod 7) + 1;
            b := ByteRotate(b, Direita, bits);
            b := b xor Ord(key[((i - 1) mod Length(key)) + 1]);
        end;
        b := b xor Length(key);
        b := b xor Byte(i);
        strRes := strRes + AnsiChar(b);
    end;
    textoCodificado := strRes;
    ed3.Text := strRes;
end;

procedure TfrmRotacao.btnFlipClick(Sender: TObject);
begin
    if Trim(edByte.Text) <> '' then
    begin
        edBin.Text := ByteToBin(StrToInt(edByte.Text));
        edByte2.Text := IntToStr(ByteFlip(StrToInt(edByte.Text)));
        edBin2.Text := ByteToBin(StrToInt(edByte2.Text));
    end;
end;

procedure TfrmRotacao.btnInvertClick(Sender: TObject);
begin
    if Trim(edByte.Text) <> '' then
    begin
        edBin.Text := ByteToBin(StrToInt(edByte.Text));
        edByte2.Text := IntToStr(ByteInvert(StrToInt(edByte.Text)));
        edBin2.Text := ByteToBin(StrToInt(edByte2.Text));
    end;
end;

procedure TfrmRotacao.btnRevertClick(Sender: TObject);
begin
    if Trim(edByte.Text) <> '' then
    begin
        edBin.Text := ByteToBin(StrToInt(edByte.Text));
        edByte2.Text := IntToStr(ByteRevert(StrToInt(edByte.Text)));
        edBin2.Text := ByteToBin(StrToInt(edByte2.Text));
    end;
end;

procedure TfrmRotacao.Button1Click(Sender: TObject);
var
    b: Byte;
begin
    b := Byte(StrToInt(edByte.Text)) xor Byte(seMascara.Value);
    edWithMask.Text := IntToStr(b);
end;

procedure TfrmRotacao.Button2Click(Sender: TObject);
var
    b: Byte;
begin
    b := Byte(StrToInt(edWithMask.Text)) xor Byte(seMascara.Value);
    edByte.Text := IntToStr(b);
end;

procedure TfrmRotacao.edBinKeyPress(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'1']) then
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
    if not (Key in ['0'..'9']) then
        Key := #0;
end;

procedure TfrmRotacao.edWithMaskExit(Sender: TObject);
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

procedure TfrmRotacao.edWithMaskKeyPress(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'9']) then
        Key := #0;
end;

end.

