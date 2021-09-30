object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Somat'#243'rio'
  ClientHeight = 187
  ClientWidth = 206
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 36
    Top = 12
    Width = 104
    Height = 13
    Caption = 'Valor para Somat'#243'rio:'
  end
  object Label2: TLabel
    Left = 36
    Top = 97
    Width = 52
    Height = 13
    Caption = 'Resultado:'
  end
  object Label3: TLabel
    Left = 16
    Top = 144
    Width = 178
    Height = 13
    Caption = 'Somat'#243'rio de 4 = 4 + 3 + 2 + 1 = 10'
  end
  object edIn: TCurrencyEdit
    Left = 36
    Top = 28
    Width = 121
    Height = 21
    DisplayFormat = ',0;-,0'
    TabOrder = 0
  end
  object edOut: TCurrencyEdit
    Left = 36
    Top = 112
    Width = 121
    Height = 21
    DisplayFormat = ',0;-,0'
    TabOrder = 1
  end
  object btnSomatorio: TButton
    Left = 82
    Top = 66
    Width = 75
    Height = 25
    Caption = 'Somat'#243'rio'
    TabOrder = 2
    OnClick = btnSomatorioClick
  end
end
