object frmNCryptSign: TfrmNCryptSign
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
    Width = 386
    Height = 28
    Caption = 'NCryptSignHash/NCryptVerifySignature '
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
    Width = 537
    Height = 15
    Caption = 
      'Creates a signature of a hash value and verifies that the specif' +
      'ied signature matches the specified hash'
  end
  object lblFlags: TLabel
    Left = 92
    Top = 421
    Width = 27
    Height = 15
    Caption = 'Flags'
  end
  object lblData: TLabel
    Left = 95
    Top = 101
    Width = 24
    Height = 15
    Caption = 'Data'
  end
  object lblSignature: TLabel
    Left = 68
    Top = 263
    Width = 50
    Height = 15
    Caption = 'Signature'
  end
  object lblOperation: TLabel
    Left = 65
    Top = 67
    Width = 53
    Height = 15
    Caption = 'Operation'
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
  object cbPadPKCS1: TCheckBox
    Left = 124
    Top = 443
    Width = 188
    Height = 17
    Caption = 'NCRYPT_PAD_PKCS1_FLAG'
    TabOrder = 6
  end
  object cbSilentFlag: TCheckBox
    Left = 124
    Top = 466
    Width = 188
    Height = 17
    Caption = 'NCRYPT_SILENT_FLAG'
    TabOrder = 7
  end
  object cbPadPSS: TCheckBox
    Left = 124
    Top = 421
    Width = 181
    Height = 17
    Caption = 'NCRYPT_PAD_PSS_FLAG'
    TabOrder = 8
  end
  object heData: TBCHexEditor
    Left = 124
    Top = 96
    Width = 830
    Height = 148
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    PopupMenu = pmData
    ShowHint = False
    TabOrder = 9
    InsertMode = True
    ShowRuler = True
  end
  object heSignature: TBCHexEditor
    Left = 124
    Top = 257
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
      'Sign'
      'Verify')
    ShowFrame = False
    TabOrder = 11
    StyleElements = []
  end
  object pmData: TPopupMenu
    Left = 408
    Top = 440
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
