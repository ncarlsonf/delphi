unit uMain;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    System.Generics.Collections, Vcl.StdCtrls;

type
    TfmMain = class(TForm)
        Memo1: TMemo;
    Button1: TButton;
        procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

    TContato = class
    public
        Nome: String;
        Fone: String;
        Email: String;
        constructor Create(Nome, Fone, Email: String);
        function ToString(): String;
    end;

    TContatoList = class(TList<TContato>)
    public
        // Obt?m um ?ndice
        function IndexOf(Nome: String): Integer; overload;
        function GetContato(Nome: String): TContato;
    end;

var
    fmMain: TfmMain;
    contatoList: TContatoList;


implementation

uses
  System.Generics.Defaults;

{$R *.dfm}

function Inverter(str: String; var tamanho: Integer): String;
var
    i: Integer;
begin
    Result := '';
    tamanho := tamanho + Length(str);
    for i := Length(str) downto 1 do
        Result := Result + Copy(str, i, 1);
end;


constructor TContato.Create(Nome, Fone, Email: String);
begin
    Self.Nome := Nome;
    Self.Fone := Fone;
    Self.Email := Email;
end;

function TContato.ToString(): String;
begin
    Result := 'Nome="' + Nome + '";Fone="' + Fone + '";Email="' + Email + '"';
end;

function TContatoList.IndexOf(Nome: String): Integer;
var
    i: Integer;
    contato: TContato;
begin
    Result := -1;
    for i := 0 to Self.Count - 1 do
    begin
        contato := Self.Items[i];
        if UpperCase(Trim(contato.Nome)) = UpperCase(Trim(Nome)) then
        begin
            Result := i;
            Exit;
        end;
    end;
    MessageDlg('Contato "' + Nome + '" n?o localizado.', mtWarning, [mbOk], 0);
end;

function TContatoList.GetContato(Nome: String): TContato;
var
    contato: TContato;
begin
    Result := nil;
    for contato in Self do
    begin
        if UpperCase(Trim(contato.Nome)) = UpperCase(Trim(Nome)) then
        begin
            Result := contato;
            Exit;
        end;
    end;
    MessageDlg('Contato "' + Nome + '" n?o localizado.', mtWarning, [mbOk], 0);
end;

procedure TfmMain.Button1Click(Sender: TObject);
begin
    Self.Close();
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
    contato: TContato;
    i, idx: Integer;
    tamanhoInicial: Integer;
    str: String;
    compararPorTamanho, compararPorOrdemAlfabetica: IComparer<TContato>;
    compararPorOrdemAlfabeticaDoEmail: TComparison<TContato>;
begin
    Memo1.Clear();

    compararPorTamanho :=
        TComparer<TContato>.Construct(
            function(const a, b: TContato): Integer
            begin
                if Length(a.Nome) > Length(b.Nome) then
                    Result := 1
                else if Length(b.Nome) > Length(a.Nome) then
                    Result := -1
                else
                    Result := 0;
            end
        );

    compararPorOrdemAlfabetica :=
        TComparer<TContato>.Construct(
            function(const a, b: TContato): Integer
            begin
                if a.Nome > b.Nome then
                    Result := 1
                else if b.Nome > a.Nome then
                    Result := -1
                else
                    Result := 0;
            end
        );

    compararPorOrdemAlfabeticaDoEmail :=
        function(const a, b: TContato): Integer
        begin
            if a.Email > b.Email then
                Result := 1
            else if b.Email > a.Email then
                Result := -1
            else
                Result := 0;
        end;

    contatoList := TContatoList.Create();

    contatoList.Add(TContato.Create('Pedro', '88 9991128552', 'binario@tk2000.com.br'));
    contatoList.Add(TContato.Create('Nelson Filho', '85 991913019', 'assincrono@tk2000.com.br'));
    contatoList.Add(TContato.Create('Francisco', '88 988885555', 'constante@tk2000.com.br'));

    contatoList.Sort();

    Memo1.Lines.Add('Foreach');

    for contato in contatoList do
        Memo1.Lines.Add(contato.ToString());

    Memo1.Lines.Add('');

    Memo1.Lines.Add('Incremento normal');

    for i := 0 to contatoList.Count - 1 do
        Memo1.Lines.Add(contatoList.Items[i].ToString());

    Memo1.Lines.Add('');
    Memo1.Lines.Add('Ordenar por Tamanho do Nome');
    contatoList.Sort(compararPorTamanho);
    for i := 0 to contatoList.Count - 1 do
        Memo1.Lines.Add(contatoList.Items[i].ToString());

    Memo1.Lines.Add('');
    Memo1.Lines.Add('Ordenar por Ordem Alfab?tica do Nome');
    contatoList.Sort(compararPorOrdemAlfabetica);
    for i := 0 to contatoList.Count - 1 do
        Memo1.Lines.Add(contatoList.Items[i].ToString());

    Memo1.Lines.Add('');
    Memo1.Lines.Add('Ordenar por Ordem Alfab?tica do E-mail');
    contatoList.Sort(TComparer<TContato>.Construct(compararPorOrdemAlfabeticaDoEmail));
    for i := 0 to contatoList.Count - 1 do
        Memo1.Lines.Add(contatoList.Items[i].ToString());

    Memo1.Lines.Add('');
    idx := contatoList.IndexOf('Nelson Filho');
    if idx <> -1 then
        Memo1.Lines.Add('Contato "Nelson Filho" localizado no ?ndice "' + IntToStr(idx) + '"');

    Memo1.Lines.Add('');
    contato := contatoList.GetContato('Francisco');
    if contato <> nil then
    begin
        Memo1.Lines.Add('Contato "Francisco" localizado');
        Memo1.Lines.Add(contato.ToString());
    end;

    Memo1.Lines.Add('');
    contato := contatoList.GetContato('Antonio de P?dua');
    if contato <> nil then
    begin
        Memo1.Lines.Add('Contato "Antonio de P?dua" localizado');
        Memo1.Lines.Add(contato.ToString());
    end;

end;

end.

