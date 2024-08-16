unit uNCryptEncrypt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG,
  Winapi.ShellAPI, Vcl.Grids, BCHexEditor, Vcl.Menus;

type
  TfrmNCryptEncrypt = class(TFrame)
    lblFunctionName: TLabel;
    lblFunctionDescription: TLabel;
    pnlTopSeparator: TPanel;
    btnExecute: TBitBtn;
    Panel1: TPanel;
    leResult: TLabeledEdit;
    edtResultMessage: TEdit;
    btnHelp: TBitBtn;
    cbPadPKCS1: TCheckBox;
    lblFlags: TLabel;
    cbSilentFlag: TCheckBox;
    cbNoPadding: TCheckBox;
    cbPadOAEP: TCheckBox;
    lblInputData: TLabel;
    heInput: TBCHexEditor;
    heOutput: TBCHexEditor;
    lblOutputData: TLabel;
    rgOperation: TRadioGroup;
    lblOperation: TLabel;
    pmData: TPopupMenu;
    pmiCopy: TMenuItem;
    pmiPaste: TMenuItem;
    N2: TMenuItem;
    pmiClear: TMenuItem;
    N1: TMenuItem;
    pmiFillWith: TMenuItem;
    pmi16zero: TMenuItem;
    pmi32zero: TMenuItem;
    pmi16random: TMenuItem;
    procedure btnHelpClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure pmiCopyClick(Sender: TObject);
    procedure pmiPasteClick(Sender: TObject);
    procedure pmiClearClick(Sender: TObject);
    procedure FillWithData(Sender: TObject);
  private
    ClipboardStream: TMemoryStream;
    class var FFrame: TFrame;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;

    class function GetFrame: TFrame;
  end;

implementation

{$R *.dfm}

procedure TfrmNCryptEncrypt.btnExecuteClick(Sender: TObject);
var ErrRet: UInt32;
    dwFlags, cbResult: UInt32;
    inData, outData: TBytes;
    memStream: TMemoryStream;
begin
  heOutput.DataSize := 0;

  memStream := TMemoryStream.Create;
  try
    if heInput.DataSize > 0 then
    begin
      heInput.SaveToStream(memStream);
      SetLength(inData, memStream.Size);
      memStream.Position := 0;
      memStream.Read(inData[0], memStream.Size);
      memStream.Clear;
    end;

    if Length(inData) < 32 then
      SetLength(outData, 32)
    else
      SetLength(outData, Length(inData) * 2);

    dwFlags := 0;
    if cbNoPadding.Checked then
      dwFlags := dwFlags or NCRYPT_NO_PADDING_FLAG;
    if cbPadOAEP.Checked then
      dwFlags := dwFlags or NCRYPT_PAD_OAEP_FLAG;
    if cbPadPKCS1.Checked then
      dwFlags := dwFlags or NCRYPT_PAD_PKCS1_FLAG;
    if cbSilentFlag.Checked then
      dwFlags := dwFlags or NCRYPT_SILENT_FLAG;

    if rgOperation.ItemIndex = 0 then
      ErrRet := NCryptEncrypt(TNCryptCNG.hKey, @inData[0], Length(inData),
                  nil, @outData[0], Length(outData), @cbResult, dwFlags)
    else
      ErrRet := NCryptDecrypt(TNCryptCNG.hKey, @inData[0], Length(inData),
                  nil, @outData[0], Length(outData), @cbResult, dwFlags);

    if ErrRet = ERROR_SUCCESS then
    begin
      memStream.Write(outData[0], cbResult);
      heOutput.LoadFromStream(memStream);
    end;
  finally
    memStream.Free;
  end;

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);
end;

procedure TfrmNCryptEncrypt.btnHelpClick(Sender: TObject);
begin
  ShellExecute(0, 'Open',
    'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptencrypt',
    '', '', SW_SHOWNORMAL);
end;

constructor TfrmNCryptEncrypt.Create(AOwner: TComponent);
begin
  inherited;

  ClipboardStream := TMemoryStream.Create;
end;

destructor TfrmNCryptEncrypt.Destroy;
begin
  ClipboardStream.Free;

  inherited;
end;

class function TfrmNCryptEncrypt.GetFrame: TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  Result := FFrame;
end;

procedure TfrmNCryptEncrypt.FillWithData(Sender: TObject);
var hePopup: TBCHexEditor;
    FillStream: TMemoryStream;
    FillBytes: TBytes;
    i: Integer;
begin
  hePopup := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent as TBCHexEditor;

  FillStream := TMemoryStream.Create;
  try
    case (Sender as TMenuItem).Tag of
      1: begin
           SetLength(FillBytes, 16);
           FillStream.Write(FillBytes[0], 16);
         end;
      2: begin
           SetLength(FillBytes, 32);
           FillStream.Write(FillBytes[0], 32);
         end;
      3: begin
           SetLength(FillBytes, 16);
           for i := 0 to 15 do
             FillBytes[i] := Random(255);
           FillStream.Write(FillBytes[0], 16);
         end;
    end;

    hePopup.LoadFromStream(FillStream);
  finally
    FillStream.Free;
  end;
end;

procedure TfrmNCryptEncrypt.pmiClearClick(Sender: TObject);
var hePopup: TBCHexEditor;
begin
  hePopup := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent as TBCHexEditor;
  hePopup.DataSize := 0;
end;

procedure TfrmNCryptEncrypt.pmiCopyClick(Sender: TObject);
var hePopup: TBCHexEditor;
begin
  hePopup := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent as TBCHexEditor;
  ClipboardStream.Clear;
  hePopup.SaveToStream(ClipboardStream);
end;

procedure TfrmNCryptEncrypt.pmiPasteClick(Sender: TObject);
var hePopup: TBCHexEditor;
begin
  hePopup := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent as TBCHexEditor;
  hePopup.LoadFromStream(ClipboardStream);
end;

end.
