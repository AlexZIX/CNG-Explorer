object frmNCryptProperty: TfrmNCryptProperty
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
    Width = 374
    Height = 28
    Caption = 'NCryptGetProperty/NCryptSetProperty'
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
    Width = 442
    Height = 15
    Caption = 
      'Sets/Retrieves the value of a named property for a key storage o' +
      'bject a block of data'
  end
  object lblFlags: TLabel
    Left = 92
    Top = 383
    Width = 27
    Height = 15
    Caption = 'Flags'
  end
  object lblData: TLabel
    Left = 61
    Top = 192
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
    Left = 40
    Top = 127
    Width = 78
    Height = 15
    Caption = 'Property name'
  end
  object lblObject: TLabel
    Left = 83
    Top = 95
    Width = 35
    Height = 15
    Caption = 'Object'
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
  object cbPersistOnly: TCheckBox
    Left = 124
    Top = 381
    Width = 188
    Height = 17
    Caption = 'NCRYPT_PERSIST_ONLY_FLAG'
    TabOrder = 6
  end
  object cbSilentFlag: TCheckBox
    Left = 124
    Top = 404
    Width = 188
    Height = 17
    Caption = 'NCRYPT_SILENT_FLAG'
    TabOrder = 7
  end
  object heData: TBCHexEditor
    Left = 124
    Top = 187
    Width = 830
    Height = 186
    Anchors = [akLeft, akTop, akRight]
    OnKeyUp = heDataKeyUp
    ParentShowHint = False
    ShowHint = False
    TabOrder = 8
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
      'Get'
      'Set')
    ShowFrame = False
    TabOrder = 9
    StyleElements = []
    OnClick = rgOperationClick
  end
  object cbHandle: TComboBox
    Left = 124
    Top = 92
    Width = 121
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 10
    Text = 'Provider handle'
    Items.Strings = (
      'Provider handle'
      'Key handle')
  end
  object cbPropertyName: TComboBox
    Left = 124
    Top = 124
    Width = 293
    Height = 23
    TabOrder = 11
    Text = 'Algorithm Group'
    Items.Strings = (
      'Algorithm Group'
      'Algorithm Name'
      'Chaining Mode'
      'IV'
      'SmartCardAssociatedECDHKey'
      'Block Length'
      'SmartCardKeyCertificate'
      'DHParameters'
      'Export Policy'
      'Impl Type'
      'Key Type'
      'Key Usage'
      'Modified'
      'Length'
      'Lengths'
      'Max Name Length'
      'Name'
      'SmartCardPinPrompt'
      'SmartCardPin'
      'Provider Handle'
      'SmartCardReader'
      'SmartcardRootCertStore'
      'SmartCardPinId'
      'SmartCardPinInfo'
      'SmartCardSecurePin'
      'Security Descr'
      'Security Descr Support'
      'SmartCardGuid'
      'UI Policy'
      'Unique Name'
      'Use Context'
      'Enabled Use Count'
      'Use Count'
      'SmartCardUserCertStore'
      'Version'
      'HWND Handle')
  end
  object btnHelpPropertyName: TBitBtn
    Left = 423
    Top = 123
    Width = 26
    Height = 25
    Caption = '&'
    Kind = bkHelp
    NumGlyphs = 2
    TabOrder = 12
    OnClick = btnHelpPropertyNameClick
  end
  object leData: TLabeledEdit
    Left = 124
    Top = 154
    Width = 293
    Height = 23
    EditLabel.Width = 60
    EditLabel.Height = 15
    EditLabel.Caption = 'Data (TEXT)'
    LabelPosition = lpLeft
    ReadOnly = True
    TabOrder = 13
    Text = ''
    OnKeyUp = leDataKeyUp
  end
end
