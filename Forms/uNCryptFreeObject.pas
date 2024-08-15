unit uNCryptFreeObject;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG, Winapi.ShellAPI;

type
  TfrmNCryptFreeObject = class(TFrame)
    lblFunctionName: TLabel;
    lblFunctionDescription: TLabel;
    pnlTopSeparator: TPanel;
    btnExecute: TBitBtn;
    Panel1: TPanel;
    leResult: TLabeledEdit;
    edtResultMessage: TEdit;
    lblProviderName: TLabel;
    cbHandle: TComboBox;
    btnHelp: TBitBtn;
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

procedure TfrmNCryptFreeObject.btnExecuteClick(Sender: TObject);
var ErrRet: UInt32;
begin
  if cbHandle.ItemIndex = 0 then
  begin
    ErrRet := NCryptFreeObject(TNCryptCNG.hProvider);
    TNCryptCNG.hProvider := 0;
  end else
  begin
    ErrRet := NCryptFreeObject(TNCryptCNG.hKey);
    TNCryptCNG.hKey := 0;
  end;

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);

  if Assigned(FOnChangePointers) then
    FOnChangePointers(nil);
end;

procedure TfrmNCryptFreeObject.btnHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'Open',
    'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptfreeobject',
    '', '', SW_SHOWNORMAL);
end;

class function TfrmNCryptFreeObject.GetFrame(OnChangePointers: TNotifyEvent): TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  FOnChangePointers := OnChangePointers;
  Result := FFrame;
end;

end.
