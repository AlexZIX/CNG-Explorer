unit uNCryptEnumAlgorithms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG, Winapi.ShellAPI,
  Helpers, Vcl.Clipbrd;

type
  TfrmNCryptEnumAlgorithms = class(TFrame)
    lblFunctionName: TLabel;
    lblFunctionDescription: TLabel;
    pnlTopSeparator: TPanel;
    btnExecute: TBitBtn;
    Panel1: TPanel;
    leResult: TLabeledEdit;
    edtResultMessage: TEdit;
    btnHelp: TBitBtn;
    cbCipherOperation: TCheckBox;
    lblAlgOperations: TLabel;
    cbSilentFlag: TCheckBox;
    lblAlgorithms: TLabel;
    lbAlgorithms: TListBox;
    cbHashOperation: TCheckBox;
    cbAsymmetricEncryptionOperation: TCheckBox;
    cbSecretAgreementOperation: TCheckBox;
    cbSignatureOperation: TCheckBox;
    lblFlags: TLabel;
    procedure btnHelpClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure lbAlgorithmsDblClick(Sender: TObject);
  private
    class var FFrame: TFrame;
  public
    class function GetFrame: TFrame;
  end;

implementation

{$R *.dfm}

procedure TfrmNCryptEnumAlgorithms.btnExecuteClick(Sender: TObject);
var ErrRet, i: UInt32;
    dwFlags, dwAlgCount, dwAlgOperations: UInt32;
    NCryptAlgorithmNamePtr: PNCryptAlgorithmName;
    NCryptAlgorithmName: TNCryptAlgorithmName;
    S, FlagsStr: String;

  procedure AddFlag(FlagName: String);
  begin
    if FlagsStr <> '' then
      FlagsStr := FlagsStr + ' or ';

    FlagsStr := FlagsStr + FlagName;
  end;

  function GetDwClassValue(dwClass: DWORD): String;
  begin
    Result := 'UNKNOWN';

    case dwClass of
      3: Result := 'NCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE';
      4: Result := 'NCRYPT_SECRET_AGREEMENT_INTERFACE';
      5: Result := 'NCRYPT_SIGNATURE_INTERFACE';
    end;
  end;

begin
  lbAlgorithms.Clear;

  dwAlgOperations := 0;
  if cbCipherOperation.Checked then
    dwAlgOperations := dwAlgOperations or NCRYPT_CIPHER_OPERATION;
  if cbHashOperation.Checked then
    dwAlgOperations := dwAlgOperations or NCRYPT_HASH_OPERATION;
  if cbAsymmetricEncryptionOperation.Checked then
    dwAlgOperations := dwAlgOperations or NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION;
  if cbSecretAgreementOperation.Checked then
    dwAlgOperations := dwAlgOperations or NCRYPT_SECRET_AGREEMENT_OPERATION;
  if cbSignatureOperation.Checked then
    dwAlgOperations := dwAlgOperations or NCRYPT_SIGNATURE_OPERATION;

  dwFlags := 0;
  if cbSilentFlag.Checked then
    dwFlags := dwFlags or NCRYPT_SILENT_FLAG;

  ErrRet := NCryptEnumAlgorithms(TNCryptCNG.hProvider, dwAlgOperations,
              @dwAlgCount, @NCryptAlgorithmNamePtr, dwFlags);

  if (ErrRet = ERROR_SUCCESS) and (dwAlgCount > 0) then
  begin
    for i := 0 to dwAlgCount - 1 do
    begin
      Move(Pointer(NativeUInt(NCryptAlgorithmNamePtr) + SizeOf(NCryptAlgorithmName) * i)^,
        NCryptAlgorithmName, SizeOf(NCryptAlgorithmName));

      FlagsStr := '';
      if (NCryptAlgorithmName.dwAlgOperations and NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION) <> 0 then
        AddFlag('NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION');
      if (NCryptAlgorithmName.dwAlgOperations and NCRYPT_SECRET_AGREEMENT_OPERATION) <> 0 then
        AddFlag('NCRYPT_SECRET_AGREEMENT_OPERATION');
      if (NCryptAlgorithmName.dwAlgOperations and NCRYPT_SIGNATURE_OPERATION) <> 0 then
        AddFlag('NCRYPT_SIGNATURE_OPERATION');

      S := 'AlgoName: ' + NCryptAlgorithmName.pszName + ', ' +
           'Class: ' + GetDwClassValue(NCryptAlgorithmName.dwClass)  + ', ' +
           'Operation: ' + FlagsStr + ', ' +
           'Flags: ' + IntToStr(NCryptAlgorithmName.dwFlags);

      lbAlgorithms.AddItem(S, TStringObject.Create(NCryptAlgorithmName.pszName));
    end;

    NCryptFreeBuffer(NCryptAlgorithmNamePtr);
  end;

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);
end;

procedure TfrmNCryptEnumAlgorithms.btnHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'Open',
    'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptenumalgorithms',
    '', '', SW_SHOWNORMAL);
end;

class function TfrmNCryptEnumAlgorithms.GetFrame: TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  Result := FFrame;
end;

procedure TfrmNCryptEnumAlgorithms.lbAlgorithmsDblClick(Sender: TObject);
begin
  if lbAlgorithms.ItemIndex <> -1 then
    Clipboard.AsText := TStringObject(lbAlgorithms.Items.Objects[lbAlgorithms.ItemIndex]).Value;
end;

end.
