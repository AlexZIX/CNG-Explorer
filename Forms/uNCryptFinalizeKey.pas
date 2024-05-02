unit uNCryptFinalizeKey;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG, Winapi.ShellAPI;

type
  TfrmNCryptFinalizeKey = class(TFrame)
    lblFunctionName: TLabel;
    lblFunctionDescription: TLabel;
    pnlTopSeparator: TPanel;
    btnExecute: TBitBtn;
    Panel1: TPanel;
    leResult: TLabeledEdit;
    edtResultMessage: TEdit;
    btnHelp: TBitBtn;
    cbNoKeyValidation: TCheckBox;
    lblFlags: TLabel;
    cbWriteKeyToLegacyStore: TCheckBox;
    cbSilentFlag: TCheckBox;
    procedure btnHelpClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
  private
    class var FFrame: TFrame;
  public
    class function GetFrame: TFrame;
  end;

implementation

{$R *.dfm}

procedure TfrmNCryptFinalizeKey.btnExecuteClick(Sender: TObject);
var ErrRet: UInt32;
    dwFlags: UInt32;
begin
  dwFlags := 0;
  if cbNoKeyValidation.Checked then
    dwFlags := dwFlags or NCRYPT_NO_KEY_VALIDATION;
  if cbWriteKeyToLegacyStore.Checked then
    dwFlags := dwFlags or NCRYPT_WRITE_KEY_TO_LEGACY_STORE_FLAG;
  if cbSilentFlag.Checked then
    dwFlags := dwFlags or NCRYPT_SILENT_FLAG;

  ErrRet := NCryptFinalizeKey(TNCryptCNG.hKey, dwFlags);

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);
end;

procedure TfrmNCryptFinalizeKey.btnHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'Open',
    'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptfinalizekey',
    '', '', SW_SHOWNORMAL);
end;

class function TfrmNCryptFinalizeKey.GetFrame: TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  Result := FFrame;
end;

end.
