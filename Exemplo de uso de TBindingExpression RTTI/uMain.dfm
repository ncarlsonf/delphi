object fmMain: TfmMain
  Left = 0
  Top = 0
  BorderWidth = 5
  Caption = 'Exemplo de uso de TBindingExpression / RTTI'
  ClientHeight = 560
  ClientWidth = 906
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 906
    Height = 17
    Align = alTop
    Caption = 'Express'#227'o:'
    ExplicitWidth = 63
  end
  object Label2: TLabel
    Left = 0
    Top = 303
    Width = 906
    Height = 17
    Align = alBottom
    Caption = 'Sa'#237'da:'
    ExplicitTop = 373
    ExplicitWidth = 35
  end
  object Label3: TLabel
    Left = 0
    Top = 543
    Width = 906
    Height = 17
    Align = alBottom
    Caption = 
      'O uso de TBindingExpression no c'#243'digo abre a possibilidade de in' +
      'ferir transforma'#231#245'es e modificar c'#225'lculos em tempo de execu'#231#227'o'
    ExplicitWidth = 772
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 262
    Width = 906
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 17
    ExplicitWidth = 247
  end
  object MemoExpr: TMemo
    Left = 0
    Top = 17
    Width = 906
    Height = 245
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Lucida Console'
    Font.Style = []
    Lines.Strings = (
      'fn.Variables.Clear()'
      'fn.Erase()'
      'AddVar("$empresa$", "TK2000")'
      'AddVar("$diretor$", "Vilmar Teixeira")'
      'AddVar("$desenvolvedor$", "Nelson Carlson F.")'
      'AddVar("$ano$", "2021")'
      
        '"Nossa empresa '#233' a" + $empresa$ + ". Nosso diretor '#233' o " + $dire' +
        'tor$ + ". Um de nossos desenvolvedores '#233' o " + $desenvolvedor$'
      '"O pr'#243'ximo ano ser'#225' o de " + (ToFloat($ano$) + 1)'
      ''
      
        '"Hello world! Hello world! Hello world! Al'#244' mundo! Al'#244' mundo! Al' +
        #244' mundo!!!!!"'
      '7.678 * 2 / 2.5 + 1 + " Hello world! "'
      
        'person.Name + " tem " + fn.ToStr(person.Age) + " anos. O dobro d' +
        'e sua idade '#233' " + fn.ToStr(person.Age * 2) + " anos."'
      '"Exemplo de Resultado de Express'#227'o: " + fn.ToStr(3 * (2 + 4.5))'
      'person.SetName("Andr'#233'")'
      'person.SetAge(32)'
      
        'person.Name + " tem " + fn.ToStr(person.Age) + " anos. O dobro d' +
        'a idade de " + person.Name + " '#233' " + fn.ToStr(person.Age * 2) + ' +
        '" anos de idade."'
      'fn.GetRandom() / 14 + 1 + " Hello!"'
      'fn.Sum([1.3, 4.2, 7]) + 2'
      'fn.Avg([9.5, 2, 9.5])'
      'fn.Round(1500/7, 2)'
      'fn.Values.Clear()'
      'fn.Values.Add(4)'
      'fn.Values.Add(2)'
      'fn.Values.Add(5)'
      'fn.Values.Items[2]'
      'Sum(fn.Values.ToArray())'
      ''
      '')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    ExplicitTop = 101
    ExplicitHeight = 315
  end
  object MemoOut: TMemo
    Left = 0
    Top = 320
    Width = 906
    Height = 223
    Align = alBottom
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 265
    Width = 906
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 335
    object Button1: TButton
      Left = 0
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Avaliar'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
