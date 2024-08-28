object frmNCryptExportImport: TfrmNCryptExportImport
  Left = 0
  Top = 0
  Width = 977
  Height = 592
  TabOrder = 0
  DesignSize = (
    977
    592)
  object lblFunctionName: TLabel
    Left = 16
    Top = 3
    Width = 343
    Height = 28
    Caption = 'NCryptExportKey/NCryptImportKey'
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
    Width = 250
    Height = 15
    Caption = 'Export/Import CNG Key to/from memory BLOB'
  end
  object lblFlags: TLabel
    Left = 91
    Top = 321
    Width = 27
    Height = 15
    Caption = 'Flags'
  end
  object lblData: TLabel
    Left = 63
    Top = 130
    Width = 57
    Height = 15
    Caption = 'Data (HEX)'
  end
  object lblOperation: TLabel
    Left = 65
    Top = 67
    Width = 53
    Height = 15
    Caption = 'Operation'
  end
  object lblPropertyName: TLabel
    Left = 65
    Top = 96
    Width = 55
    Height = 15
    Caption = 'BLOB type'
  end
  object pnlTopSeparator: TPanel
    Left = 0
    Top = 52
    Width = 977
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 0
  end
  object btnExecute: TBitBtn
    Left = 868
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
    Left = 4
    Top = 514
    Width = 977
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 2
  end
  object leResult: TLabeledEdit
    Left = 100
    Top = 530
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
    Left = 236
    Top = 530
    Width = 723
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 4
  end
  object btnHelp: TBitBtn
    Left = 771
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
    Left = 124
    Top = 321
    Width = 188
    Height = 17
    Caption = 'NCRYPT_SILENT_FLAG'
    TabOrder = 6
  end
  object heData: TBCHexEditor
    Left = 124
    Top = 125
    Width = 830
    Height = 186
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    ShowHint = False
    TabOrder = 7
    ReadOnlyView = True
    ShowRuler = True
  end
  object rgOperation: TRadioGroup
    Left = 124
    Top = 62
    Width = 141
    Height = 28
    Columns = 2
    DefaultHeaderFont = False
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -1
    HeaderFont.Name = 'Segoe UI'
    HeaderFont.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Export'
      'Import')
    ShowFrame = False
    TabOrder = 8
    StyleElements = []
    OnClick = rgOperationClick
  end
  object cbBlobType: TComboBox
    Left = 124
    Top = 93
    Width = 293
    Height = 23
    ItemIndex = 0
    TabOrder = 9
    Text = 'CipherKeyBlob'
    Items.Strings = (
      'CipherKeyBlob'
      'ProtectedKeyBlob'
      'OpaqueTransport'
      'DHPRIVATEBLOB'
      'DHPUBLICBLOB'
      'DSAPRIVATEBLOB'
      'DSAPUBLICBLOB'
      'ECCPRIVATEBLOB'
      'ECCPUBLICBLOB'
      'PRIVATEBLOB'
      'PUBLICBLOB'
      'RSAFULLPRIVATEBLOB'
      'RSAPRIVATEBLOB'
      'RSAPUBLICBLOB'
      'PKCS7_ENVELOPE'
      'PKCS8_PRIVATEKEY')
  end
end
