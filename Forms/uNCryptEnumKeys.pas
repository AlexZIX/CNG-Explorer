unit uNCryptEnumKeys;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG, Winapi.ShellAPI,
  Vcl.Clipbrd, Helpers;

type
  TfrmNCryptEnumKeys = class(TFrame)
    lblFunctionName: TLabel;
    lblFunctionDescription: TLabel;
    pnlTopSeparator: TPanel;
    btnExecute: TBitBtn;
    Panel1: TPanel;
    leResult: TLabeledEdit;
    edtResultMessage: TEdit;
    btnHelp: TBitBtn;
    cbMachineKeyFlag: TCheckBox;
    lblFlags: TLabel;
    cbSilentFlag: TCheckBox;
    lblKeyNames: TLabel;
    lbKeys: TListBox;
    procedure btnHelpClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure lbKeysDblClick(Sender: TObject);
  private
    class var FFrame: TFrame;
  public
    class function GetFrame: TFrame;
  end;

implementation

{$R *.dfm}

procedure TfrmNCryptEnumKeys.btnExecuteClick(Sender: TObject);
var ErrRet: UInt32;
    dwFlags: UInt32;
    NCryptKeyNamePtr: PNCryptKeyName;
    ppEnumState: PVOID;
    S, FlagsStr: String;

  procedure AddFlag(FlagName: String);
  begin
    if FlagsStr <> '' then
      FlagsStr := FlagsStr + ' or ';

    FlagsStr := FlagsStr + FlagName;
  end;

begin
  lbKeys.Clear;

  dwFlags := 0;
  if cbMachineKeyFlag.Checked then
    dwFlags := dwFlags or NCRYPT_MACHINE_KEY_FLAG;
  if cbSilentFlag.Checked then
    dwFlags := dwFlags or NCRYPT_SILENT_FLAG;

  ppEnumState := nil;
  repeat
    ErrRet := NCryptEnumKeys(TNCryptCNG.hProvider, nil,
      @NCryptKeyNamePtr, @ppEnumState, dwFlags);

    if ErrRet = ERROR_SUCCESS then
    begin
      S := 'KeyName: ' + NCryptKeyNamePtr.pszName + ', ' +
           'AlgId: ' + NCryptKeyNamePtr.pszAlgid + ', ' +
           'dwFlags: ';

      FlagsStr := '';
      if NCryptKeyNamePtr.dwFlags <> 0 then
      begin
        if (NCryptKeyNamePtr.dwFlags and NCRYPT_MACHINE_KEY_FLAG) <> 0 then
          AddFlag('NCRYPT_MACHINE_KEY_FLAG');
        if (NCryptKeyNamePtr.dwFlags and NCRYPT_OVERWRITE_KEY_FLAG) <> 0 then
          AddFlag('NCRYPT_OVERWRITE_KEY_FLAG');
        {if (NCryptKeyNamePtr.dwFlags and NCRYPT_REQUIRE_VBS_FLAG) = 1 then
          AddFlag('NCRYPT_REQUIRE_VBS_FLAG');
        if (NCryptKeyNamePtr.dwFlags and NCRYPT_PREFER_VBS_FLAG) = 1 then
          AddFlag('NCRYPT_PREFER_VBS_FLAG');}

        S := S + FlagsStr;
      end else
        S := S + '0';

      S := S + ', dwLegacyKeySpec: ';
      FlagsStr := '';
      if NCryptKeyNamePtr.dwLegacyKeySpec <> 0 then
      begin
        if (NCryptKeyNamePtr.dwLegacyKeySpec and AT_KEYEXCHANGE) <> 0 then
          AddFlag('AT_KEYEXCHANGE');
        if (NCryptKeyNamePtr.dwLegacyKeySpec and AT_SIGNATURE) <> 0 then
          AddFlag('AT_SIGNATURE');

        S := S + FlagsStr;
      end else
        S := S + '0';

      lbKeys.AddItem(S, TStringObject.Create(NCryptKeyNamePtr.pszName));
    end;
  until ErrRet <> ERROR_SUCCESS;

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);

  NCryptFreeBuffer(ppEnumState);
end;

procedure TfrmNCryptEnumKeys.btnHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'Open',
    'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptenumkeys',
    '', '', SW_SHOWNORMAL);
end;

class function TfrmNCryptEnumKeys.GetFrame: TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  Result := FFrame;
end;

procedure TfrmNCryptEnumKeys.lbKeysDblClick(Sender: TObject);
begin
 if lbKeys.ItemIndex <> -1 then
    Clipboard.AsText := TStringObject(lbKeys.Items.Objects[lbKeys.ItemIndex]).Value;
end;

end.
