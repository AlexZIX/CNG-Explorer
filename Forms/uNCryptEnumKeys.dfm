object frmNCryptEnumKeys: TfrmNCryptEnumKeys
  Left = 0
  Top = 0
  Width = 969
  Height = 601
  TabOrder = 0
  DesignSize = (
    969
    601)
  object lblFunctionName: TLabel
    Left = 16
    Top = 3
    Width = 171
    Height = 28
    Caption = 'NCryptEnumKeys '
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
    Width = 321
    Height = 15
    Caption = 'Obtains the names of the keys that are stored by the provider'
  end
  object lblFlags: TLabel
    Left = 93
    Top = 63
    Width = 27
    Height = 15
    Caption = 'Flags'
  end
  object lblKeyNames: TLabel
    Left = 68
    Top = 314
    Width = 24
    Height = 15
    Caption = 'Keys'
  end
  object pnlTopSeparator: TPanel
    Left = 0
    Top = 52
    Width = 969
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 0
  end
  object btnExecute: TBitBtn
    Left = 860
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
    Width = 969
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
    Width = 715
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 4
  end
  object btnHelp: TBitBtn
    Left = 763
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
  object cbMachineKeyFlag: TCheckBox
    Left = 125
    Top = 63
    Width = 188
    Height = 17
    Caption = 'NCRYPT_MACHINE_KEY_FLAG'
    TabOrder = 6
  end
  object cbSilentFlag: TCheckBox
    Left = 125
    Top = 86
    Width = 188
    Height = 17
    Caption = 'NCRYPT_SILENT_FLAG'
    TabOrder = 7
  end
  object lbKeys: TListBox
    Left = 96
    Top = 312
    Width = 851
    Height = 265
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 15
    TabOrder = 8
  end
end
