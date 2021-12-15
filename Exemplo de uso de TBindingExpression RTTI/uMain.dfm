object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Exemplo de uso de TBindingExpression / RTTI'
  ClientHeight = 429
  ClientWidth = 916
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 54
    Height = 13
    Caption = 'Express'#227'o:'
  end
  object Label2: TLabel
    Left = 8
    Top = 211
    Width = 30
    Height = 13
    Caption = 'Sa'#237'da:'
  end
  object Label3: TLabel
    Left = 8
    Top = 400
    Width = 617
    Height = 13
    Caption = 
      'O uso de TBindingExpression no c'#243'digo abre a possibilidade de in' +
      'ferir transforma'#231#245'es e modificar c'#225'lculos em tempo de execu'#231#227'o'
  end
  object MemoExpr: TMemo
    Left = 8
    Top = 20
    Width = 893
    Height = 169
    Lines.Strings = (
      'fn.Erase()'
      
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
        '" anos de idade."')
    TabOrder = 0
    WordWrap = False
  end
  object MemoOut: TMemo
    Left = 8
    Top = 226
    Width = 893
    Height = 169
    TabOrder = 1
  end
  object Button1: TButton
    Left = 420
    Top = 195
    Width = 75
    Height = 25
    Caption = 'Avaliar'
    TabOrder = 2
    OnClick = Button1Click
  end
end
