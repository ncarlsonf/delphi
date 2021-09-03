program RotacaoDeBits;

uses
  Vcl.Forms,
  uRotacao in 'uRotacao.pas' {frmRotacao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmRotacao, frmRotacao);
  Application.Run;
end.
