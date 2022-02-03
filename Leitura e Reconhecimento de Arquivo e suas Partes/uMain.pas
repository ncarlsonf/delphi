unit uMain;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.StdCtrls;

type
    TfmMain = class(TForm)
        edFileName: TEdit;
        btnSelectFile: TButton;
        lbFileName: TLabel;
        openDialog: TOpenDialog;
        lbFolder: TLabel;
        edFolder: TEdit;
        lbFile: TLabel;
        edFile: TEdit;
        lbExt: TLabel;
        edExt: TEdit;
        lbAbout: TLabel;
        procedure btnSelectFileClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;


var
    fmMain: TfmMain;


implementation

{$R *.dfm}

procedure TfmMain.btnSelectFileClick(Sender: TObject);
var
    f: TextFile;
    b: Char;
    bytes: array[1..6] of Byte;
    i: Integer;
begin
    if openDialog.Execute() and FileExists(openDialog.FileName) then
    begin
        edFileName.Text := openDialog.FileName;
        edFolder.Text := ExtractFilePath(edFileName.Text);
        edFile.Text := ExtractFileName(edFileName.Text);
        edExt.Text := ExtractFileExt(edFileName.Text);

        // checar se o arquivo é um arquivo png pela extensão e pelos bytes
        if (Trim(LowerCase(edExt.Text)) <> '.png') then
        begin
            MessageDlg('Não é um png', mtInformation, [mbOk], 0);
            Exit;
        end;

        AssignFile(f, edFileName.Text);
        Reset(f);
        i := 1;
        while (i <= 6) and (not Eof(f)) do
        begin
            Read(f, b);
            bytes[i] := Byte(b);
            Inc(i);
        end;
        CloseFile(f);

        if not ((bytes[1] = 48)  // ........
            and (bytes[2] = $50) // Ord('P')
            and (bytes[3] = $4e) // Ord('N')
            and (bytes[4] = $47) // Ord('G')
            and (bytes[5] = 13)  // $0d = CR
            and (bytes[6] = 10)) // $0a = LF
            then
        begin
            MessageDlg('Não é um png', mtInformation, [mbOk], 0);
            Exit;
        end;

        MessageDlg('Eureka!!! É um arquivo png!!!', mtInformation, [mbOk], 0);
    end;
end;

end.

