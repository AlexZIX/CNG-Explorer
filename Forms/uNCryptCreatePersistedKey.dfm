object frmNCryptCreatePersistedKey: TfrmNCryptCreatePersistedKey
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
    Width = 255
    Height = 28
    Caption = 'NCryptCreatePersistedKey '
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
    Width = 248
    Height = 15
    Caption = 'Loads and initializes a CNG key storage provide'
  end
  object lblAlgorithmIdentifier: TLabel
    Left = 16
    Top = 67
    Width = 104
    Height = 15
    Caption = 'Algorithm Identifier'
  end
  object lblFlags: TLabel
    Left = 93
    Top = 166
    Width = 27
    Height = 15
    Caption = 'Flags'
  end
  object lblLegacyKeySpec: TLabel
    Left = 33
    Top = 122
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
  object cbAlgorithmIdentifier: TComboBox
    Left = 125
    Top = 63
    Width = 108
    Height = 23
    ItemIndex = 0
    TabOrder = 5
    Text = 'AES'
    Items.Strings = (
      'AES'
      'AES-CMAC'
      'AES-GMAC'
      'MD5'
      'SHA1'
      'SHA256'
      'SHA384'
      'SHA512'
      'ECDSA'
      'ECDH'
      '3DES'
      '3DES_112'
      'CAPI_KDF'
      'DES'
      'DESX'
      'DH'
      'DSA'
      'ECDH_P256'
      'ECDH_P384'
      'ECDH_P521'
      'ECDSA_P256'
      'ECDSA_P384'
      'ECDSA_P521'
      'MD2'
      'MD4'
      'RC2'
      'RC4'
      'RNG'
      'DUALECRNG'
      'FIPS186DSARNG'
      'RSA'
      'RSA_SIGN'
      'SP800_108_CTR_HMAC'
      'SP800_56A_CONCAT'
      'PBKDF2'
      'XTS-AES')
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
    TabOrder = 6
    OnClick = btnHelpClick
  end
  object leKeyName: TLabeledEdit
    Left = 125
    Top = 92
    Width = 139
    Height = 23
    EditLabel.Width = 54
    EditLabel.Height = 15
    EditLabel.Caption = 'Key Name'
    LabelPosition = lpLeft
    TabOrder = 7
    Text = ''
  end
  object cbMachineKeyFlag: TCheckBox
    Left = 125
    Top = 166
    Width = 188
    Height = 17
    Caption = 'NCRYPT_MACHINE_KEY_FLAG'
    TabOrder = 8
  end
  object cbOverwriteKeyFlag: TCheckBox
    Left = 125
    Top = 189
    Width = 188
    Height = 17
    Caption = 'NCRYPT_OVERWRITE_KEY_FLAG'
    TabOrder = 9
  end
  object cbRequireVbsFlag: TCheckBox
    Left = 125
    Top = 212
    Width = 188
    Height = 17
    Caption = 'NCRYPT_REQUIRE_VBS_FLAG'
    TabOrder = 10
  end
  object cbPreferVbsFlag: TCheckBox
    Left = 125
    Top = 235
    Width = 188
    Height = 17
    Caption = 'NCRYPT_PREFER_VBS_FLAG'
    TabOrder = 11
  end
  object cbKeyExchange: TCheckBox
    Left = 125
    Top = 121
    Width = 188
    Height = 17
    Caption = 'AT_KEYEXCHANGE'
    TabOrder = 12
  end
  object cbSignature: TCheckBox
    Left = 125
    Top = 143
    Width = 97
    Height = 17
    Caption = 'AT_SIGNATURE'
    TabOrder = 13
  end
end
