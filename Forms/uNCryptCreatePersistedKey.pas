unit uNCryptCreatePersistedKey;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG, Winapi.ShellAPI;

type
  TfrmNCryptCreatePersistedKey = class(TFrame)
    lblFunctionName: TLabel;
    lblFunctionDescription: TLabel;
    pnlTopSeparator: TPanel;
    btnExecute: TBitBtn;
    Panel1: TPanel;
    leResult: TLabeledEdit;
    edtResultMessage: TEdit;
    lblAlgorithmIdentifier: TLabel;
    cbAlgorithmIdentifier: TComboBox;
    btnHelp: TBitBtn;
    leKeyName: TLabeledEdit;
    cbMachineKeyFlag: TCheckBox;
    lblFlags: TLabel;
    cbOverwriteKeyFlag: TCheckBox;
    cbRequireVbsFlag: TCheckBox;
    cbPreferVbsFlag: TCheckBox;
    lblLegacyKeySpec: TLabel;
    cbKeyExchange: TCheckBox;
    cbSignature: TCheckBox;
    procedure btnHelpClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
  private
    class var FOnChangePointers: TNotifyEvent;
    class var FFrame: TFrame;
  public
    class function GetFrame(OnChangePointers: TNotifyEvent): TFrame;
  end;

implementation

{$R *.dfm}

procedure TfrmNCryptCreatePersistedKey.btnExecuteClick(Sender: TObject);
var ErrRet: UInt32;
    dwLegacyKeySpec, dwFlags: UInt32;
begin
  dwFlags := 0;
  if cbMachineKeyFlag.Checked then
    dwFlags := dwFlags or NCRYPT_MACHINE_KEY_FLAG;
  if cbOverwriteKeyFlag.Checked then
    dwFlags := dwFlags or NCRYPT_OVERWRITE_KEY_FLAG;
  {if cbRequireVbsFlag.Checked then
    dwFlags := dwFlags or NCRYPT_REQUIRE_VBS_FLAG;
  if cbPreferVbsFlag.Checked then
    dwFlags := dwFlags or NCRYPT_PREFER_VBS_FLAG;}

  dwLegacyKeySpec := 0;
  if cbKeyExchange.Checked then
    dwLegacyKeySpec := dwLegacyKeySpec or AT_KEYEXCHANGE;
  if cbSignature.Checked then
    dwLegacyKeySpec := dwLegacyKeySpec or AT_SIGNATURE;

  ErrRet := NCryptCreatePersistedKey(TNCryptCNG.hProvider, @TNCryptCNG.hKey,
    PWideChar(cbAlgorithmIdentifier.Text), PWideChar(leKeyName.Text), dwLegacyKeySpec, dwFlags);

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);

  if Assigned(FOnChangePointers) then
    FOnChangePointers(nil);
end;

procedure TfrmNCryptCreatePersistedKey.btnHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'Open',
    'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptcreatepersistedkey',
    '', '', SW_SHOWNORMAL);
end;

class function TfrmNCryptCreatePersistedKey.GetFrame(OnChangePointers: TNotifyEvent): TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  FOnChangePointers := OnChangePointers;
  Result := FFrame;
end;

end.
