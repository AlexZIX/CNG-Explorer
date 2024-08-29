object frmNCryptEnumStorageProviders: TfrmNCryptEnumStorageProviders
  Left = 0
  Top = 0
  Width = 980
  Height = 677
  TabOrder = 0
  DesignSize = (
    980
    677)
  object lblFunctionName: TLabel
    Left = 16
    Top = 3
    Width = 289
    Height = 28
    Caption = 'NCryptEnumStorageProviders '
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
    Width = 303
    Height = 15
    Caption = 'Obtains the names of the registered key storage providers'
  end
  object lblProviders: TLabel
    Left = 44
    Top = 314
    Width = 49
    Height = 15
    Caption = 'Providers'
  end
  object lblFlags: TLabel
    Left = 93
    Top = 64
    Width = 27
    Height = 15
    Caption = 'Flags'
  end
  object pnlTopSeparator: TPanel
    Left = 0
    Top = 52
    Width = 980
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 0
  end
  object btnExecute: TBitBtn
    Left = 871
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
    Top = 265
    Width = 980
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 2
  end
  object leResult: TLabeledEdit
    Left = 96
    Top = 281
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
    Top = 281
    Width = 726
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 4
  end
  object btnHelp: TBitBtn
    Left = 774
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
    TabOrder = 5
    OnClick = btnHelpClick
  end
  object cbSilentFlag: TCheckBox
    Left = 125
    Top = 64
    Width = 188
    Height = 17
    Caption = 'NCRYPT_SILENT_FLAG'
    TabOrder = 6
  end
  object lbProviders: TListBox
    Left = 96
    Top = 312
    Width = 862
    Height = 337
    Hint = 'Double click to copy provider name'
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 15
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnDblClick = lbProvidersDblClick
  end
end
