object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 
    'Ex.0001 - Estrutura de ponteiros utilizando fila encadeada de bu' +
    'sca unidirecional'
  ClientHeight = 80
  ClientWidth = 579
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
  object lbId: TLabel
    Left = 8
    Top = 4
    Width = 10
    Height = 13
    Caption = 'Id'
  end
  object lbNome: TLabel
    Left = 72
    Top = 4
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object edId: TCurrencyEdit
    Left = 8
    Top = 20
    Width = 57
    Height = 21
    DisplayFormat = ',0;-,0'
    TabOrder = 0
  end
  object edNome: TEdit
    Left = 71
    Top = 20
    Width = 294
    Height = 21
    TabOrder = 1
  end
  object btnSalvar: TButton
    Left = 8
    Top = 47
    Width = 75
    Height = 25
    Hint = 
      'Efetua o salvamento dos dados informados.  Se o id for -1 cria u' +
      'm dado novo, se o Id for maior que -1 ir'#225' buscar se o dado exist' +
      'e e altar'#225'-lo, mas se n'#227'o existir ir'#225' criar um dado novo.'
    Caption = '&Salvar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object btnPrimeiro: TButton
    Left = 170
    Top = 47
    Width = 75
    Height = 25
    Hint = 'Vai para o primeiro dado'
    Caption = '&Primeiro'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnPrimeiroClick
  end
  object btnProximo: TButton
    Left = 251
    Top = 47
    Width = 75
    Height = 25
    Hint = 'Vai para o pr'#243'ximo dado'
    Caption = '&Proximo'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnProximoClick
  end
  object btnLimpar: TButton
    Left = 89
    Top = 47
    Width = 75
    Height = 25
    Hint = 
      'Caso tenha efetuado busca, ou percorrido a lista, clique aqui an' +
      'tes de tentar incluir um novo registro'
    Caption = '&Limpar'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnLimparClick
  end
  object btnBuscarPorId: TButton
    Left = 368
    Top = 18
    Width = 93
    Height = 25
    Hint = 
      'Preencha o campo Id e clique nesta busca para buscar pelo Id inf' +
      'ormado'
    Caption = 'Buscar por &Id'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = btnBuscarPorIdClick
  end
  object btnBuscarPorNome: TButton
    Left = 467
    Top = 18
    Width = 93
    Height = 25
    Hint = 
      'Preencha o campo Nome e clique nesta busca para buscar pelo Nome' +
      ' informado'
    Caption = 'Buscar por &Nome'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnBuscarPorNomeClick
  end
end
