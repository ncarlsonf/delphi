object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Ex02 - Lista com ponteiros'
  ClientHeight = 435
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 311
    Height = 16
    Caption = 'LISTA DUPLAMENTE ENCADEADA COM PONTEIROS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 12
    Top = 416
    Width = 378
    Height = 13
    Caption = 
      '* Treinamento para desenvolvedor Andr'#233' Luiz Rodrigues por Nelson' +
      ' Carlson F.'
  end
  object btnAlimentar: TButton
    Left = 8
    Top = 275
    Width = 173
    Height = 25
    Caption = 'Alimentar / Primeira Carga'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnAlimentarClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 184
    Width = 416
    Height = 85
    Caption = 'Mecanismos de Ordena'#231#227'o'
    TabOrder = 1
    object btnBubbleSortId: TButton
      Left = 8
      Top = 17
      Width = 112
      Height = 25
      Caption = 'BubbleSort Id'
      TabOrder = 0
      OnClick = btnBubbleSortIdClick
    end
    object btnQuickSortTelefone: TButton
      Left = 244
      Top = 48
      Width = 112
      Height = 25
      Caption = 'QuickSort Fone'
      TabOrder = 1
      OnClick = btnQuickSortTelefoneClick
    end
    object btnQuickSortId: TButton
      Left = 8
      Top = 48
      Width = 112
      Height = 25
      Caption = 'QuickSort Id'
      TabOrder = 2
      OnClick = btnQuickSortIdClick
    end
    object btnQuickSortNome: TButton
      Left = 126
      Top = 48
      Width = 112
      Height = 25
      Caption = 'QuickSort Nome'
      TabOrder = 3
      OnClick = btnQuickSortNomeClick
    end
    object btnBubbleSortTelefone: TButton
      Left = 244
      Top = 17
      Width = 112
      Height = 25
      Caption = 'BubbleSort Fone'
      TabOrder = 4
      OnClick = btnBubbleSortTelefoneClick
    end
    object btnBubbleSortNome: TButton
      Left = 126
      Top = 17
      Width = 112
      Height = 25
      Caption = 'BubbleSort Nome'
      TabOrder = 5
      OnClick = btnBubbleSortNomeClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 125
    Width = 416
    Height = 53
    Caption = 'Opera'#231#245'es'
    TabOrder = 2
    object btnAdd: TButton
      Left = 9
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnDel: TButton
      Left = 90
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Remover'
      TabOrder = 1
      OnClick = btnDelClick
    end
    object btnFirst: TButton
      Left = 171
      Top = 16
      Width = 31
      Height = 25
      Caption = '<<'
      TabOrder = 2
      OnClick = btnFirstClick
    end
    object btnPrior: TButton
      Left = 208
      Top = 16
      Width = 31
      Height = 25
      Caption = '<'
      TabOrder = 3
      OnClick = btnPriorClick
    end
    object btnNext: TButton
      Left = 245
      Top = 16
      Width = 31
      Height = 25
      Caption = '>'
      TabOrder = 4
      OnClick = btnNextClick
    end
    object btnLast: TButton
      Left = 282
      Top = 16
      Width = 31
      Height = 25
      Caption = '>>'
      TabOrder = 5
      OnClick = btnLastClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 30
    Width = 416
    Height = 89
    Caption = 'Cadastro:'
    TabOrder = 3
    object Label1: TLabel
      Left = 68
      Top = 17
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object Label2: TLabel
      Left = 211
      Top = 17
      Width = 28
      Height = 13
      Caption = 'Fone:'
    end
    object Label4: TLabel
      Left = 8
      Top = 16
      Width = 10
      Height = 13
      Caption = 'Id'
    end
    object Label5: TLabel
      Left = 354
      Top = 17
      Width = 28
      Height = 13
      Caption = 'Index'
    end
    object lbStatus: TLabel
      Left = 8
      Top = 60
      Width = 79
      Height = 16
      Caption = 'Item: 0 de 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edNome: TEdit
      Left = 68
      Top = 33
      Width = 137
      Height = 21
      TabOrder = 0
    end
    object edFone: TEdit
      Left = 211
      Top = 33
      Width = 137
      Height = 21
      TabOrder = 1
    end
    object edId: TCurrencyEdit
      Left = 8
      Top = 33
      Width = 54
      Height = 21
      DisplayFormat = ',0;,0'
      TabOrder = 2
    end
    object edIndex: TCurrencyEdit
      Left = 354
      Top = 33
      Width = 50
      Height = 21
      DisplayFormat = ',0;,0'
      TabOrder = 3
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 306
    Width = 416
    Height = 105
    Caption = 'Buscas'
    TabOrder = 4
    object Label6: TLabel
      Left = 8
      Top = 24
      Width = 225
      Height = 13
      Caption = 'Nome da pessoa (aceita wildchars %, _ , ?, *):'
    end
    object edPesquisarTexto: TEdit
      Left = 9
      Top = 43
      Width = 395
      Height = 21
      TabOrder = 0
    end
    object btnBusca: TButton
      Left = 282
      Top = 70
      Width = 122
      Height = 25
      Caption = 'Busca'
      TabOrder = 1
      OnClick = btnBuscaClick
    end
  end
end
