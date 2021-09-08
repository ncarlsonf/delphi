object frmRotacao: TfrmRotacao
  Left = 0
  Top = 0
  Caption = 'Rota'#231#227'o de Bits'
  ClientHeight = 422
  ClientWidth = 493
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
    Left = 8
    Top = 52
    Width = 58
    Height = 13
    Caption = 'Texto Inicial'
  end
  object Label2: TLabel
    Left = 8
    Top = 136
    Width = 81
    Height = 13
    Caption = 'Texto Codificado'
  end
  object Label3: TLabel
    Left = 8
    Top = 180
    Width = 92
    Height = 13
    Caption = 'Texto Decodificado'
  end
  object lbBits: TLabel
    Left = 196
    Top = 20
    Width = 51
    Height = 13
    Caption = 'bits para a'
  end
  object lbDeslocando: TLabel
    Left = 8
    Top = 20
    Width = 55
    Height = 13
    Caption = 'Deslocando'
  end
  object lbColocando: TLabel
    Left = 327
    Top = 20
    Width = 158
    Height = 13
    Caption = 'colocando o restante '#224' esquerda'
  end
  object Label7: TLabel
    Left = 118
    Top = 240
    Width = 113
    Height = 13
    Caption = 'Valor em Byte (0 a 255)'
  end
  object Label8: TLabel
    Left = 244
    Top = 240
    Width = 139
    Height = 13
    Caption = 'Valor bin'#225'rio (tipo 01001001)'
  end
  object Label9: TLabel
    Left = 169
    Top = 374
    Width = 40
    Height = 13
    Caption = 'M'#225'scara'
  end
  object Label10: TLabel
    Left = 304
    Top = 376
    Width = 89
    Height = 13
    Caption = 'Valor com M'#225'scara'
  end
  object Label11: TLabel
    Left = 8
    Top = 96
    Width = 230
    Height = 13
    Caption = 'Chave de Codifica'#231#227'o (para mascarar com XOR)'
  end
  object ed1: TEdit
    Left = 8
    Top = 68
    Width = 397
    Height = 21
    TabOrder = 0
    Text = 'TK2000 Ltda - Itapipoca-CE'
  end
  object ed2: TEdit
    Left = 8
    Top = 152
    Width = 397
    Height = 21
    TabOrder = 1
  end
  object ed3: TEdit
    Left = 8
    Top = 195
    Width = 477
    Height = 21
    TabOrder = 2
  end
  object btnCodificar: TButton
    Left = 411
    Top = 66
    Width = 75
    Height = 25
    Caption = '&Codificar'
    TabOrder = 3
    OnClick = btnCodificarClick
  end
  object btnDecodificar: TButton
    Left = 411
    Top = 150
    Width = 75
    Height = 25
    Caption = 'Decodificar'
    TabOrder = 4
    OnClick = btnDecodificarClick
  end
  object seDeslocamento: TSpinEdit
    Left = 69
    Top = 17
    Width = 121
    Height = 22
    MaxValue = 7
    MinValue = 1
    TabOrder = 5
    Value = 5
  end
  object cbDirecao: TComboBox
    Left = 253
    Top = 17
    Width = 68
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 1
    TabOrder = 6
    Text = 'Direita'
    Items.Strings = (
      'Esquerda'
      'Direita')
  end
  object edByte: TEdit
    Left = 118
    Top = 256
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '127'
    OnExit = edByteExit
    OnKeyPress = edByteKeyPress
  end
  object edBin: TEdit
    Left = 245
    Top = 256
    Width = 121
    Height = 21
    TabOrder = 8
    OnKeyPress = edBinKeyPress
  end
  object btnByteToBin: TButton
    Left = 164
    Top = 283
    Width = 75
    Height = 25
    Caption = 'Bin'#225'rio >>'
    TabOrder = 9
    OnClick = btnByteToBinClick
  end
  object btnBinToByte: TButton
    Left = 245
    Top = 283
    Width = 75
    Height = 25
    Caption = '<< Byte'
    TabOrder = 10
    OnClick = btnBinToByteClick
  end
  object btnInvert: TButton
    Left = 126
    Top = 317
    Width = 75
    Height = 25
    Caption = 'Invers'#227'o'
    TabOrder = 11
    OnClick = btnInvertClick
  end
  object btnRevert: TButton
    Left = 205
    Top = 317
    Width = 75
    Height = 25
    Caption = 'Revers'#227'o'
    TabOrder = 12
    OnClick = btnRevertClick
  end
  object btnFlip: TButton
    Left = 282
    Top = 317
    Width = 75
    Height = 25
    Caption = 'Flip'
    TabOrder = 13
    OnClick = btnFlipClick
  end
  object edByte2: TEdit
    Left = 118
    Top = 348
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 14
  end
  object edBin2: TEdit
    Left = 245
    Top = 347
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 15
  end
  object Button1: TButton
    Left = 88
    Top = 392
    Width = 75
    Height = 25
    Caption = 'Mascarar'
    TabOrder = 16
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 224
    Top = 390
    Width = 75
    Height = 25
    Caption = 'Desmascarar'
    TabOrder = 17
    OnClick = Button2Click
  end
  object seMascara: TSpinEdit
    Left = 169
    Top = 392
    Width = 49
    Height = 22
    MaxValue = 255
    MinValue = 1
    TabOrder = 18
    Value = 255
  end
  object edWithMask: TEdit
    Left = 305
    Top = 392
    Width = 121
    Height = 21
    TabOrder = 19
    OnExit = edWithMaskExit
    OnKeyPress = edWithMaskKeyPress
  end
  object edKey: TEdit
    Left = 8
    Top = 111
    Width = 477
    Height = 21
    TabOrder = 20
    Text = 'Umafrasequalquerparausarcomochave'
  end
end
