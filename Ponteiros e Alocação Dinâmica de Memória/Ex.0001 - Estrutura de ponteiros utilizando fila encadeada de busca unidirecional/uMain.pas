{
Ex. Uso de ponteiro com lista unicamente encadeada (só percorre o cursor para frente, se tiver que voltar tem que começar do primeiro dado).

Código escrito por: Nelson Carlson F. (nelson@tk2000.com.br, nelson@contadeemail.com)
Date/Hora: 20/08/2021 15:19h

- Cada pesquisa tem que começar do primeiro registro.
- Cada registro tem o endereço do próximo registro.
- Cada novo registro é alocado na memória RAM.

Alguns tipos e variáveis:
- pessoa: variável do tipo PPessoa (ponteiro para TPessoa)
- PPessoa: tipo ponteiro de merória para um espaço alocado que referencia um dado que possa armazenar um record/registro do tipo TPessoa
- TPessoa: tipo record/registro que armazena Id: Inteiro, Nome: String e Proximo: PPessoa (endereço de memória da próxima pessoa)
- primeoro: variável que guarda o ponteiro para a posição de memória da primeira pessoa criada

Diagrama da estrutura:

Obs.: Registros e endereços de exemplo, fictícios.  Os endereços são criados durante a execução do programa.

	Posição de memória 1
	Endereço: $785845466521
   +-------+---------------------+---------------------+
   | Id    | Nome                | Proximo             |
   +-------+---------------------+---------------------+
   |     1 | RENATA              | $88518996123        |
   +-------+---------------------+---------------------+

    Posição de memória 2
   	Endereço: $88518996123
   +-------+---------------------+---------------------+
   | Id    | Nome                | Proximo             |
   +-------+---------------------+---------------------+
   |     2 | CARLOS              | $88684598665        |
   +-------+---------------------+---------------------+

    Posição de memória 3
   	Endereço: $88684598665
   +-------+---------------------+---------------------+
   | Id    | Nome                | Proximo             |
   +-------+---------------------+---------------------+
   |     3 | ANTONIO             | $88716561515        |
   +-------+---------------------+---------------------+

    Posição de memória 4
   	Endereço: $88716561515
   +-------+---------------------+---------------------+
   | Id    | Nome                | Proximo             |
   +-------+---------------------+---------------------+
   |     4 | MARCIA              | $88831685156        |
   +-------+---------------------+---------------------+

   	Posição de memória 5
	Endereço: $88831685156
   +-------+---------------------+---------------------+
   | Id    | Nome                | Proximo             |
   +-------+---------------------+---------------------+
   |     5 | BRUNA               | $88954984546        |
   +-------+---------------------+---------------------+

   primeiro = Endereço: $785845466521


Exemplo de Busca por Id:

- Para buscar, por exemplo o registro da posição 4, ou seja, do nome MARCIA,
  a variável ponteiro de busca assume em si o primeiro ponteiro e, enquanto
  não encontra o id que bate com a busca (4) essa variável irá assumir o dado
  chamado Proximo guardado nela, ou seja, pessoaTemp irá virar pessoaTemp.Proximo.
  Isso mostra pessoaTemp passeando pela memória recebendo o endereço guarado no
  dado chamado Proximo que fica armazenado no próprio ponteiro.

}

unit uMain;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.StdCtrls, Vcl.Mask, RxToolEdit, RxCurrEdit;

type
    TfrmMain = class(TForm)
        edId: TCurrencyEdit;
        edNome: TEdit;
        btnSalvar: TButton;
        btnPrimeiro: TButton;
        btnProximo: TButton;
        btnLimpar: TButton;
        btnBuscarPorId: TButton;
        btnBuscarPorNome: TButton;
        lbId: TLabel;
        lbNome: TLabel;
        procedure FormCreate(Sender: TObject);
        procedure btnSalvarClick(Sender: TObject);
        procedure btnPrimeiroClick(Sender: TObject);
        procedure btnProximoClick(Sender: TObject);
        procedure btnLimparClick(Sender: TObject);
        procedure btnBuscarPorIdClick(Sender: TObject);
        procedure btnBuscarPorNomeClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

    PPessoa = ^TPessoa;

    TPessoa = record
        Id: Integer;
        Nome: string;
        Proximo: PPessoa;
    end;

function currentId(): Integer;

function newId(const save: Boolean = true): Integer;

function pessoaNew(nome: string): PPessoa;

function pessoaRemovePorId(id: Integer): Boolean;

function pessoaPrimeiro(): PPessoa;

function pessoaUltimo(): PPessoa;

function pessoaPorId(id: Integer): PPessoa;

function pessoaPorNome(nome: string): PPessoa;

var
    frmMain: TfrmMain;

var
    primeiro, pessoa: PPessoa;
    id: Integer;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
    pessoa := nil;
    primeiro := nil;
    edId.Value := -1;
    edNome.Text := '';
end;

procedure TfrmMain.btnSalvarClick(Sender: TObject);
var
    nomeAnterior, nomeNovo: string;
    pessoaTemp: PPessoa;
