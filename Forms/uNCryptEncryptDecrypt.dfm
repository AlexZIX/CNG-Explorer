object fmBzCrypt: TfmBzCrypt
  Left = 0
  Top = 0
  Width = 967
  Height = 659
  TabOrder = 0
  DesignSize = (
    967
    659)
  object lblFunctionName: TLabel
    Left = 16
    Top = 3
    Width = 75
    Height = 28
    Caption = 'BzCrypt'
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
    Width = 144
    Height = 15
    Caption = 'Get info from license server'
  end
  object lblOutputData: TLabel
    Left = 26
    Top = 400
    Width = 65
    Height = 15
    Caption = 'Output Data'
  end
  object lblEncryptionType: TLabel
    Left = 7
    Top = 68
    Width = 84
    Height = 15
    Caption = 'Encryption Type'
  end
  object lblInputData: TLabel
    Left = 38
    Top = 204
    Width = 54
    Height = 15
    Caption = 'Input data'
  end
  object Label1: TLabel
    Left = 66
    Top = 127
    Width = 24
    Height = 15
    Caption = 'InitV'
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
    Caption = 'Execute'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnExecuteClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 356
    Width = 967
    Height = 4
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 2
  end
  object leResult: TLabeledEdit
    Left = 96
    Top = 365
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
    Top = 365
    Width = 713
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 4
  end
  object cbEncryptionType: TComboBox
    Left = 96
    Top = 65
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 5
    Text = 'ET_AES_ENC_ECB'
    Items.Strings = (
      'ET_AES_ENC_ECB'
      'ET_AES_DEC_ECB'
      'ET_AES_ENC_CBC'
      'ET_AES_DEC_CBC')
  end
  object heInput: TBCHexEditor
    Left = 96
    Top = 200
    Width = 849
    Height = 148
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    PopupMenu = pmData
    ShowHint = False
    TabOrder = 6
    InsertMode = True
    ShowRuler = True
  end
  object heOutput: TBCHexEditor
    Left = 96
    Top = 395
    Width = 849
    Height = 221
    Anchors = [akLeft, akTop, akRight]
    PopupMenu = pmData
    TabOrder = 7
    ShowRuler = True
  end
  object leSecretDataNum: TLabeledEdit
    Left = 96
    Top = 93
    Width = 121
    Height = 23
    EditLabel.Width = 69
    EditLabel.Height = 15
    EditLabel.Caption = 'Secret Data #'
    LabelPosition = lpLeft
    TabOrder = 8
    Text = '0'
  end
  object heInitV: TBCHexEditor
    Left = 96
    Top = 122
    Width = 849
    Height = 72
    Anchors = [akLeft, akTop, akRight]
    PopupMenu = pmData
    TabOrder = 9
    InsertMode = True
    ShowRuler = True
  end
  object pmData: TPopupMenu
    Left = 264
    Top = 496
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
      object pmi16random: TMenuItem
        Tag = 3
        Caption = '16 random'
        OnClick = FillWithData
      end
    end
  end
end
