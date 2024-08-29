object frmNCryptEncrypt: TfrmNCryptEncrypt
  Left = 0
  Top = 0
  Width = 977
  Height = 761
  TabOrder = 0
  DesignSize = (
    977
    761)
  object lblFunctionName: TLabel
    Left = 16
    Top = 3
    Width = 300
    Height = 28
    Caption = 'NCryptEncrypt/NCryptDecrypt '
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
    Width = 177
    Height = 15
    Caption = 'Encrypts/Decrypts a block of data'
  end
  object lblFlags: TLabel
    Left = 92
    Top = 604
    Width = 27
    Height = 15
    Caption = 'Flags'
  end
  object lblInputData: TLabel
    Left = 65
    Top = 101
    Width = 54
    Height = 15
    Caption = 'Input data'
  end
  object lblOutputData: TLabel
    Left = 55
    Top = 263
    Width = 64
    Height = 15
    Caption = 'Output data'
  end
  object lblOperation: TLabel
    Left = 65
    Top = 67
    Width = 53
    Height = 15
    Caption = 'Operation'
  end
  object lblPaddingAlgorithm: TLabel
    Left = 17
    Top = 418
    Width = 99
    Height = 15
    Caption = 'Padding algorithm'
  end
  object Label1: TLabel
    Left = 48
    Top = 453
    Width = 70
    Height = 15
    Caption = 'Padding data'
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
    Top = 697
    Width = 977
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 2
  end
  object leResult: TLabeledEdit
    Left = 100
    Top = 713
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
    Top = 713
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
  object cbPadPKCS1: TCheckBox
    Left = 124
    Top = 648
    Width = 188
    Height = 17
    Caption = 'NCRYPT_PAD_PKCS1_FLAG'
    TabOrder = 6
  end
  object cbSilentFlag: TCheckBox
    Left = 124
    Top = 671
    Width = 188
    Height = 17
    Caption = 'NCRYPT_SILENT_FLAG'
    TabOrder = 7
  end
  object cbNoPadding: TCheckBox
    Left = 124
    Top = 604
    Width = 188
    Height = 17
    Caption = 'NCRYPT_NO_PADDING_FLAG'
    TabOrder = 8
  end
  object cbPadOAEP: TCheckBox
    Left = 124
    Top = 626
    Width = 181
    Height = 17
    Caption = 'NCRYPT_PAD_OAEP_FLAG'
    TabOrder = 9
  end
  object heInput: TBCHexEditor
    Left = 124
    Top = 96
    Width = 830
    Height = 148
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    PopupMenu = pmData
    ShowHint = False
    TabOrder = 10
    InsertMode = True
    ShowRuler = True
  end
  object heOutput: TBCHexEditor
    Left = 124
    Top = 257
    Width = 830
    Height = 148
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    PopupMenu = pmData
    ShowHint = False
    TabOrder = 11
    InsertMode = True
    ShowRuler = True
  end
  object rgOperation: TRadioGroup
    Left = 124
    Top = 62
    Width = 185
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
      'Encrypt'
      'Decrypt')
    ShowFrame = False
    TabOrder = 12
    StyleElements = []
  end
  object cbPaddingAlgorithm: TComboBox
    Left = 124
    Top = 415
    Width = 213
    Height = 23
    ItemIndex = 0
    TabOrder = 13
    Text = 'SHA1'
    Items.Strings = (
      'SHA1'
      'SHA256'
      'SHA384'
      'SHA512'
      'MD2'
      'MD4'
      'MD5')
  end
  object hePaddingData: TBCHexEditor
    Left = 124
    Top = 448
    Width = 830
    Height = 148
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    PopupMenu = pmData
    ShowHint = False
    TabOrder = 14
    InsertMode = True
    ShowRuler = True
  end
  object pmData: TPopupMenu
    Left = 408
    Top = 623
    object pmiCopy: TMenuItem
      Caption = 'Copy'
      OnClick = pmiCopyClick
    end
    object pmiPaste: TMenuItem
      Caption = 'Paste'
      OnClick = pmiPasteClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object pmiClear: TMenuItem
      Caption = 'Clear'
      OnClick = pmiClearClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object pmiFillWith: TMenuItem
      Caption = 'Fill with'
      object pmi16zero: TMenuItem
        Tag = 1
        Caption = '16 zero'
        OnClick = FillWithData
      end
      object pmi32zero: TMenuItem
        Tag = 2
        Caption = '32 zero'
        OnClick = FillWithData
      end
      object pmi64zero: TMenuItem
        Tag = 3
        Caption = '64 zero'
        OnClick = FillWithData
      end
      object pmi16random: TMenuItem
        Tag = 4
        Caption = '16 random'
        OnClick = FillWithData
      end
      object pmi32random: TMenuItem
        Tag = 5
        Caption = '32 random'
        OnClick = FillWithData
      end
      object pmi64random: TMenuItem
        Tag = 6
        Caption = '64 random'
        OnClick = FillWithData
      end
    end
  end
end
