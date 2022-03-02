object frmCaptureCam: TfrmCaptureCam
  Left = 0
  Top = 0
  Caption = 'Capturar Foto'
  ClientHeight = 210
  ClientWidth = 411
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
  object dxCameraControl1: TdxCameraControl
    Left = 4
    Top = 4
    Width = 200
    Height = 150
  end
  object cxImage1: TcxImage
    Left = 206
    Top = 4
    TabOrder = 1
    Height = 150
    Width = 200
  end
  object btnAtivar: TTkButton
    Left = 88
    Top = 160
    About = 
      'Tk2000 '#169', 2021 (a partir da paleta Design eXperience de M. Hoffm' +
      'ann 2002)'
    Version = '2.0'
    OnClick = btnAtivarClick
    Caption = '&Ativar'
    Colors.BorderLine = clMaroon
    TabOrder = 2
    Visible = True
    Interval = 100
  end
  object btnCapturar: TTkButton
    Left = 167
    Top = 160
    About = 
      'Tk2000 '#169', 2021 (a partir da paleta Design eXperience de M. Hoffm' +
      'ann 2002)'
    Enabled = False
    Version = '2.0'
    OnClick = btnCapturarClick
    Caption = '&Capturar'
    TabOrder = 3
    Visible = True
    Interval = 100
  end
  object TkButton1: TTkButton
    Left = 246
    Top = 160
    About = 
      'Tk2000 '#169', 2021 (a partir da paleta Design eXperience de M. Hoffm' +
      'ann 2002)'
    Version = '2.0'
    OnClick = TkButton1Click
    Caption = '&Fechar'
    TabOrder = 4
    Visible = True
    Interval = 100
  end
  object status: TStatusBar
    Left = 0
    Top = 191
    Width = 411
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 'C'#226'mera desativada...'
  end
end
