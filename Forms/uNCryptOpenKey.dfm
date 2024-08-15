object frmNCryptOpenKey: TfrmNCryptOpenKey
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
    Width = 159
    Height = 28
    Caption = 'NCryptOpenKey '
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
    Width = 341
    Height = 15
    Caption = 
      'Opens a key that exists in the specified CNG key storage provide' +
      'r'
  end
  object lblFlags: TLabel
    Left = 93
    Top = 135
    Width = 27
    Height = 15
    Caption = 'Flags'
  end
  object lblLegacyKeySpec: TLabel
    Left = 33
    Top = 92
    Width = 87
    Height = 15
    Caption = 'Legacy Key Spec'
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
    Top = 265
    Width = 967
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
  object leKeyName: TLabeledEdit
    Left = 125
    Top = 61
    Width = 139
    Height = 23
    EditLabel.Width = 54
    EditLabel.Height = 15
    EditLabel.Caption = 'Key Name'
    LabelPosition = lpLeft
    TabOrder = 6
    Text = ''
  end
  object cbMachineKeyFlag: TCheckBox
    Left = 125
    Top = 135
    Width = 188
    Height = 17
    Caption = 'NCRYPT_MACHINE_KEY_FLAG'
    TabOrder = 7
  end
  object cbSilentFlag: TCheckBox
    Left = 125
    Top = 158
    Width = 188
    Height = 17
    Caption = 'NCRYPT_SILENT_FLAG'
    TabOrder = 8
  end
  object cbKeyExchange: TCheckBox
    Left = 125
    Top = 91
    Width = 188
    Height = 17
    Caption = 'AT_KEYEXCHANGE'
    TabOrder = 9
  end
  object cbSignature: TCheckBox
    Left = 125
    Top = 113
    Width = 97
    Height = 17
    Caption = 'AT_SIGNATURE'
    TabOrder = 10
  end
end
