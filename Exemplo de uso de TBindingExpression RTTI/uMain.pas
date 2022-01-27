unit uMain;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.StdCtrls, System.Bindings.Expression, System.Bindings.ExpressionDefaults,
    Vcl.ExtCtrls, System.Math;

type
    TfmMain = class(TForm)
        MemoExpr: TMemo;
        MemoOut: TMemo;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Panel1: TPanel;
        Button1: TButton;
        Splitter1: TSplitter;
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
    TkHelpers, System.Generics.Collections;

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

    TVariable = class(TObject)
        Name: String;
        Value: String;
    end;

    TMethods = class
    private
        FValues: TList<Extended>;
        FVariables: TList<TVariable>;
        procedure FSetValues(values: TList<Extended>);
        function FGetValues(): TList<Extended>;
        procedure FSetVariables(variables: TList<TVariable>);
        function FGetVariables(): TList<TVariable>;
    public
        constructor Create();
        destructor Destroy();

        function VTrue(): Boolean;
        function VFalse(): Boolean;
        function ToStr(i: Double): String;
        function ToFloat(i: String): Extended;
        function GetRandom(): Double; overload;
        function GetRandom(seed: Int64; divBy: Int64): Double; overload;
        function GetRandom(seed: Int64): Double; overload;
        function Power(num, pow: Extended): Extended;
        function Sqrt(num: Extended): Extended;
        function Sum(values: String): Extended;
        function Max(values: String): Extended;
        function Min(values: String): Extended;
        function Avg(values: String): Extended;
        function Round(num: Extended; digits: Integer): Extended;
        function Summation(numBegin, numEnd, Step: Extended): Extended;
        function AddVar(name: String; value: String): String;

        function Erase(): String;
        function Notepad(): String;
        function IIf(expr: Boolean; a, b: Variant): String;
        function ValuesToString(): String;
        property Values: TList<Extended> read FGetValues write FSetValues;
        property Variables: TList<TVariable> read FGetVariables write FSetVariables;
    end;

var
    sOut: String;
    person: TPerson;
    methods: TMethods;
    vTrue, vFalse: Boolean;

procedure TfmMain.FormCreate(Sender: TObject);
begin
    person := TPerson.Create();
    person.Name := 'Nelson';
    person.Age := 42;

    methods := TMethods.Create();
    methods.Values.Add(1);
    methods.Values.Add(2);
    methods.Values.Add(3);
end;

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

constructor TMethods.Create();
begin
    FValues := TList<Extended>.Create();
    FVariables := TList<TVariable>.Create();
end;

destructor TMethods.Destroy();
begin
    FValues.Free();
    FVariables.Free();
end;

function TMethods.ToStr(i: Double): String;
begin
    Result := FloatToStr(i);
end;

function TMethods.ToFloat(i: String): Extended;
begin
    Result := StrToFloat(i);
end;

function TMethods.GetRandom(seed: Int64; divBy: Int64): Double;
begin
    if divBy > 0 then
        Result := Random(seed) / divBy
    else
        Result := Random(seed);
end;

function TMethods.GetRandom(seed: Int64): Double;
begin
    Result := GetRandom(seed, 10000);
end;

function TMethods.GetRandom(): Double;
begin
    Result := GetRandom(1000000000, 10000);
end;

function TMethods.Power(num, pow: Extended): Extended;
begin
    Result := System.Math.Power(num, pow);
end;

function TMethods.Sqrt(num: Extended): Extended;
begin
    Result :=System.Sqrt(num);
end;

function TMethods.Sum(values: String): Extended;
var
    aStr: TArray<String>;
    i: Integer;
begin
    Result := 0;
    aStr := values.Split([',']);
    for i := Low(aStr) to High(aStr) do
    begin
        Result := Result + StrToFloat(StringReplace(aStr[i], '.', ',', [rfReplaceAll]));
    end;
end;

function TMethods.Max(values: String): Extended;
var
    aStr: TArray<String>;
    i: Integer;
    num: Extended;
begin
    Result := Extended.MinValue;
    aStr := values.Split([',']);
    for i := Low(aStr) to High(aStr) do
    begin
        num := StrToFloat(StringReplace(aStr[i], '.', ',', [rfReplaceAll]));
        if num > Result then
            Result := num;
    end;
end;

function TMethods.Min(values: String): Extended;
var
    aStr: TArray<String>;
    i: Integer;
    num: Extended;
