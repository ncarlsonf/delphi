unit uMain;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
    JvMemoryDataset, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtDlgs;

type
    TfmMain = class(TForm)
        memData: TMemo;
        grid: TDBGrid;
        ds: TDataSource;
        tb: TJvMemoryData;
        tbCODIGO: TStringField;
        tbPRECO: TFloatField;
        tbQTD: TFloatField;
        btnLerEProcessar: TButton;
        GroupBox1: TGroupBox;
        Label1: TLabel;
        Label5: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        chkWithHeader: TCheckBox;
        edDelim: TEdit;
        edFormatDateTime: TEdit;
        edFormato: TEdit;
        cbSepNum: TComboBox;
        cbFormatos: TComboBox;
        Label4: TLabel;
        btnAplicar: TButton;
        opendialog: TOpenTextFileDialog;
        btnLer: TButton;
        btnProcessar: TButton;
        lbRegistrosLidos: TLabel;
        procedure btnLerEProcessarClick(Sender: TObject);
        procedure btnAplicarClick(Sender: TObject);
        procedure btnLerClick(Sender: TObject);
        procedure btnProcessarClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure FormDestroy(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
        listFormatos: TStringList;
        procedure LoadFormat();
        procedure Process();
    end;

var
    fmMain: TfmMain;

implementation

{$R *.dfm}

uses
    TkHelpers, uFuncoes;

type
    TStringWrapper = class
        Txt: string;
    end;

    TCampo = record
        Nome: string;
        Tipo: string;
        Tamanho: Integer;
        Decimais: Integer;
    end;

var
    campos: array of TCampo;
    qtdCampos: Integer;
    valido: Boolean;

procedure TfmMain.LoadFormat();
var
    i, qtdParts: Integer;
    aStr, parts: TArray<string>;
begin
    valido := False;
    aStr := ('' + edFormato.Text).Split([',']);
    qtdCampos := Length(aStr);
    SetLength(campos, qtdCampos);
    for i := Low(aStr) to High(aStr) do
    begin
        valido := True;
        try
            parts := aStr[i].Split(['|']);
            qtdParts := Length(parts);
            if qtdParts < 3 then
            begin
                MessageDlg('Quantidade de partes menor que 3 em "' + edFormato.Text + '".', mtError, [mbOk], 0);
                Exit;
            end;
            if (not (StrInCi(parts[0], ['CODIGO', 'QTD', 'PRECO']))) then
            begin
                MessageDlg('Campo não permitido "' + parts[0] + '".'#13'Utilizar: CODIGO, QTD, PRECO', mtError, [mbOk], 0);
                Exit;
            end;
            if (not (StrInCi(parts[1], ['TEXTO', 'NUMERO']))) then
            begin
                MessageDlg('Tipo não permitido "' + parts[1] + '".'#13'Utilizar: TEXTO, NUMERO', mtError, [mbOk], 0);
                Exit;
            end;
            campos[i].Nome := Trim(UpperCase(parts[0]));
            campos[i].Tipo := Trim(UpperCase(parts[1]));
            campos[i].Tamanho := StrToInt(Trim(UpperCase(parts[2])));
            campos[i].Decimais := 0;
            if qtdParts > 3 then
                campos[i].Decimais := StrToInt(Trim(UpperCase(parts[3])));
        except
            on e: Exception do
            begin
                MessageDlg('Erro no formato em "' + aStr[i] + '"'#13 + e.Message, mtError, [mbOk], 0);
                valido := False;
                Exit;
            end;
        end;
    end;
end;

procedure TfmMain.Process();
var
    i, j, ini: Integer;
    txt, delim: string;
    qtdParts: Integer;
    parts: TArray<string>;
    sepNum: Char;
    numero, decimal: string;
    valor: Double;
begin
    LoadFormat();
    if not valido then
        Exit;

    if tb.Active then
        tb.Close();
    tb.Open();
    ini := 0;
    if chkWithHeader.Checked then
        ini := 1;
    delim := Trim(edDelim.Text);
    sepNum := cbSepNum.Text[1];

    if Length(delim) > 1 then
    begin
        if Copy(delim, 1, 1) = '#' then
            delim := Char(StrToInt(Copy(delim, 2, Length(delim))));
    end
    else
        delim := Copy(delim, 1, 1);
    try
        for i := ini to memData.Lines.Count do
        begin
            txt := memData.Lines[i];
            if Trim(txt) = '' then
                Exit;
            parts := txt.Split([delim]);
            qtdParts := Length(parts);
            if qtdParts <> qtdCampos then
            begin
                MessageDlg('Erro na linha ' + IntToStr(i) + #13 + txt, mtError, [mbOk], 0);
                Exit;
            end;
            try
                tb.Append();
                for j := Low(parts) to High(parts) do
                begin
                    if StrEqCi(campos[j].Tipo, 'TEXTO') then
                    begin
                        txt := parts[j];
                        if campos[j].Tamanho > 0 then
                            txt := Copy(txt, 1, campos[j].Tamanho);
                        tb.FieldByName(campos[j].Nome).Value := txt;
                    end
                    else if StrEqCi(campos[j].Tipo, 'NUMERO') then
                    begin
                        if Pos('' + sepNum, parts[j]) > 0 then
                        begin
                            numero := parts[j].Split([sepNum])[0];
                            decimal := parts[j].Split([sepNum])[1];
                            if campos[j].Decimais > 0 then
                                decimal := Copy(decimal, 1, campos[j].Decimais);
                            valor := StrToFloat(numero + ',' + decimal);
                        end
                        else
                        begin
                            valor := StrToInt(parts[j]);
                        end;
                        tb.FieldByName(campos[j].Nome).Value := valor;
                    end;
                end;
                tb.Post();
            except
                tb.Cancel();
            end;

        end;
    finally
        tb.First();
        lbRegistrosLidos.Caption := 'Registros Lidos: ' + IntToStr(tb.RecordCount);
    end;
end;

procedure TfmMain.btnAplicarClick(Sender: TObject);
begin
    edFormato.Text := TStringWrapper(cbFormatos.Items.Objects[cbFormatos.ItemIndex]).txt;
end;

procedure TfmMain.btnLerClick(Sender: TObject);
begin
    if not OpenDialog.Execute() then
        Exit;
    if not FileExists(OpenDialog.FileName) then
        Exit;
    memData.Clear();
    memData.Lines.LoadFromFile(OpenDialog.FileName);
end;

procedure TfmMain.btnLerEProcessarClick(Sender: TObject);
begin
    if not OpenDialog.Execute() then
        Exit;
    if not FileExists(OpenDialog.FileName) then
        Exit;
    memData.Clear();
    memData.Lines.LoadFromFile(OpenDialog.FileName);
    Process();
end;

procedure TfmMain.btnProcessarClick(Sender: TObject);
begin
    Process();
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
    i: Integer;
    str, fmt: string;
    key, value: string;
    sObj: TStringWrapper;
begin
    listFormatos := TStringList.Create();
    if FileExists('coletorformatos.txt') then
        listFormatos.LoadFromFile('coletorformatos.txt');
    try
        cbFormatos.Items.Clear();
        for i := 0 to listFormatos.Count - 1 do
        begin
            key := '';
            value := '';
            str := listFormatos.Strings[i];
            if Pos('=', str) > 0 then
            begin
                key := str.Split(['='])[0];
                value := str.Split(['='])[1];
            end;
            if (key <> '') and (value <> '') then
            begin
                sObj := TStringWrapper.Create();
                sObj.Txt := value;
                cbFormatos.Items.AddObject(key, sObj);
            end;
        end;
    except
        cbFormatos.Items.Clear();
    end;

    OpenDialog.InitialDir := ExtractFilePath(Application.ExeName);
    chkWithHeader.Checked := (ReadCriptoConfig('withheader', 'false', 'coletor.cfg') = 'true');
    edDelim.Text := ReadCriptoConfig('delim', ';', 'coletor.cfg');
    edFormatDateTime.Text := ReadCriptoConfig('formatdatetime', 'DDMMYYYY', 'coletor.cfg');
    cbFormatos.Text := ReadCriptoConfig('formatos', 'Elgin CD1002', 'coletor.cfg');
    edFormato.Text := ReadCriptoConfig('formato', 'CODIGO|TEXTO|13,QTD|NUMERO|8,PRECO|NUMERO|10|3', 'coletor.cfg');
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
    WriteCriptoConfig('withheader', iif(chkWithHeader.Checked, 'true', 'false'), 'coletor.cfg');
    WriteCriptoConfig('delim', edDelim.Text, 'coletor.cfg');
    WriteCriptoConfig('formatdatetime', edFormatDateTime.Text, 'coletor.cfg');
    WriteCriptoConfig('formatos', cbFormatos.Text, 'coletor.cfg');
    ReadCriptoConfig('formato', edFormato.Text, 'coletor.cfg');
    inherited;
end;

end.

