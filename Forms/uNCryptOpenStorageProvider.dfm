object frmNCryptOpenStorageProvider: TfrmNCryptOpenStorageProvider
  Left = 0
  Top = 0
  Width = 967
  Height = 592
  TabOrder = 0
  DesignSize = (
    967
    592)
  object lblFunctionName: TLabel
    Left = 16
    Top = 3
    Width = 277
    Height = 28
    Caption = 'NCryptOpenStorageProvider '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblFunctionDescription: TLabel
    Left = 16
    Top = 32
    Width = 248
    Height = 15
    Caption = 'Loads and initializes a CNG key storage provide'
  end
  object lblProviderName: TLabel
    Left = 15
    Top = 67
    Width = 77
    Height = 15
    Caption = 'Provider name'
  end
  object Label1: TLabel
    Left = 327
    Top = 93
    Width = 392
    Height = 15
    Caption = 
      ' - Identifies the software key storage provider that is provided' +
      ' by Microsoft'
  end
  object Label2: TLabel
    Left = 339
    Top = 114
    Width = 403
    Height = 15
    Caption = 
      ' - Identifies the smart card key storage provider that is provid' +
      'ed by Microsoft'
  end
  object Label3: TLabel
    Left = 296
    Top = 135
    Width = 368
    Height = 15
    Caption = 
      '- Identifies the TPM key storage provider that is provided by Mi' +
      'crosoft'
  end
  object Label4: TLabel
    Left = 96
    Top = 93
    Width = 231
    Height = 15
    Caption = 'Microsoft Software Key Storage Provider'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 96
    Top = 114
    Width = 241
    Height = 15
    Caption = 'Microsoft Smart Card Key Storage Provider'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 96
    Top = 135
    Width = 197
    Height = 15
    Caption = 'Microsoft Platform Crypto Provider'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlTopSeparator: TPanel
    Left = 0
    Top = 52
    Width = 967
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 0
  end
  object btnExecute: TBitBtn
    Left = 858
    Top = 8
    Width = 87
    Height = 33
    Anchors = [akTop, akRight]
    Caption = '&Execute'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    Kind = bkAll
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    OnClick = btnExecuteClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 218
    Width = 967
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 2
  end
  object leResult: TLabeledEdit
    Left = 96
    Top = 234
    Width = 121
    Height = 23
    EditLabel.Width = 32
    EditLabel.Height = 15
    EditLabel.Caption = 'Result'
    LabelPosition = lpLeft
    TabOrder = 3
    Text = ''
  end
  object edtResultMessage: TEdit
    Left = 232
    Top = 234
    Width = 713
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 4
  end
  object cbProviderName: TComboBox
    Left = 96
    Top = 64
    Width = 254
    Height = 23
    ItemIndex = 0
    TabOrder = 5
    Text = 'Microsoft Software Key Storage Provider'
    Items.Strings = (
      'Microsoft Software Key Storage Provider'
      'Microsoft Smart Card Key Storage Provider'
      'Microsoft Platform Crypto Provider')
  end
  object btnHelp: TBitBtn
    Left = 761
    Top = 8
    Width = 87
    Height = 33
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    Kind = bkHelp
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 6
    OnClick = btnHelpClick
  end
end
