unit uNCryptOpenStorageProvider;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG, Winapi.ShellAPI;

type
  TfrmNCryptOpenStorageProvider = class(TFrame)
    lblFunctionName: TLabel;
    lblFunctionDescription: TLabel;
    pnlTopSeparator: TPanel;
    btnExecute: TBitBtn;
    Panel1: TPanel;
    leResult: TLabeledEdit;
    edtResultMessage: TEdit;
    lblProviderName: TLabel;
    cbProviderName: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
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

procedure TfrmNCryptOpenStorageProvider.btnExecuteClick(Sender: TObject);
var ErrRet: UInt32;
begin
  ErrRet := NCryptOpenStorageProvider(@TNCryptCNG.hProvider,
    PWideChar(cbProviderName.Text), 0);

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);

  if Assigned(FOnChangePointers) then
    FOnChangePointers(nil);
end;

procedure TfrmNCryptOpenStorageProvider.btnHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'Open',
    'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptopenstorageprovider',
    '', '', SW_SHOWNORMAL);
end;

class function TfrmNCryptOpenStorageProvider.GetFrame(OnChangePointers: TNotifyEvent): TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  FOnChangePointers := OnChangePointers;
  Result := FFrame;
end;

end.
