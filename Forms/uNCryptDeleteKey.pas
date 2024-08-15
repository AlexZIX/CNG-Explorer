unit uNCryptDeleteKey;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG, Winapi.ShellAPI;

type
  TfrmNCryptDeleteKey = class(TFrame)
    lblFunctionName: TLabel;
    lblFunctionDescription: TLabel;
    pnlTopSeparator: TPanel;
    btnExecute: TBitBtn;
    Panel1: TPanel;
    leResult: TLabeledEdit;
    edtResultMessage: TEdit;
    btnHelp: TBitBtn;
    lblFlags: TLabel;
    cbSilentFlag: TCheckBox;
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

procedure TfrmNCryptDeleteKey.btnExecuteClick(Sender: TObject);
var ErrRet: UInt32;
    dwFlags: UInt32;
begin
  dwFlags := 0;
  if cbSilentFlag.Checked then
    dwFlags := dwFlags or NCRYPT_SILENT_FLAG;

  ErrRet := NCryptDeleteKey(TNCryptCNG.hKey, dwFlags);

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);

  if ErrRet = ERROR_SUCCESS then
  begin
    TNCryptCNG.hKey := 0;

    if Assigned(FOnChangePointers) then
      FOnChangePointers(nil);
  end;
end;

procedure TfrmNCryptDeleteKey.btnHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'Open',
    'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptdeletekey',
    '', '', SW_SHOWNORMAL);
end;

class function TfrmNCryptDeleteKey.GetFrame(OnChangePointers: TNotifyEvent): TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  FOnChangePointers := OnChangePointers;
  Result := FFrame;
end;

end.
