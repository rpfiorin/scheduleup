object frmDiary: TfrmDiary
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Agende-se'
  ClientHeight = 490
  ClientWidth = 560
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnHide = FormHide
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSepara: TJvLabel
    Left = 3
    Top = 236
    Width = 554
    Height = 13
    Caption = 
      '________________________________________________________________' +
      '____________________________'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12615680
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = True
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
  end
  object lblFechar: TJvLabel
    Left = 535
    Top = -2
    Width = 18
    Height = 37
    Caption = 'X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12615680
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Transparent = True
    OnClick = lblFecharClick
    OnMouseMove = lblFecharMouseMove
    OnMouseLeave = lblFecharMouseLeave
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -27
    HotTrackFont.Name = 'Segoe UI'
    HotTrackFont.Style = []
  end
  object lblMinimizar: TJvLabel
    Left = 464
    Top = -6
    Width = 24
    Height = 37
    Caption = '__'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12615680
    Font.Height = -27
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    OnClick = lblMinimizarClick
    OnMouseMove = lblMinimizarMouseMove
    OnMouseLeave = lblMinimizarMouseLeave
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -27
    HotTrackFont.Name = 'Segoe UI'
    HotTrackFont.Style = []
  end
  object lblMaximizar: TJvLabel
    Left = 499
    Top = -2
    Width = 25
    Height = 37
    Caption = #9744
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 9145227
    Font.Height = -27
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    ParentFont = False
    Transparent = True
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -27
    HotTrackFont.Name = 'Segoe UI Light'
    HotTrackFont.Style = []
  end
  object lblTitulo: TLabel
    Left = 206
    Top = 45
    Width = 145
    Height = 37
    Caption = 'Novo evento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    ParentFont = False
  end
  object lblLancados: TLabel
    Left = 181
    Top = 262
    Width = 196
    Height = 37
    Caption = 'Pr'#243'ximos eventos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -27
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    ParentFont = False
  end
  object lblVersao: TLabel
    Left = 8
    Top = 5
    Width = 49
    Height = 17
    Caption = 'lblVersao'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 12615680
    Font.Height = -13
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    ParentFont = False
  end
  object txtEvento: TEdit
    Left = 116
    Top = 113
    Width = 224
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 0
    Text = 'Descri'#231#227'o'
    OnClick = txtEventoClick
    OnExit = txtEventoExit
    OnKeyPress = txtEventoKeyPress
  end
  object dtEdtData: TJvDateEdit
    Left = 116
    Top = 177
    Width = 105
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ShowNullDate = False
    StartOfWeek = Sun
    TabOrder = 2
    OnChange = dtEdtDataChange
    OnEnter = dtEdtDataEnter
    OnExit = dtEdtDataExit
    OnMouseUp = dtEdtDataMouseUp
  end
  object txtLocal: TEdit
    Left = 116
    Top = 145
    Width = 224
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsItalic]
    ParentFont = False
    TabOrder = 1
    Text = 'Local'
    OnEnter = txtLocalEnter
    OnExit = txtLocalExit
  end
  object btnLancar: TButton
    Left = 363
    Top = 113
    Width = 80
    Height = 25
    Caption = 'Lan'#231'ar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnLancarClick
    OnMouseMove = btnLancarMouseMove
  end
  object medtHorario: TJvMaskEdit
    Left = 235
    Top = 177
    Width = 105
    Height = 24
    EditMask = '!90:00 - !90:00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    MaxLength = 13
    ParentFont = False
    TabOrder = 3
    Text = '  :   -   :  '
    OnEnter = medtHorarioEnter
    OnKeyPress = medtHorarioKeyPress
    OnMouseUp = medtHorarioMouseUp
  end
  object dbugEventos: TJvDBUltimGrid
    Left = 39
    Top = 328
    Width = 484
    Height = 111
    Hint = 'CLIQUE NA DESCRI'#199#195'O DO EVENTO PARA EDIT'#193'-LA'
    DataSource = dsEventos
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Cambria'
    TitleFont.Style = []
    OnCellClick = dbugEventosCellClick
    OnColEnter = dbugEventosColEnter
    OnDblClick = dbugEventosDblClick
    OnMouseLeave = dbugEventosMouseLeave
    ScrollBars = ssVertical
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 16
    Columns = <
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = ' Descri'#231#227'o'
        Width = 186
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'data'
        Title.Caption = ' Data'
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'horario'
        Title.Caption = ' Hor'#225'rio'
        Width = 71
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'local'
        Title.Caption = ' Local'
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'is_ativo'
        Title.Caption = ' On/Off'
        Width = 40
        Visible = True
      end>
  end
  object btnExcluir: TButton
    Left = 363
    Top = 177
    Width = 80
    Height = 25
    Caption = 'Excluir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btnExcluirClick
  end
  object btnLimpar: TButton
    Left = 363
    Top = 145
    Width = 80
    Height = 25
    Caption = 'Limpar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Light'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnLimparClick
  end
  object edtTestaData: TEdit
    Left = 235
    Top = 208
    Width = 105
    Height = 21
    TabOrder = 8
    Visible = False
  end
  object dtEdtAtual: TJvDateEdit
    Left = 116
    Top = 209
    Width = 105
    Height = 21
    ShowNullDate = False
    TabOrder = 9
    Visible = False
  end
  object ZqryEventos: TZQuery
    Connection = dm_DBconn.Zconn_pg
    AfterRefresh = ZqryEventosAfterRefresh
    SQL.Strings = (
      'SELECT * FROM '
      'rpfiorin.evento'
      'ORDER BY data,'
      'horario')
    Params = <>
    Left = 440
    Top = 448
    object ZqryEventosdescricao: TWideMemoField
      FieldName = 'descricao'
      Required = True
      BlobType = ftWideMemo
    end
    object ZqryEventosdata: TDateField
      FieldName = 'data'
      Required = True
    end
    object ZqryEventoshorario: TWideStringField
      FieldName = 'horario'
      Required = True
      Size = 30
    end
    object ZqryEventoslocal: TWideStringField
      FieldName = 'local'
      Required = True
      Size = 80
    end
    object ZqryEventosis_ativo: TBooleanField
      FieldName = 'is_ativo'
      Required = True
    end
  end
  object dsEventos: TDataSource
    DataSet = ZqryEventos
    Left = 496
    Top = 448
  end
  object ZqryVersao: TZQuery
    Connection = dm_DBconn.Zconn_pg
    SQL.Strings = (
      'SELECT nome||'#39' '#39'||'
      '             versao FROM '
      'rpfiorin.sistema WHERE '
      'nome ILIKE '#39'%ScheduleUp%'#39
      'OR'
      'nome ILIKE '#39'%Scheduleup%'#39
      'OR'
      'nome  ILIKE '#39'%scheduleUp%'#39
      'OR'
      'nome  ILIKE '#39'%scheduleup%'#39)
    Params = <>
    Left = 16
    Top = 32
  end
  object tIcon: TTrayIcon
    PopupMenu = ppmIcon
    OnDblClick = tIconDblClick
    Left = 384
  end
  object ppmIcon: TPopupMenu
    Left = 424
    object ppRestaurar: TMenuItem
      Caption = 'Restaurar'
      OnClick = ppRestaurarClick
    end
    object ppEncerrar: TMenuItem
      Caption = 'Encerrar'
      OnClick = ppEncerrarClick
    end
  end
  object appEvt: TApplicationEvents
    OnException = appEvtException
    Left = 8
    Top = 448
  end
end