begin
    Result := Extended.MaxValue;
    aStr := values.Split([',']);
    for i := Low(aStr) to High(aStr) do
    begin
        num := StrToFloat(StringReplace(aStr[i], '.', ',', [rfReplaceAll]));
        if num < Result then
            Result := num;
    end;
end;

function TMethods.Avg(values: String): Extended;
var
    aStr: TArray<String>;
    i: Integer;
begin
    Result := 0;
    aStr := values.Split([',']);
    if Length(aStr) = 0 then
        Exit;
    for i := Low(aStr) to High(aStr) do
    begin
        Result := Result + StrToFloat(StringReplace(aStr[i], '.', ',', [rfReplaceAll]));
    end;
    Result := Result / Length(aStr);
end;

function TMethods.Erase(): String;
begin
    fmMain.MemoOut.Text := '';
    sOut := '';
    Result := '';
end;

function TMethods.Round(num: Extended; digits: Integer): Extended;
begin
    digits := digits * -1;
    Result := RoundTo(num, digits);
end;

function TMethods.Summation(numBegin, numEnd, step: Extended): Extended;
var
    i, num: Extended;
begin
    Result := 0;
    if step <= 0 then
        step := 1;
    num := 0;
    i := numBegin;
    while i <= numEnd do
    begin
        Result := Result + i;
        i := i + step;
    end;
end;

function TMethods.AddVar(name: String; value: String): String;
var
    i: Integer;
    exists: Boolean;
    v: TVariable;
begin
    Result := '';
    name := Trim(name);
    if Length(name) < 3 then
        Exit;

    if not(name.StartsWith('$') and name.EndsWith('$')) then
        Exit;

    exists := False;
    for i := 0 to Variables.Count - 1 do
    begin
        if Trim(LowerCase( Variables.Items[i].Name )) = Trim(LowerCase(name)) then
        begin
            exists := True;
            Exit;
        end;
    end;
    v := TVariable.Create();
    v.Name := name;
    v.Value := value;
    Variables.Add(v);
end;

procedure TMethods.FSetValues(values: TList<Extended>);
begin
    FValues := values;
end;

function TMethods.FGetValues(): TList<Extended>;
begin
    Result := FValues;
end;

procedure TMethods.FSetVariables(variables: TList<TVariable>);
begin
    FVariables := variables;
end;

function TMethods.FGetVariables(): TList<TVariable>;
begin
    Result := FVariables;
end;

function TMethods.Notepad(): String;
begin
    Result := '';
    TkHelpers.NotePad(sOut, True);
end;

function TMethods.IIf(expr: Boolean; a, b: Variant): String;
begin
    if expr then
        Result := VarAsString(a)
    else
        Result := VarAsString(b);
end;

function TMethods.ValuesToString(): String;
var
    i: Integer;
begin
    Result := '';
    for i := 0 to FValues.Count - 1 do
    begin
        if Result <> '' then
            Result := Result + ',';
        Result := Result + StringReplace(FloatToStr(FValues.Items[i]), ',', '.', [rfReplaceAll]);
    end;
end;

function TMethods.VTrue(): Boolean;
begin
    Result := True;
end;

function TMethods.VFalse(): Boolean;
begin
    Result := False;
end;

function UpdFuncPart(expr, exprOri, exprSubst: String): String;
begin
    expr := ' ' + expr + ' ';
    expr := StringReplace(expr, '(' + exprOri + '(', '(' + exprSubst + '(', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ' ' + exprOri + '(', ' ' + exprSubst + '(', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '+' + exprOri + '(', '+' + exprSubst + '(', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '-' + exprOri + '(', '-' + exprSubst + '(', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '*' + exprOri + '(', '*' + exprSubst + '(', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '/' + exprOri + '(', '/' + exprSubst + '(', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '=' + exprOri + '(', '=' + exprSubst + '(', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '<' + exprOri + '(', '<' + exprSubst + '(', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '>' + exprOri + '(', '>' + exprSubst + '(', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '^' + exprOri + '(', '^' + exprSubst + '(', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ',' + exprOri + '(', ',' + exprSubst + '(', [rfReplaceAll, rfIgnoreCase]);
    Result := expr;
end;

