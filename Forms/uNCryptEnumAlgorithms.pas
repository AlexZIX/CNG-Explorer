unit uNCryptEnumAlgorithms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG, Winapi.ShellAPI;

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

  if ErrRet = ERROR_SUCCESS then
  begin
    for i := 0 to dwAlgCount - 1 do
    begin
      Move(Pointer(NativeUInt(NCryptAlgorithmNamePtr) + SizeOf(NCryptAlgorithmName) * i)^,
        NCryptAlgorithmName, SizeOf(NCryptAlgorithmName));

       S := 'AlgoName: ' + NCryptAlgorithmName.pszName;
       lbAlgorithms.Items.Add(S);
    end;
  end;

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);

  NCryptFreeBuffer(NCryptAlgorithmNamePtr);
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

end.
