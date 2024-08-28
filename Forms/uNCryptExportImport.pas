unit uNCryptExportImport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG,
  Winapi.ShellAPI, Vcl.Grids, BCHexEditor, Vcl.Menus;

type
  TfrmNCryptExportImport = class(TFrame)
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
    heData: TBCHexEditor;
    lblData: TLabel;
    rgOperation: TRadioGroup;
    lblOperation: TLabel;
    lblPropertyName: TLabel;
    cbBlobType: TComboBox;
    procedure btnHelpClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure rgOperationClick(Sender: TObject);
  private
    ClipboardStream: TMemoryStream;
    class var FFrame: TFrame;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    class function GetFrame: TFrame;
  end;

implementation

{$R *.dfm}

procedure TfrmNCryptExportImport.btnExecuteClick(Sender: TObject);
var ErrRet: UInt32;
    dwFlags, cbResult: UInt32;
    Data: TBytes;
    memStream: TMemoryStream;
    hKey: THandle;
begin
  memStream := TMemoryStream.Create;
  try
    dwFlags := 0;
    if cbSilentFlag.Checked then
      dwFlags := dwFlags or NCRYPT_SILENT_FLAG;

    if rgOperation.ItemIndex = 0 then
    begin
      heData.DataSize := 0;
      SetLength(Data, 2048);

      ErrRet := NCryptExportKey(TNCryptCNG.hKey, 0, PWideChar(cbBlobType.Text),
                  nil, @Data[0], Length(Data), @cbResult, dwFlags);

      if ErrRet = ERROR_SUCCESS then
      begin
        memStream.Write(Data[0], cbResult);

        heData.LoadFromStream(memStream);
      end;
    end else
    begin
      heData.SaveToStream(memStream);
      SetLength(Data, memStream.Size);
      memStream.Position := 0;
      memStream.Read(Data[0], memStream.Size);

      ErrRet := NCryptImportKey(TNCryptCNG.hProvider, 0, PWideChar(cbBlobType.Text),
                  nil, @hKey, @Data[0], Length(Data), dwFlags);

      if ErrRet = ERROR_SUCCESS then
        NCryptFreeObject(hKey);
    end;
  finally
    memStream.Free;
  end;

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);
end;

procedure TfrmNCryptExportImport.btnHelpClick(Sender: TObject);
var S: String;
begin
  if rgOperation.ItemIndex = 0 then
    S := 'get'
  else
    S := 'set';

  ShellExecute(0, 'Open',
    PWideChar('https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncrypt' + S + 'property'),
    '', '', SW_SHOWNORMAL);
end;

constructor TfrmNCryptExportImport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ClipboardStream := TMemoryStream.Create;
end;

destructor TfrmNCryptExportImport.Destroy;
begin
  ClipboardStream.Free;

  inherited;
end;

class function TfrmNCryptExportImport.GetFrame: TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  Result := FFrame;
end;

procedure TfrmNCryptExportImport.rgOperationClick(Sender: TObject);
begin
  heData.DataSize := 0;
  heData.ReadOnlyView := rgOperation.ItemIndex = 0;
  heData.InsertMode := rgOperation.ItemIndex = 1;
end;

end.
