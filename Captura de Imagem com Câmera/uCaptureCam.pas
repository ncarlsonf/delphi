unit uCaptureCam;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
    cxEdit, TkButtonCore, TkButtonObject, cxImage, dxCameraControl, jpeg,
    Vcl.ComCtrls;

type
    TfrmCaptureCam = class(TForm)
        dxCameraControl1: TdxCameraControl;
        cxImage1: TcxImage;
        btnAtivar: TTkButton;
        btnCapturar: TTkButton;
        TkButton1: TTkButton;
        status: TStatusBar;
        procedure btnAtivarClick(Sender: TObject);
        procedure btnCapturarClick(Sender: TObject);
        procedure TkButton1Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    frmCaptureCam: TfrmCaptureCam;

implementation

{$R *.dfm}

procedure TfrmCaptureCam.btnAtivarClick(Sender: TObject);
begin
    dxCameraControl1.Active := not dxCameraControl1.Active;
    if dxCameraControl1.Active then
    begin
        btnCapturar.Enabled := True;
        btnAtivar.Caption := '&Desativar';
        btnAtivar.Colors.BorderLine := clGreen;
        status.SimpleText := 'Câmera ativada!';
    end
    else
    begin
        btnCapturar.Enabled := False;
        btnAtivar.Caption := '&Ativar';
        btnAtivar.Colors.BorderLine := clMaroon;
        status.SimpleText := 'Câmera desativada...';
    end;
end;

procedure TfrmCaptureCam.btnCapturarClick(Sender: TObject);
var
    img: TJPEGImage;
begin
    if not dxCameraControl1.Active then
        Exit;

    if Trim(dxCameraControl1.DeviceName) = '' then
    begin
        MessageDlg('Câmera não detectada.', mtWarning, [mbOk], 0);
        Exit;
    end;

    dxCameraControl1.Capture();
    cxImage1.Picture.Assign(dxCameraControl1.CapturedBitmap);

    if FileExists('foto.jpg') then
        DeleteFile('foto.jpg');

    try
        img := TJPEGImage.Create();
        img.Assign(cxImage1.Picture.Bitmap);
        img.CompressionQuality := 80; // representa 80% do tamanho do arquivo
        img.SaveToFile('foto.jpg');
    finally
        FreeAndNil(img);
    end;

    status.SimpleText := 'Imagem salva em "foto.jpg"';
end;

procedure TfrmCaptureCam.TkButton1Click(Sender: TObject);
begin
    Self.Close();
end;

end.

