object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Uso de TList'
  ClientHeight = 406
  ClientWidth = 476
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
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 457
    Height = 353
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 392
    Top = 372
    Width = 75
    Height = 25
    Caption = '&Fechar'
    TabOrder = 1
    OnClick = Button1Click
  end
end