function UpdBoolParts(expr: String): String;
begin
    expr := ' ' + expr + ' ';
    expr := StringReplace(expr, '(true)', 'fn.VTrue()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '(true ', 'fn.VTrue()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ' true)', 'fn.VTrue()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '(true=', 'fn.VTrue()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '=true)', 'fn.VTrue()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ' true=', 'fn.VTrue()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '=true ', 'fn.VTrue()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ' true ', 'fn.VTrue()', [rfReplaceAll, rfIgnoreCase]);

    expr := StringReplace(expr, '(true,', '(fn.VTrue(),', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ',true)', ',fn.VTrue())', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ' true,', ' fn.VTrue(),', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ',true ', ',fn.VTrue() ', [rfReplaceAll, rfIgnoreCase]);


    expr := StringReplace(expr, '(false)', 'fn.VFalse()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '(false ', 'fn.VFalse()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ' false)', 'fn.VFalse()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '(false=', 'fn.VFalse()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '=false)', 'fn.VFalse()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ' false=', 'fn.VFalse()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, '=false ', 'fn.VFalse()', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ' false ', 'fn.VFalse()', [rfReplaceAll, rfIgnoreCase]);

    expr := StringReplace(expr, '(false,', '(fn.VFalse(),', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ',false)', ',fn.VFalse())', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ' false,', ' fn.VFalse(),', [rfReplaceAll, rfIgnoreCase]);
    expr := StringReplace(expr, ',false ', ',fn.VFalse() ', [rfReplaceAll, rfIgnoreCase]);

    Result := expr;
end;

procedure TfmMain.Button1Click(Sender: TObject);
var
    bindExpr: TBindingExpression;
    i, idx, p: Integer;
    s: String;
    dict: TBindExprDict;
    expr, expr2: String;
begin
    try
        bindExpr := TBindingExpressionDefault.Create;
        dict := TBindExprDict.Create('default');
        sOut := '';
        for i := 0 to MemoExpr.Lines.Count - 1 do
        begin
            if Trim(MemoExpr.Lines.Strings[i]) <> '' then
            begin
                expr := MemoExpr.Lines.Strings[i];
                expr := UpdBoolParts(expr);
                expr := UpdFuncPart(expr, 'erase', 'fn.Erase');
                expr := UpdFuncPart(expr, 'notepad', 'fn.Notepad');
                expr := UpdFuncPart(expr, 'iif', 'fn.IIf');
                expr := UpdFuncPart(expr, 'power', 'fn.Power');
                expr := UpdFuncPart(expr, 'sqrt', 'fn.Sqrt');
                expr := UpdFuncPart(expr, 'sum', 'fn.Sum');
                expr := UpdFuncPart(expr, 'avg', 'fn.Avg');
                expr := UpdFuncPart(expr, 'min', 'fn.Min');
                expr := UpdFuncPart(expr, 'max', 'fn.Max');
                expr := UpdFuncPart(expr, 'round', 'fn.Round');
                expr := UpdFuncPart(expr, 'summation', 'fn.Summation');
                expr := UpdFuncPart(expr, 'tofloat', 'fn.ToFloat');
                expr := UpdFuncPart(expr, 'fn.Values.ToString', 'fn.ValuesToString');
                expr := UpdFuncPart(expr, 'fn.Values.ToArray', 'fn.ValuesToString');
                expr := UpdFuncPart(expr, 'addvar', 'fn.AddVar');

                for idx := 0 to methods.Variables.Count - 1 do
                begin
                    expr := StringReplace(expr, methods.Variables.Items[idx].Name, '"' + StringReplace(methods.Variables.Items[idx].Value, '"', '"+"', [rfReplaceAll]) + '"', [rfReplaceAll]);
                end;

                expr2 := StringReplace(expr, '[', '"', [rfReplaceAll]);
                expr2 := StringReplace(expr2, ']', '"', [rfReplaceAll]);
                try
                    bindExpr.Source := expr;
                    bindExpr.Compile([
                        TBindingAssociation.Create(person, 'person'),
                        TBindingAssociation.Create(methods, 'fn')
                    ]);
                    s := bindExpr.Evaluate.GetValue.ToString();
                except
                    on e: Exception do
                    begin
                        bindExpr.Source := expr2;
                        bindExpr.Compile([
                            TBindingAssociation.Create(person, 'person'),
                            TBindingAssociation.Create(methods, 'fn')
                        ]);
                        s := bindExpr.Evaluate.GetValue.ToString();
                    end;
                end;
                if Trim(s) <> '' then
                    sOut := sOut + s + #13#10;
            end;
        end;
        MemoOut.Lines.Add(sOut);
    finally
        bindExpr.Free;
        dict.Free();
    end;
end;

end.

