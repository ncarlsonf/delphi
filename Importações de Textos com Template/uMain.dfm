object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Importa'#231#227'o de Textos'
  ClientHeight = 418
  ClientWidth = 736
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbRegistrosLidos: TLabel
    Left = 407
    Top = 380
    Width = 85
    Height = 13
    Caption = 'Registros Lidos: 0'
  end
  object memData: TMemo
    Left = 8
    Top = 209
    Width = 393
    Height = 169
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object grid: TDBGrid
    Left = 407
    Top = 8
    Width = 320
    Height = 370
    DataSource = ds
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnLerEProcessar: TButton
    Left = 184
    Top = 384
    Width = 139
    Height = 25
    Caption = 'Ler Arquivo e Processar'
    TabOrder = 2
    OnClick = btnLerEProcessarClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 393
    Height = 195
    Caption = 'Formato do Arquivo de Texto do Coletor'
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 31
      Width = 107
      Height = 13
      Hint = 
        'Caractere delimitador (caractere como ";", ou escape "\", como \' +
        't de tabula'#231#227'o, ou ascii com "#", como #59 que '#233' ;)'
      Caption = 'Caractere delimitador:'
      ParentShowHint = False
      ShowHint = True
      WordWrap = True
    end
    object Label5: TLabel
      Left = 8
      Top = 71
      Width = 97
      Height = 13
      Caption = 'Formato Data/Hora:'
    end
    object Label2: TLabel
      Left = 8
      Top = 150
      Width = 135
      Height = 13
      Caption = 'Formato da Linha de Dados:'
    end
    object Label3: TLabel
      Left = 144
      Top = 31
      Width = 92
      Height = 13
      Caption = 'Separador decimal:'
    end
    object Label4: TLabel
      Left = 8
      Top = 108
      Width = 181
      Height = 13
      Caption = 'Formatos por Modelo do Equipamento'
    end
    object chkWithHeader: TCheckBox
      Left = 12
      Top = 13
      Width = 189
      Height = 17
      Caption = 'A primeira linha '#233' um cabe'#231'alho'
      TabOrder = 0
    end
    object edDelim: TEdit
      Left = 8
      Top = 47
      Width = 45
      Height = 21
      TabOrder = 1
      Text = '#32'
    end
    object edFormatDateTime: TEdit
      Left = 8
      Top = 85
      Width = 97
      Height = 21
      Hint = 
        'Formatos de Data/Hora'#13#10#13#10'd: dia com 1 ou 2 caracteres'#13#10'dd: dia c' +
        'om 2 caracteres'#13#10'm: m'#234's com 1 ou 2 caracteres'#13#10'mm: m'#234's com 2 car' +
        'acteres'#13#10'yy: ano com 2 caracteres'#13#10'yyyy: ano com 4 caracteres'#13#10'h' +
        'h: hora '#13#10'nn: minutos'#13#10'ss: segundos'#13#10
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = 'DDMMYYYY'
    end
    object edFormato: TEdit
      Left = 8
      Top = 164
      Width = 373
      Height = 19
      Hint = 
        'Utilize os campos CODIGO, QTD e PRECO, no formato CAMPO|TIPO|TAM' +
        'ANHO|DECIMAIS.  Os tipos v'#225'lidos s'#227'o TEXTO e NUMERO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = 'CODIGO|TEXTO|13,QTD|NUMERO|8'
    end
    object cbSepNum: TComboBox
      Left = 144
      Top = 47
      Width = 41
      Height = 22
      Style = csOwnerDrawFixed
      ItemIndex = 1
      TabOrder = 4
      Text = '.'
      Items.Strings = (
        ','
        '.')
    end
    object cbFormatos: TComboBox
      Left = 8
      Top = 122
      Width = 228
      Height = 22
      Style = csOwnerDrawFixed
      TabOrder = 5
      Items.Strings = (
        'Elgin CD1002'
        'Bematech AT203')
    end
    object btnAplicar: TButton
      Left = 240
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Aplicar'
      TabOrder = 6
      OnClick = btnAplicarClick
    end
  end
  object btnLer: TButton
    Left = 12
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Ler Arquivo'
    TabOrder = 4
    OnClick = btnLerClick
  end
  object btnProcessar: TButton
    Left = 100
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Processar'
    TabOrder = 5
    OnClick = btnProcessarClick
  end
  object ds: TDataSource
    DataSet = tb
    Left = 472
    Top = 16
  end
  object tb: TJvMemoryData
    Active = True
    FieldDefs = <
      item
        Name = 'CODIGO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PRECO'
        DataType = ftFloat
      end
      item
        Name = 'QTD'
        DataType = ftFloat
      end>
    Left = 432
    Top = 16
    object tbCODIGO: TStringField
      FieldName = 'CODIGO'
    end
    object tbPRECO: TFloatField
      FieldName = 'PRECO'
    end
    object tbQTD: TFloatField
      FieldName = 'QTD'
    end
  end
  object opendialog: TOpenTextFileDialog
    Left = 504
    Top = 380
  end
end
