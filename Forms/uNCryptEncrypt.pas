unit uNCryptEncrypt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, Vcl.NumberBox, NCryptCNG,
  Winapi.ShellAPI, Vcl.Grids, BCHexEditor, Vcl.Menus, NTStatusConsts;

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
    pmi64zero: TMenuItem;
    pmi32random: TMenuItem;
    pmi64random: TMenuItem;
    lblPaddingAlgorithm: TLabel;
    cbPaddingAlgorithm: TComboBox;
    hePaddingData: TBCHexEditor;
    Label1: TLabel;
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

procedure TfrmNCryptEncrypt.btnExecuteClick(Sender: TObject);
var ErrRet: UInt32;
    dwFlags, cbResult: UInt32;
    inData, outData, paddingData: TBytes;
    memStream: TMemoryStream;
    PaddingInfo: TOAEPPaddingInfo;
    pPaddingInfo: Pointer;
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

      dwFlags := 0;
      if cbNoPadding.Checked then
        dwFlags := dwFlags or NCRYPT_NO_PADDING_FLAG;
      if cbPadOAEP.Checked then
        dwFlags := dwFlags or NCRYPT_PAD_OAEP_FLAG;
      if cbPadPKCS1.Checked then
        dwFlags := dwFlags or NCRYPT_PAD_PKCS1_FLAG;
      if cbSilentFlag.Checked then
        dwFlags := dwFlags or NCRYPT_SILENT_FLAG;

      // Padding info
      pPaddingInfo := nil;
      if cbPadOAEP.Checked then
      begin
        PaddingInfo.pszAlgId := PWideChar(cbPaddingAlgorithm.Text);

        hePaddingData.SaveToStream(memStream);
        SetLength(paddingData, memStream.Size);
        memStream.Position := 0;
        memStream.Read(paddingData[0], memStream.Size);
        memStream.Clear;
        PaddingInfo.pbLabel := @paddingData[0];
        PaddingInfo.cbLabel := Length(paddingData);

        pPaddingInfo := @PaddingInfo;
      end;

      if rgOperation.ItemIndex = 0 then
      begin
        // Get size of buffer for outData
        ErrRet := NCryptEncrypt(TNCryptCNG.hKey, @inData[0], Length(inData),
                    pPaddingInfo, nil, 0, @cbResult, dwFlags);
        if ErrRet = ERROR_SUCCESS then
        begin
          SetLength(outData, cbResult);

          ErrRet := NCryptEncrypt(TNCryptCNG.hKey, @inData[0], Length(inData),
                      pPaddingInfo, @outData[0], Length(outData), @cbResult, dwFlags);
        end;
      end else
      begin
        // Get size of buffer for outData
        ErrRet := NCryptDecrypt(TNCryptCNG.hKey, @inData[0], Length(inData),
                    pPaddingInfo, nil, 0, @cbResult, dwFlags);
        if ErrRet = ERROR_SUCCESS then
        begin
          SetLength(outData, cbResult);

          ErrRet := NCryptDecrypt(TNCryptCNG.hKey, @inData[0], Length(inData),
                      pPaddingInfo, @outData[0], Length(outData), @cbResult, dwFlags);
        end;
      end;

      if ErrRet = ERROR_SUCCESS then
      begin
        memStream.Write(outData[0], cbResult);
        heOutput.LoadFromStream(memStream);
      end;
    end else
      ErrRet := NTE_INVALID_PARAMETER;
  finally
    memStream.Free;
  end;

  leResult.Text := '0x' + IntToHex(ErrRet);
  edtResultMessage.Text := TNCryptCNG.GetErrorDescription(ErrRet);
end;

procedure TfrmNCryptEncrypt.btnHelpClick(Sender: TObject);
begin
  if rgOperation.ItemIndex = 0 then
    ShellExecute(0, 'Open',
      'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptencrypt',
      '', '', SW_SHOWNORMAL)
  else
    ShellExecute(0, 'Open',
      'https://learn.microsoft.com/en-us/windows/win32/api/ncrypt/nf-ncrypt-ncryptdecrypt',
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
