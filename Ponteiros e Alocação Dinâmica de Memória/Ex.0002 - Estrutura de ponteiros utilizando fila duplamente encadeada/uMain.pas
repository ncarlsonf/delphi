unit uMain;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
    Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
    RxToolEdit, RxCurrEdit, DateUtils, System.Masks;

type
    PPessoa = ^TPessoa;

    TPessoa = record
        Anterior, Proximo: PPessoa;
        Id, Index: Integer;
        Nome, Telefone: string;
    end;

    TfrmMain = class(TForm)
        Label3: TLabel;
        btnAlimentar: TButton;
        GroupBox1: TGroupBox;
        btnBubbleSortId: TButton;
        btnQuickSortTelefone: TButton;
        btnQuickSortId: TButton;
        btnQuickSortNome: TButton;
        btnBubbleSortTelefone: TButton;
        btnBubbleSortNome: TButton;
        GroupBox2: TGroupBox;
        btnAdd: TButton;
        btnDel: TButton;
        btnFirst: TButton;
        btnPrior: TButton;
        btnNext: TButton;
        btnLast: TButton;
        GroupBox3: TGroupBox;
        Label1: TLabel;
        Label2: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        edNome: TEdit;
        edFone: TEdit;
        edId: TCurrencyEdit;
        edIndex: TCurrencyEdit;
        lbStatus: TLabel;
        GroupBox4: TGroupBox;
        edPesquisarTexto: TEdit;
        Label6: TLabel;
        btnBusca: TButton;
        Label7: TLabel;
        procedure btnAddClick(Sender: TObject);
        procedure btnDelClick(Sender: TObject);
        procedure btnFirstClick(Sender: TObject);
        procedure btnPriorClick(Sender: TObject);
        procedure btnNextClick(Sender: TObject);
        procedure btnLastClick(Sender: TObject);
        procedure btnBubbleSortNomeClick(Sender: TObject);
        procedure btnAlimentarClick(Sender: TObject);
        procedure btnBubbleSortIdClick(Sender: TObject);
        procedure btnBubbleSortTelefoneClick(Sender: TObject);
        procedure btnQuickSortIdClick(Sender: TObject);
        procedure btnQuickSortNomeClick(Sender: TObject);
        procedure btnQuickSortTelefoneClick(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    frmMain: TfrmMain;
    Primeiro, Ultimo, Atual: PPessoa;
    id, qtd: Integer;

function NewId(): Integer;

procedure Reindex();

procedure BubbleSort(const tipoOrd: Integer = 2);

function AddPessoa(nome, telefone: string): PPessoa;

procedure RemovePessoa(pessoa: PPessoa); overload;

procedure RemovePessoa(); overload;

procedure RemovePessoa(id: Integer); overload;

procedure RemovePessoa(nome: string); overload;

function GoFirst(): PPessoa;

function GoPrior(): PPessoa;

function GoNext(): PPessoa;

function GoLast(): PPessoa;

procedure ExibirPessoa(); overload;

procedure ExibirPessoa(id: Integer); overload;

procedure ExibirPessoa(nome: string); overload;

implementation

{$R *.dfm}

var
    timeA, timeB: TTime;
    timeTotal: string;

procedure BeginBenchmark();
begin
    timeA := Now();
end;

procedure EndBenchmark();
begin
    timeB := Now;
    timeTotal := ': (' + IntToStr(MilliSecondsBetween(timeA, timeB)) + ' milissegundos)';
end;

function StrLike(const str: string; mask: string; const modoSQL: Boolean = true): boolean;
{
    Wildchars:
      ? : qualquer caractere.
      * : qualquer texto.
      [] : um conjunto de cacacteres.

    no modo SQL:
      * vira %
      ? vira _
}
var
    msk: TMask;
begin
    if modoSQL then
    begin
        mask := StringReplace(mask, '_', '?', [rfReplaceAll]);
        mask := StringReplace(mask, '%', '*', [rfReplaceAll]);
    end;
    msk := Tmask.Create(mask);
    Result := msk.Matches(str);
    msk.Destroy;
end;

// gera um novo identificador
function NewId(): Integer;
begin
    Inc(id);
    Result := id;
end;

procedure Reindex();
var
    tmp: PPessoa;
    idx: Integer;
begin
    idx := 0;
    qtd := 0;
    if primeiro <> nil then
    begin
        tmp := primeiro;
        while tmp <> nil do
        begin
            Inc(idx);
            Inc(qtd);
            tmp^.Index := idx;
            tmp := tmp^.Proximo;
        end;
    end;
end;

function BuscaBinaria(arrayPessoa: array of PPessoa; texto: string; posicaoInicial, posicaoFinal: Integer; const tipoBusca: Integer = 2): Integer; overload;
var
    i, j: Integer;
    a, b, tmp: PPessoa;
    id: Integer;
    nome, telefone: string;
    tipo: Integer;
    Meio: Integer;
begin
    tipo := tipoBusca;
    if tipo < 1 then tipo := 1;
    if tipo > 3 then tipo := 3;

    if  (((tipo = 1) and (IntToStr(arrayPessoa[posicaoInicial]^.Id) = texto))
        or ((tipo = 2) and (arrayPessoa[posicaoInicial]^.Nome = texto))
        or ((tipo = 3) and (arrayPessoa[posicaoInicial]^.Nome = texto)))
    then
    begin
        Result := posicaoInicial;
    end
    else
    begin
        if (((tipo = 1) and (IntToStr(arrayPessoa[posicaoFinal]^.Id) = texto))
        or ((tipo = 2) and (arrayPessoa[posicaoFinal]^.Nome = texto))
        or ((tipo = 3) and (arrayPessoa[posicaoFinal]^.Nome = texto))) then
        begin
            Result := posicaoFinal;
        end
        else
        begin
            Meio := Trunc((posicaoFinal - posicaoInicial) div 2) + posicaoInicial;
            if (((tipo = 1) and (IntToStr(arrayPessoa[Meio]^.Id) = texto))
                or ((tipo = 2) and (arrayPessoa[Meio]^.Nome = texto))
                or ((tipo = 3) and (arrayPessoa[Meio]^.Nome = texto))) then
            begin
                Result := Meio;
            end
            else
            begin
                if (((tipo = 1) and (IntToStr(arrayPessoa[Meio]^.Id) > texto))
                    or ((tipo = 2) and (arrayPessoa[Meio]^.Nome > texto))
                    or ((tipo = 3) and (arrayPessoa[Meio]^.Nome > texto))) then
                begin
                    Result := BuscaBinaria(arrayPessoa, texto, posicaoInicial, Meio);
                end
                else
                begin
                    Result := BuscaBinaria(arrayPessoa, texto, Meio, posicaoFinal);
                end;
            end;
        end;
    end;
end;

function BuscaBinaria(texto: String): PPessoa; overload;
var
    arrayPessoa: array of PPessoa;
    i: Integer;
    tmp: PPessoa;
begin
    if Qtd = 0 then
        Exit;
    SetLength(arrayPessoa, Qtd);
    tmp := primeiro;
    if tmp <> nil then
    begin
        i := Low(arrayPessoa);
        while tmp <> nil do
        begin
            arrayPessoa[i] := tmp;
            tmp := tmp^.Proximo;
            Inc(i);
        end;
    end;
    i := BuscaBinaria(arrayPessoa, texto, Low(arrayPessoa), High(arrayPessoa));
    if i >= Low(arrayPessoa) then
        atual := arraypessoa[i];
end;

procedure Quicksort(const tipoBusca: Integer = 1); overload; // tipo 1 por id, 2 por nome, 3 por telefone
var
    tipo: Integer;
    size: Integer;
    arr: array of PPessoa;
    tmp: PPessoa;
    i: integer;

    procedure QuicksortRecur(start, stop: integer);
    var
        m: integer;
        splitpt: integer;

        function Split(start, stop: integer): integer;
        var
            left, right: integer;
            pivotId: Integer;
            pivotNome, pivotTelefone: string;

            procedure swap(var a, b: PPessoa);
            var
                t: integer;
                id: Integer;
                nome, telefone: string;
            begin
                id := b^.id;
                nome := b^.nome;
                telefone := b^.telefone;
                b^.id := a^.id;
                b^.nome := a^.nome;
                b^.telefone := a^.telefone;
                a^.id := id;
                a^.nome := nome;
                a^.telefone := telefone;
            end;

        begin
            pivotId := arr[start]^.id;
            pivotNome := arr[start]^.nome;
            pivotTelefone := arr[start]^.telefone;
            left := start + 1;
            right := stop;
            while left <= right do
            begin
                while (left <= stop) and (((tipo = 1) and (arr[left]^.id < pivotId)) or ((tipo = 2) and (arr[left]^.nome < pivotNome)) or ((tipo = 3) and (arr[left]^.telefone < pivotTelefone))) do
                    left := left + 1;

                while (right > start) and (((tipo = 1) and (arr[right]^.id >= pivotId)) or ((tipo = 2) and (arr[right]^.nome >= pivotNome)) or ((tipo = 3) and (arr[right]^.telefone >= pivotTelefone))) do
                    right := right - 1;
                if left < right then
                    swap(arr[left], arr[right]);
            end;
            swap(arr[start], arr[right]);
            Split := right
        end;

    begin
        if start < stop then
        begin
            splitpt := Split(start, stop);
            QuicksortRecur(start, splitpt - 1);
            QuicksortRecur(splitpt + 1, stop);
        end;
    end;

begin
    tipo := tipoBusca;
    size := Qtd;
    SetLength(arr, Qtd);
    tmp := primeiro;
    if tmp <> nil then
    begin
        i := Low(arr);
        while tmp <> nil do
        begin
            arr[i] := tmp;
            tmp := tmp^.Proximo;
            Inc(i);
        end;
    end;
    if tipo < 1 then
        tipo := 1;
    if tipo > 3 then
        tipo := 3;
    QuicksortRecur(0, size - 1);
    Reindex();
    GoFirst();
end;

procedure BubbleSort(const tipoOrd: Integer = 2); // 1 por id, 2 por nome, 3 por telefone
var
    i, j: Integer;
    a, b, tmp: PPessoa;
    id: Integer;
    nome, telefone: string;
    arrayPessoa: array of PPessoa;
    tipo: Integer;
begin
    tipo := tipoOrd;

    if tipo < 1 then
        tipo := 1;
    if tipo > 3 then
        tipo := 3;

    SetLength(arrayPessoa, Qtd);
    tmp := primeiro;
    if tmp <> nil then
    begin
        i := Low(arrayPessoa);
        while tmp <> nil do
        begin
            arrayPessoa[i] := tmp;
            tmp := tmp^.Proximo;
            Inc(i);
        end;

        for i := Low(arrayPessoa) to High(arrayPessoa) - 1 do
        begin
            for j := i + 1 to High(arrayPessoa) do
            begin
                a := arrayPessoa[i];
                b := arrayPessoa[j];
                if ((tipo = 1) and (a^.id > b^.id)) or ((tipo = 2) and (CompareStr(a^.nome, b^.nome) > 0)) or ((tipo = 3) and (a^.telefone > b^.telefone)) then
                begin
                    id := b^.id;
                    nome := b^.nome;
                    telefone := b^.telefone;
                    b^.id := a^.id;
                    b^.nome := a^.nome;
                    b^.telefone := a^.telefone;
                    a^.id := id;
                    a^.nome := nome;
                    a^.telefone := telefone;
                end;
            end;
        end;
        Reindex();
        GoFirst();
    end;
end;

// adiciona uma pessoa
function AddPessoa(nome, telefone: string): PPessoa;
begin
    Result := New(PPessoa);
    Result^.nome := nome;
    Result^.telefone := telefone;
    Result^.id := NewId();
    Atual := Result;
    if Primeiro = nil then
    begin
        Result^.Anterior := nil;
        Result^.Proximo := nil;
        Primeiro := Result;
        Ultimo := Result;
        Result^.Index := 1;
    end
    else
    begin
        Ultimo^.Proximo := Result;
        Result^.Anterior := Ultimo;
        Result^.Proximo := nil;
        Ultimo := Result;
        if Result^.Anterior <> nil then
        begin
            Result^.Index := Result^.Anterior^.Index + 1;
        end;
    end;
    Inc(qtd);
end;


// remove a pessoa atual passando o endereço de memória da pessoa
procedure RemovePessoa(pessoa: PPessoa);
var
    tmp: PPessoa;
begin
    tmp := pessoa;
    if tmp <> nil then
    begin
        if tmp^.Anterior <> nil then
        begin
            Atual := tmp^.Anterior;
            tmp^.Anterior^.Proximo := tmp^.Proximo;
        end
        else
            primeiro := tmp^.Proximo;
        if tmp^.Proximo <> nil then
        begin
            Atual := tmp^.Proximo;
            tmp^.Proximo^.Anterior := tmp^.Anterior;
        end
        else
            ultimo := tmp^.Anterior;
        if (primeiro = nil) and (ultimo = nil) then
        begin
            atual := nil;
        end;
        Dispose(tmp);
    end;
    Reindex();
end;


// remove a pessoa atual
procedure RemovePessoa();
begin
    RemovePessoa(atual);
end;

// remove a pessoa pelo id e posiciona no registro anterior e se não houver anterior prosiciona no próximo
procedure RemovePessoa(id: Integer);
var
    tmp: PPessoa;
begin
    tmp := Primeiro;
    if tmp <> nil then
    begin
        while tmp <> nil do
        begin
            if tmp^.id = id then
            begin
                RemovePessoa(tmp);
                Break;
            end;
            tmp := tmp.Proximo;
        end;
    end;

end;

// remove a pessoa pelo nome e posiciona no registro anterior e se não houver anterior prosiciona no próximo
procedure RemovePessoa(nome: string);
var
    tmp: PPessoa;
begin
    tmp := Primeiro;
    if tmp <> nil then
    begin
        while tmp <> nil do
        begin
            if tmp^.nome = nome then
            begin
                RemovePessoa(tmp);
                Break;
            end;
            tmp := tmp.Proximo;
        end;
    end;

end;


// vai para a primeira pessoa e retorna
function GoFirst(): PPessoa;
begin
    if (primeiro <> nil) then
    begin
        atual := primeiro;
    end
    else
        MessageDlg('Não há registros na lista.', mtWarning, [mbOk], 0);
end;

// vai para a pessoa anterior e retorna
function GoPrior(): PPessoa;
begin
    if atual <> nil then
    begin
        if atual^.Anterior <> nil then
            atual := atual^.Anterior
        else
            MessageDlg('Não há mais registros anteriores.', mtWarning, [mbOk], 0);
    end
    else
        MessageDlg('Não há registros na lista.', mtWarning, [mbOk], 0);
end;

// vai para a próxima pessoa e retorna
function GoNext(): PPessoa;
begin
    if atual <> nil then
    begin
        if atual^.Proximo <> nil then
            atual := atual^.Proximo
        else
            MessageDlg('Não há mais registros posteriores.', mtWarning, [mbOk], 0);
    end
    else
        MessageDlg('Não há registros na lista.', mtWarning, [mbOk], 0);
end;

// vai para a última pessoa e retorna
function GoLast(): PPessoa;
begin
    if (ultimo <> nil) then
    begin
        atual := ultimo;
    end
    else
        MessageDlg('Não há registros na lista.', mtWarning, [mbOk], 0);
end;

// exibe pessoa atual
procedure ExibirPessoa();
begin
    if atual <> nil then
    begin
        frmMain.edId.Value := atual^.id;
        frmMain.edNome.Text := atual^.nome;
        frmMain.edFone.Text := atual^.telefone;
        frmMain.edIndex.Value := atual^.Index;
    end
    else
    begin
        frmMain.edId.Value := 0;
        frmMain.edNome.Text := '';
        frmMain.edFone.Text := '';
        frmMain.edIndex.Value := 0;
        MessageDlg('Ninguém na lista.', mtWarning, [mbOk], 0);
    end;
    frmMain.lbStatus.Caption := 'Item: ' + IntToStr(atual^.Index) + ' de ' + IntToStr(qtd);
end;


// exibe pessoa por id
procedure ExibirPessoa(id: Integer);
var
    tmp: PPessoa;
begin
    tmp := primeiro;
    while tmp <> nil do
    begin
        if tmp^.id = id then
        begin
            atual := tmp;
            ExibirPessoa();
            Break;
        end;
        tmp := tmp^.Proximo;
    end;
end;

// exibe pessoa por nome
procedure ExibirPessoa(nome: string);
var
    tmp: PPessoa;
begin
    tmp := primeiro;
    while tmp <> nil do
    begin
        if UpperCase(tmp^.nome) = UpperCase(nome) then
        begin
            atual := tmp;
            ExibirPessoa();
            Break;
        end;
        tmp := tmp^.Proximo;
    end;
end;

procedure TfrmMain.btnAddClick(Sender: TObject);
begin
    AddPessoa(edNome.Text, edFone.Text);
    ExibirPessoa();
end;

procedure TfrmMain.btnAlimentarClick(Sender: TObject);
var
    f: TextFile;
    s: string;
    a: TArray<string>;
    nome, telefone: string;
    i: Integer;
begin
    BeginBenchmark();
    i := 0;
    if qtd = 0 then
    begin
        if FileExists('CARGA.TXT') then
        begin
            AssignFile(f, 'CARGA.TXT');
            Reset(f);
            while not Eof(f) do
            begin
                ReadLn(f, s);
                a := s.Split(['|']);
                if Length(a) = 2 then
                begin
                    Inc(i);
                    nome := a[Low(a)];
                    telefone := a[High(a)];
                    AddPessoa(nome, telefone);
                end;
            end;
            CloseFile(f);
        end;
        GoFirst();
        ExibirPessoa();
        EndBenchmark();

        MessageDlg('Carga concluída de ' + IntToStr(i) + ' registro(s)!' + timeTotal, mtConfirmation, [mbOk], 0);
    end;
end;

procedure TfrmMain.btnDelClick(Sender: TObject);
begin
    RemovePessoa(atual);
    ExibirPessoa();
end;

procedure TfrmMain.btnFirstClick(Sender: TObject);
begin
    if (atual <> nil) and (atual = primeiro) then
        MessageDlg('Já está no primeiro registro.', mtWarning, [mbOk], 0);
    GoFirst();
    ExibirPessoa();
end;

procedure TfrmMain.btnLastClick(Sender: TObject);
begin
    if (atual <> nil) and (atual = ultimo) then
        MessageDlg('Já está no último registro.', mtWarning, [mbOk], 0);
    GoLast();
    ExibirPessoa();
end;

procedure TfrmMain.btnNextClick(Sender: TObject);
begin
    GoNext();
    ExibirPessoa();
end;

procedure TfrmMain.btnPriorClick(Sender: TObject);
begin
    GoPrior();
    ExibirPessoa();
end;

procedure TfrmMain.btnBubbleSortIdClick(Sender: TObject);
begin
    BeginBenchmark();
    BubbleSort(1);
    EndBenchmark();
    ExibirPessoa();
    ShowMessage('Ordenado por Id (BubbleSort)' + timeTotal);
end;

procedure TfrmMain.btnBubbleSortNomeClick(Sender: TObject);
begin
    BeginBenchmark();
    BubbleSort(2);
    EndBenchmark();
    ExibirPessoa();
    ShowMessage('Ordenado por Nome (BubbleSort)' + timeTotal);
end;

procedure TfrmMain.btnBubbleSortTelefoneClick(Sender: TObject);
begin
    BeginBenchmark();
    BubbleSort(3);
    EndBenchmark();
    ExibirPessoa();
    ShowMessage('Ordenado por Telefone (BubbleSort)' + timeTotal);
end;

procedure TfrmMain.btnBuscaClick(Sender: TObject);
var
    tmp: PPessoa;
    iniciou: boolean;
    index: Integer;
begin
    if Qtd = 0 then
        Exit;
    iniciou := false;
    tmp := atual;
    if atual^.Proximo <> nil then
        tmp := atual^.Proximo
    else
        tmp := primeiro;
    index := -1;
    if tmp <> nil then
    begin
        while tmp^.Index <> index do
        begin
            if not iniciou then
            begin
                index := tmp^.Index;
                iniciou := True;
            end;
            if StrLike(tmp^.Nome, edPesquisarTexto.Text) then
            begin
                atual := tmp;
                ExibirPessoa();
                Break;
            end;
            tmp := tmp^.Proximo;
            if tmp = nil then
                tmp := primeiro;
        end;
    end;
end;

procedure TfrmMain.btnQuickSortIdClick(Sender: TObject);
begin
    BeginBenchmark();
    QuickSort(1);
    EndBenchmark();
    ExibirPessoa();
    ShowMessage('Ordenado por Id (QuickSort)' + timeTotal);
end;

procedure TfrmMain.btnQuickSortNomeClick(Sender: TObject);
begin
    BeginBenchmark();
    QuickSort(2);
    EndBenchmark();
    ExibirPessoa();
    ShowMessage('Ordenado por Nome (QuickSort)' + timeTotal);
end;

procedure TfrmMain.btnQuickSortTelefoneClick(Sender: TObject);
begin
    BeginBenchmark();
    QuickSort(3);
    EndBenchmark();
    ExibirPessoa();
    ShowMessage('Ordenado por Telefone (QuickSort)' + timeTotal);
end;

initialization
    id := 0;
    Primeiro := nil;
    Ultimo := nil;
    Atual := nil;

end.

