unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, RxToolEdit,
  RxCurrEdit;

type
  TfmMain = class(TForm)
    edIn: TCurrencyEdit;
    edOut: TCurrencyEdit;
    btnSomatorio: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnSomatorioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

function Somatorio(n: Integer): Integer;
begin
    if (n > 1) then
        Result := n + Somatorio(n - 1)
    else
        Result := n;
end;


procedure TfmMain.btnSomatorioClick(Sender: TObject);
begin
    edOut.Value := Somatorio(Trunc(edIn.Value));
end;

end.