begin
    // idAtual := pessoaNew(edNome.Text)^.Id;
    pessoaTemp := nil;
    if edId.Value > -1 then
        pessoaTemp := pessoaPorId(Trunc(edId.Value));
    if pessoaTemp <> nil then
    begin
        pessoa := pessoaTemp;
        nomeAnterior := pessoa^.Nome;
        nomeNovo := edNome.Text;
        edNome.Text := nomeAnterior;
        if Trim(UpperCase(nomeAnterior)) <> Trim(UpperCase(nomeNovo)) then
        begin
            if MessageDlg('Deseja alterar o registro Id:"' + IntToStr(pessoa^.Id) + '" ' + 'do Nome:"' + nomeAnterior + '"' + 'para o Nome:"' + nomeNovo + '"', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
            begin
                pessoa^.Nome := nomeNovo;
                edNome.Text := nomeNovo;
                MessageDlg('Informação salva com sucesso!', mtInformation, [mbOk], 0);
            end;
        end;
    end
    else
    begin
        pessoaNew(edNome.Text);
        edId.Value := -1;
        edNome.Text := '';
    end;
end;

procedure TfrmMain.btnBuscarPorIdClick(Sender: TObject);
var
    pessoaTemp: PPessoa;
begin
    pessoaTemp := pessoaPorId(Trunc(edId.Value));
    if pessoaTemp <> nil then
    begin
        pessoa := pessoaTemp;
        edNome.Text := pessoaTemp^.Nome;
    end
    else
        MessageDlg('Não encontrado Id:"' + edId.Text + '"', mtWarning, [mbOk], 0);
end;

procedure TfrmMain.btnBuscarPorNomeClick(Sender: TObject);
var
    pessoaTemp: PPessoa;
begin
    pessoaTemp := pessoaPorNome(edNome.Text);
    if pessoaTemp <> nil then
    begin
        pessoa := pessoaTemp;
        edId.Value := pessoaTemp^.Id;
    end
    else
        MessageDlg('Não encontrado Nome:"' + edNome.Text + '"', mtWarning, [mbOk], 0);
end;

procedure TfrmMain.btnLimparClick(Sender: TObject);
begin
    edId.Value := -1;
    edNome.Text := '';
end;

procedure TfrmMain.btnPrimeiroClick(Sender: TObject);
begin
    if primeiro <> nil then
    begin
        pessoa := primeiro;
        with pessoa^ do
        begin
            edId.Value := Id;
            edNome.Text := Nome;
        end;
    end;
end;

procedure TfrmMain.btnProximoClick(Sender: TObject);
begin
    if (pessoa <> nil) and (pessoa^.Proximo <> nil) then
    begin
        pessoa := pessoa^.Proximo;
        with pessoa^ do
        begin
            edId.Value := Id;
            edNome.Text := Nome;
        end;
    end;
end;


// obtem o último id gerado
function currentId(): Integer;
begin
    Result := id;
end;

// obtem o útimo id gerado e gera um novo id
function newId(const save: Boolean = true): Integer;
begin
    Result := id + 1;
    if save then
        Inc(id);
end;

// cria uma nova pessoa
function pessoaNew(nome: string): PPessoa;
begin
    Result := New(PPessoa);
    Result^.Id := newId(); // utiliza o último id gerado
    Result^.nome := nome;
    Result^.Proximo := nil;
    pessoa := pessoaUltimo();
    if primeiro = nil then
        primeiro := Result;
    if pessoa <> nil then
        pessoa^.Proximo := Result;
    pessoa := Result;
end;

function pessoaRemovePorId(id: Integer): Boolean;
var
    pessoaTemp, pessoaAnterior: PPessoa;
    success: Boolean;
begin
    success := False;
    pessoaAnterior := nil;
    pessoaTemp^ := primeiro^;
    while (pessoaTemp <> nil) do
    begin
        if pessoaTemp^.id = id then
        begin
            if primeiro = pessoaTemp then
                primeiro := pessoaTemp^.Proximo;
            if (pessoaAnterior <> nil) then
                pessoaAnterior^.Proximo := pessoaTemp^.Proximo;
        end;
        pessoaAnterior := pessoaTemp;
        pessoaTemp := pessoaTemp^.Proximo;
    end;
end;

function pessoaPrimeiro(): PPessoa;
begin
    Result^ := primeiro^;
end;

function pessoaProximo(): PPessoa;
begin
    if pessoa^.Proximo <> nil then
        pessoa := pessoa^.Proximo;
end;

function pessoaUltimo(): PPessoa;
var
    pessoaTemp: PPessoa;
begin
    pessoaTemp := nil;
    if primeiro <> nil then
    begin
        pessoaTemp := primeiro;
        while (pessoaTemp <> nil) and (pessoaTemp^.Proximo <> nil) do
        begin
            pessoaTemp := pessoaTemp^.Proximo;
        end;
    end;
    Result := pessoaTemp;
end;

function pessoaContar(): Integer;
var
    i: Integer;
    pessoaTemp: PPessoa;
begin
    i := 0;
    pessoaTemp := pessoa;
    while pessoaTemp <> nil do
    begin
        pessoaTemp := pessoaTemp^.Proximo;
        Inc(i);
    end;
    Result := i;
end;

function pessoaPorId(id: Integer): PPessoa;
begin
    Result := primeiro;
    while (Result <> nil) and (Result^.id <> id) do
        Result := Result^.Proximo;
end;

function pessoaPorNome(nome: string): PPessoa;
begin
    Result := primeiro;
    while (Result <> nil) and (Trim(UpperCase(Result^.nome)) <> Trim(UpperCase(nome))) do
        Result := Result^.Proximo;
end;

end.

