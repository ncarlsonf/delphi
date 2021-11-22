object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Snake 1.0 - 08.01.2020'
  ClientHeight = 255
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object img: TImage
    Left = 4
    Top = 8
    Width = 302
    Height = 202
  end
  object lbRestart: TLabel
    Left = 4
    Top = 216
    Width = 101
    Height = 13
    Caption = '[F3] para reiniciar'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 153
    Top = 216
    Width = 153
    Height = 13
    Caption = 'Developed by Nelson Carlson F.'
  end
  object lbPerdeu: TLabel
    Left = 56
    Top = 96
    Width = 211
    Height = 19
    Caption = 'VC PERDEU SEU TROUXA!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbPausado: TLabel
    Left = 120
    Top = 96
    Width = 81
    Height = 19
    Caption = 'PAUSADO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object sb: TStatusBar
    Left = 0
    Top = 236
    Width = 310
    Height = 19
    Panels = <
      item
        Text = 'Pontos:'
        Width = 45
      end
      item
        Text = '0'
        Width = 50
      end
      item
        Text = 'Velocidade:'
        Width = 66
      end
      item
        Text = '1'
        Width = 30
      end
      item
        Text = 'Tamanho:'
        Width = 60
      end
      item
        Text = '1'
        Width = 50
      end>
  end
  object tm: TTimer
    Enabled = False
    Interval = 200
    OnTimer = tmTimer
    Left = 192
    Top = 108
  end
end
