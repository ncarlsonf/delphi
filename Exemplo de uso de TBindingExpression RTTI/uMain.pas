unit uMain;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.StdCtrls, System.Bindings.Expression, System.Bindings.ExpressionDefaults;

type
    TfmMain = class(TForm)
        MemoExpr: TMemo;
        MemoOut: TMemo;
        Label1: TLabel;
        Label2: TLabel;
        Button1: TButton;
    Label3: TLabel;
        procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    fmMain: TfmMain;

implementation

{$R *.dfm}

uses
    TkHelpers;

type
    TPerson = class
    private
        FName: String;
        FAge: Integer;
        procedure FSetName(name: String);
        procedure FSetAge(age: Integer);
    public
        function SetName(name: String): String;
        function SetAge(age: Integer): String;
        property Name: string read FName write FSetName;
        property Age: Integer read FAge write FSetAge;
    end;

    TMyFunct = class
    public
        function ToStr(i: Double): String;
        function Erase(): String;
        function Notepad(): String;
    end;

var
    sOut: String;
    person: TPerson;
    myFunct: TMyFunct;

procedure TPerson.FSetName(name: String);
begin
    FName := name;
end;

procedure TPerson.FSetAge(age: Integer);
begin
    FAge := age;
end;

function TPerson.SetName(name: String): String;
begin
    Result := '';
    FName := name;
end;

function TPerson.SetAge(age: Integer): String;
begin
    Result := '';
    FAge := age;
end;

function TMyFunct.ToStr(i: Double): String;
begin
    Result := FloatToStr(i);
end;


function TMyFunct.Erase(): String;
begin
    fmMain.MemoOut.Text := '';
    sOut := '';
    Result := '';
end;

function TMyFunct.Notepad(): String;
begin
    Result := '';
    TkHelpers.NotePad(sOut, True);
end;

procedure TfmMain.Button1Click(Sender: TObject);
var
    bindExpr: TBindingExpression;
    i: Integer;
    s: String;
begin
    try
        bindExpr := TBindingExpressionDefault.Create;
        sOut := '';
        for i := 0 to MemoExpr.Lines.Count - 1 do
        begin
            if Trim(MemoExpr.Lines.Strings[i]) <> '' then
            begin
                bindExpr.Source := MemoExpr.Lines.Strings[i];
                bindExpr.Compile([
                    TBindingAssociation.Create(person, 'person'),
                    TBindingAssociation.Create(myFunct, 'fn')
                ]);
                s := bindExpr.Evaluate.GetValue.ToString();
                if Trim(s) <> '' then
                    sOut := sOut + s + #13#10;
            end;
        end;
        MemoOut.Lines.Add(sOut);
    finally
        bindExpr.Free;
    end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
    person := TPerson.Create();
    person.Name := 'Nelson';
    person.Age := 42;

    myFunct := TMyFunct.Create();
end;

end.

