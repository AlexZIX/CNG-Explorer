unit uNCryptEnumStorageProviders;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG, Winapi.ShellAPI,
  Vcl.Clipbrd, Helpers;

type
  TfrmNCryptEnumStorageProviders = class(TFrame)
    lblFunctionName: TLabel;
    lblFunctionDescription: TLabel;
    pnlTopSeparator: TPanel;
    btnExecute: TBitBtn;
    Panel1: TPanel;
    leResult: TLabeledEdit;
    edtResultMessage: TEdit;
    btnHelp: TBitBtn;
    cbSilentFlag: TCheckBox;
    lblProviders: TLabel;
    lbProviders: TListBox;
    lblFlags: TLabel;
    procedure btnHelpClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure lbProvidersDblClick(Sender: TObject);
  private
    class var FFrame: TFrame;
  public
    class function GetFrame: TFrame;
  end;

implementation

{$R *.dfm}

procedure TfrmNCryptEnumStorageProviders.btnExecuteClick(Sender: TObject);
var ErrRet, i: UInt32;
    dwFlags, dwProvidersCount: UInt32;
    NCryptProviderNamePtr: PNCryptProviderName;
    NCryptProvidermName: TNCryptProviderName;
    S: String;
begin
  lbProviders.Clear;

  dwFlags := 0;
  if cbSilentFlag.Checked then
    dwFlags := dwFlags or NCRYPT_SILENT_FLAG;

  ErrRet := NCryptEnumStorageProviders(@dwProvidersCount, @NCryptProviderNamePtr, dwFlags);
  if ErrRet = ERROR_SUCCESS then
  begin
    for i := 0 to dwProvidersCount - 1 do
    begin
      Move(Pointer(NativeUInt(NCryptProviderNamePtr) + SizeOf(NCryptProvidermName) * i)^,
        NCryptProvidermName, SizeOf(NCryptProvidermName));

      S := 'Provider name: ' + NCryptProvidermName.pszName + ', ' +
           'Comment: ' + NCryptProvidermName.pszComment;
      lbProviders.AddItem(S, TStringObject.Create(NCryptProvidermName.pszName));
    end;
  end;

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);

  NCryptFreeBuffer(NCryptProviderNamePtr);
end;

procedure TfrmNCryptEnumStorageProviders.btnHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'Open',
    'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptenumstorageproviders',
    '', '', SW_SHOWNORMAL);
end;

class function TfrmNCryptEnumStorageProviders.GetFrame: TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  Result := FFrame;
end;

procedure TfrmNCryptEnumStorageProviders.lbProvidersDblClick(Sender: TObject);
begin
  if lbProviders.ItemIndex <> -1 then
    Clipboard.AsText := TStringObject(lbProviders.Items.Objects[lbProviders.ItemIndex]).Value;
end;

end.
