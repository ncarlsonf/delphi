object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Leitura e Reconhecimento de Arquivo e suas Partes'
  ClientHeight = 158
  ClientWidth = 432
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
  object lbFileName: TLabel
    Left = 8
    Top = 8
    Width = 86
    Height = 13
    Caption = 'Nome do Arquivo:'
  end
  object lbFolder: TLabel
    Left = 8
    Top = 53
    Width = 86
    Height = 13
    Caption = 'Pasta do Arquivo:'
  end
  object lbFile: TLabel
    Left = 8
    Top = 97
    Width = 86
    Height = 13
    Caption = 'Nome do Arquivo:'
  end
  object lbExt: TLabel
    Left = 339
    Top = 97
    Width = 76
    Height = 13
    Caption = 'Ext.do Arquivo:'
  end
  object lbAbout: TLabel
    Left = 140
    Top = 143
    Width = 161
    Height = 11
    Caption = 'An example by Nelson-Wan Kenobi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object edFileName: TEdit
    Left = 8
    Top = 24
    Width = 345
    Height = 21
    TabOrder = 0
  end
  object btnSelectFile: TButton
    Left = 359
    Top = 22
    Width = 66
    Height = 25
    Caption = 'Selecionar'
    TabOrder = 1
    OnClick = btnSelectFileClick
  end
  object edFolder: TEdit
    Left = 8
    Top = 68
    Width = 417
    Height = 21
    TabOrder = 2
  end
  object edFile: TEdit
    Left = 8
    Top = 112
    Width = 325
    Height = 21
    TabOrder = 3
  end
  object edExt: TEdit
    Left = 339
    Top = 112
    Width = 86
    Height = 21
    TabOrder = 4
  end
  object openDialog: TOpenDialog
    Left = 228
    Top = 12
  end
end
