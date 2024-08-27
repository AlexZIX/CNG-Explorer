unit uNCryptSign;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG,
  Winapi.ShellAPI, Vcl.Grids, BCHexEditor, Vcl.Menus, NTStatusConsts;

type
  TfrmNCryptSign = class(TFrame)
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
    cbPadPSS: TCheckBox;
    lblData: TLabel;
    heData: TBCHexEditor;
    heSignature: TBCHexEditor;
    lblSignature: TLabel;
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
    pmi64zero: TMenuItem;
    pmi32random: TMenuItem;
    pmi64random: TMenuItem;
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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    class function GetFrame: TFrame;
  end;

implementation

{$R *.dfm}

procedure TfrmNCryptSign.btnExecuteClick(Sender: TObject);
var ErrRet: UInt32;
    dwFlags, cbResult: UInt32;
    Data, Signature: TBytes;
    memStream: TMemoryStream;
begin
  memStream := TMemoryStream.Create;
  try
    if heData.DataSize > 0 then
    begin
      heData.SaveToStream(memStream);
      SetLength(Data, memStream.Size);
      memStream.Position := 0;
      memStream.Read(Data[0], memStream.Size);
      memStream.Clear;

      if rgOperation.ItemIndex = 1 then
      begin
        heSignature.SaveToStream(memStream);
        SetLength(Signature, memStream.Size);
        memStream.Position := 0;
        memStream.Read(Signature[0], memStream.Size);
        memStream.Clear;
      end else
      begin
        heSignature.DataSize := 0;
        SetLength(Signature, 2048);
      end;

      dwFlags := 0;
      if cbPadPSS.Checked then
        dwFlags := dwFlags or NCRYPT_PAD_PSS_FLAG;
      if cbPadPKCS1.Checked then
        dwFlags := dwFlags or NCRYPT_PAD_PKCS1_FLAG;
      if cbSilentFlag.Checked then
        dwFlags := dwFlags or NCRYPT_SILENT_FLAG;

      if rgOperation.ItemIndex = 0 then
        ErrRet := NCryptSignHash(TNCryptCNG.hKey, nil, @Data[0], Length(Data),
                    @Signature[0], Length(Signature), @cbResult, dwFlags)
      else
        ErrRet := NCryptVerifySignature(TNCryptCNG.hKey, nil, @Data[0], Length(Data),
                    @Signature[0], Length(Signature), dwFlags);

      if (ErrRet = ERROR_SUCCESS) and (rgOperation.ItemIndex = 0) then
      begin
        memStream.Write(Signature[0], cbResult);
        heSignature.LoadFromStream(memStream);
      end
    end else
      ErrRet := NTE_INVALID_PARAMETER;
  finally
    memStream.Free;
  end;

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);
end;

procedure TfrmNCryptSign.btnHelpClick(Sender: TObject);
begin
  if rgOperation.ItemIndex = 0 then
    ShellExecute(0, 'Open',
      'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptsignhash',
      '', '', SW_SHOWNORMAL)
  else
    ShellExecute(0, 'Open',
      'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptverifysignature',
      '', '', SW_SHOWNORMAL);
end;

constructor TfrmNCryptSign.Create(AOwner: TComponent);
begin
  inherited;

  ClipboardStream := TMemoryStream.Create;
end;

destructor TfrmNCryptSign.Destroy;
begin
  ClipboardStream.Free;

  inherited;
end;

class function TfrmNCryptSign.GetFrame: TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  Result := FFrame;
end;

procedure TfrmNCryptSign.FillWithData(Sender: TObject);
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
           SetLength(FillBytes, 64);
           FillStream.Write(FillBytes[0], 64);
         end;
      4: begin
           SetLength(FillBytes, 16);
           for i := 0 to 15 do
             FillBytes[i] := Random(255);
           FillStream.Write(FillBytes[0], 16);
         end;
      5: begin
           SetLength(FillBytes, 32);
           for i := 0 to 31 do
             FillBytes[i] := Random(255);
           FillStream.Write(FillBytes[0], 32);
         end;
      6: begin
           SetLength(FillBytes, 64);
           for i := 0 to 63 do
             FillBytes[i] := Random(255);
           FillStream.Write(FillBytes[0], 64);
         end;
    end;

    hePopup.LoadFromStream(FillStream);
  finally
    FillStream.Free;
  end;
end;

procedure TfrmNCryptSign.pmiClearClick(Sender: TObject);
var hePopup: TBCHexEditor;
begin
  hePopup := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent as TBCHexEditor;
  hePopup.DataSize := 0;
end;

procedure TfrmNCryptSign.pmiCopyClick(Sender: TObject);
var hePopup: TBCHexEditor;
begin
  hePopup := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent as TBCHexEditor;
  ClipboardStream.Clear;
  hePopup.SaveToStream(ClipboardStream);
end;

procedure TfrmNCryptSign.pmiPasteClick(Sender: TObject);
var hePopup: TBCHexEditor;
begin
  hePopup := ((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent as TBCHexEditor;
  hePopup.LoadFromStream(ClipboardStream);
end;

end.
