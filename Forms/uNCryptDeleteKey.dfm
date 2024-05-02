object frmNCryptDeleteKey: TfrmNCryptDeleteKey
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
    Width = 171
    Height = 28
    Caption = 'NCryptDeleteKey '
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
    Width = 96
    Height = 15
    Caption = 'Deletes a CNG key'
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
    Left = 2
    Top = 92
    Width = 967
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 2
  end
  object leResult: TLabeledEdit
    Left = 95
    Top = 107
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
    Left = 231
    Top = 107
    Width = 713
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 4
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
    TabOrder = 5
    OnClick = btnHelpClick
  end
  object cbSilentFlag: TCheckBox
    Left = 125
    Top = 63
    Width = 292
    Height = 17
    Caption = 'NCRYPT_SILENT_FLAG'
    TabOrder = 6
  end
end
