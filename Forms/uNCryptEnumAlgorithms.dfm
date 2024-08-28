object frmNCryptEnumAlgorithms: TfrmNCryptEnumAlgorithms
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
    Width = 232
    Height = 28
    Caption = 'NCryptEnumAlgorithms '
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
  object lblAlgOperations: TLabel
    Left = 41
    Top = 63
    Width = 79
    Height = 15
    Caption = 'Alg Operations'
  end
  object lblAlgorithms: TLabel
    Left = 32
    Top = 314
    Width = 59
    Height = 15
    Caption = 'Algorithms'
  end
  object lblFlags: TLabel
    Left = 93
    Top = 178
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
  object cbCipherOperation: TCheckBox
    Left = 125
    Top = 63
    Width = 188
    Height = 17
    Caption = 'NCRYPT_CIPHER_OPERATION'
    TabOrder = 6
  end
  object cbSilentFlag: TCheckBox
    Left = 125
    Top = 178
    Width = 188
    Height = 17
    Caption = 'NCRYPT_SILENT_FLAG'
    TabOrder = 7
  end
  object lbAlgorithms: TListBox
    Left = 96
    Top = 312
    Width = 862
    Height = 337
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 15
    TabOrder = 8
  end
  object cbHashOperation: TCheckBox
    Left = 125
    Top = 86
    Width = 188
    Height = 17
    Caption = 'NCRYPT_HASH_OPERATION'
    TabOrder = 9
  end
  object cbAsymmetricEncryptionOperation: TCheckBox
    Left = 125
    Top = 109
    Width = 300
    Height = 17
    Caption = 'NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION'
    TabOrder = 10
  end
  object cbSecretAgreementOperation: TCheckBox
    Left = 125
    Top = 132
    Width = 284
    Height = 17
    Caption = 'NCRYPT_SECRET_AGREEMENT_OPERATION'
    TabOrder = 11
  end
  object cbSignatureOperation: TCheckBox
    Left = 125
    Top = 155
    Width = 188
    Height = 17
    Caption = 'NCRYPT_SIGNATURE_OPERATION'
    TabOrder = 12
  end
end
