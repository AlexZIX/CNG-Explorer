unit uNCryptProperty;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG,
  Winapi.ShellAPI, Vcl.Grids, BCHexEditor, Vcl.Menus;

type
  TfrmNCryptProperty = class(TFrame)
    lblFunctionName: TLabel;
    lblFunctionDescription: TLabel;
    pnlTopSeparator: TPanel;
    btnExecute: TBitBtn;
    Panel1: TPanel;
    leResult: TLabeledEdit;
    edtResultMessage: TEdit;
    btnHelp: TBitBtn;
    cbPersistOnly: TCheckBox;
    lblFlags: TLabel;
    cbSilentFlag: TCheckBox;
    heData: TBCHexEditor;
    lblData: TLabel;
    rgOperation: TRadioGroup;
    lblOperation: TLabel;
    lblPropertyName: TLabel;
    lblObject: TLabel;
    cbHandle: TComboBox;
    cbPropertyName: TComboBox;
    btnHelpPropertyName: TBitBtn;
    leData: TLabeledEdit;
    procedure btnHelpClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure rgOperationClick(Sender: TObject);
    procedure btnHelpPropertyNameClick(Sender: TObject);
    procedure leDataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure heDataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmNCryptProperty.btnExecuteClick(Sender: TObject);
var ErrRet: UInt32;
    dwFlags, cbResult: UInt32;
    Data: TBytes;
    memStream: TMemoryStream;
    ObjectHandle: THandle;
    S: String;
begin
  memStream := TMemoryStream.Create;
  try
    dwFlags := 0;
    if cbPersistOnly.Checked then
      dwFlags := dwFlags or NCRYPT_PERSIST_ONLY_FLAG;
    if cbSilentFlag.Checked then
      dwFlags := dwFlags or NCRYPT_SILENT_FLAG;

    if cbHandle.ItemIndex = 0 then
      ObjectHandle := TNCryptCNG.hProvider
    else
      ObjectHandle := TNCryptCNG.hKey;

    if rgOperation.ItemIndex = 0 then
    begin
      leData.Text := '';
      heData.DataSize := 0;
      SetLength(Data, 2048);

      ErrRet := NCryptGetProperty(ObjectHandle, PWideChar(cbPropertyName.Text),
                  @Data[0], 2048, @cbResult, dwFlags);

      if ErrRet = ERROR_SUCCESS then
      begin
        memStream.Write(Data[0], cbResult);

        // Load data to HEX edit
        heData.LoadFromStream(memStream);

        // Load data to TEXT edit
        memStream.Position := 0;
        SetLength(S, memStream.Size div 2);
        memStream.Read(S[1], memStream.Size);
        leData.Text := S;
      end;
    end else
    begin
      heData.SaveToStream(memStream);
      SetLength(Data, memStream.Size);
      memStream.Position := 0;
      memStream.Read(Data[0], memStream.Size);

      ErrRet := NCryptSetProperty(ObjectHandle, PWideChar(cbPropertyName.Text),
                  @Data[0], Length(Data), dwFlags);
    end;
  finally
    memStream.Free;
  end;

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);
end;

procedure TfrmNCryptProperty.btnHelpClick(Sender: TObject);
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

procedure TfrmNCryptProperty.btnHelpPropertyNameClick(Sender: TObject);
begin
  ShellExecute(0, 'Open',
    'https://learn.microsoft.com/en-us/windows/win32/SecCNG/key-storage-property-identifiers',
    '', '', SW_SHOWNORMAL);
end;

constructor TfrmNCryptProperty.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ClipboardStream := TMemoryStream.Create;
end;

destructor TfrmNCryptProperty.Destroy;
begin
  ClipboardStream.Free;

  inherited;
end;

class function TfrmNCryptProperty.GetFrame: TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  Result := FFrame;
end;

procedure TfrmNCryptProperty.heDataKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var memStream: TMemoryStream;
    S: String;
    TextLen: UInt16;
begin
  if not heData.ReadOnlyView then
  begin
    memStream := TMemoryStream.Create;
    try
      heData.SaveToStream(memStream);
      memStream.Position := 0;
      TextLen := memStream.Size div 2;
      if TextLen < 2 then
        TextLen := 2;
      SetLength(S, TextLen);
      memStream.Read(S[1], memStream.Size);
      leData.Text := S;
    finally
      memStream.Free;
    end;
  end;
end;

procedure TfrmNCryptProperty.leDataKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var memStream: TMemoryStream;
    S: String;
begin
  if not leData.ReadOnly then
  begin
    memStream := TMemoryStream.Create;
    try
      S := leData.Text + #0;
      memStream.Write(S[1], Length(S) * 2);
      heData.LoadFromStream(memStream);
    finally
      memStream.Free;
    end;
  end;
end;

procedure TfrmNCryptProperty.rgOperationClick(Sender: TObject);
begin
  heData.DataSize := 0;
  leData.Text := '';
  heData.ReadOnlyView := rgOperation.ItemIndex = 0;
  heData.InsertMode := rgOperation.ItemIndex = 1;
  leData.ReadOnly := rgOperation.ItemIndex = 0;
end;

end.
