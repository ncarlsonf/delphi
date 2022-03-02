program CaptureCam;

uses
  Vcl.Forms,
  uCaptureCam in 'uCaptureCam.pas' {frmCaptureCam};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCaptureCam, frmCaptureCam);
  Application.Run;
end.
