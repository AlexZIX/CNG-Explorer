unit uNCryptEncryptDecrypt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.ComCtrls, IdGlobal, Vcl.Grids, BCHexEditor,
  Vcl.Menus;

type
  TfmBzCrypt = class(TFrame)
    lblFunctionName: TLabel;
    lblFunctionDescription: TLabel;
    pnlTopSeparator: TPanel;
    btnExecute: TBitBtn;
    Panel1: TPanel;
    leResult: TLabeledEdit;
    edtResultMessage: TEdit;
    lblOutputData: TLabel;
    cbEncryptionType: TComboBox;
    lblEncryptionType: TLabel;
    heInput: TBCHexEditor;
    heOutput: TBCHexEditor;
    lblInputData: TLabel;
    leSecretDataNum: TLabeledEdit;
    Label1: TLabel;
    heInitV: TBCHexEditor;
    pmData: TPopupMenu;
    pmiCopy: TMenuItem;
    pmiPaste: TMenuItem;
    pmiClear: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    pmiFillWith: TMenuItem;
    pmi16zero: TMenuItem;
    pmi32zero: TMenuItem;
    pmi16random: TMenuItem;
    procedure btnExecuteClick(Sender: TObject);
    procedure pmiCopyClick(Sender: TObject);
    procedure pmiPasteClick(Sender: TObject);
    procedure pmiClearClick(Sender: TObject);
    procedure FillWithData(Sender: TObject);
  private
    ClipboardStream: TMemoryStream;
    class var FFrame: TFrame;
  public
    class function GetFrame: TFrame;
  end;

implementation

{$R *.dfm}
{ TfmBzCrypt }

procedure TfmBzCrypt.btnExecuteClick(Sender: TObject);
var
  InitV, PlainData, EncryptedBytes: TIdBytes;
  ErrRet: UInt16;
  memStream: TMemoryStream;
begin
  heOutput.DataSize := 0;

  memStream := TMemoryStream.Create;
  try
    if heInput.DataSize > 0 then
    begin
      heInput.SaveToStream(memStream);
      SetLength(PlainData, memStream.Size);
      memStream.Position := 0;
      memStream.Read(PlainData[0], memStream.Size);
      memStream.Clear;
    end;

    if heInitV.DataSize > 0 then
    begin
      heInitV.SaveToStream(memStream);
      SetLength(InitV, memStream.Size);
      memStream.Position := 0;
      memStream.Read(InitV[0], memStream.Size);
      memStream.Clear;
    end;

    {ErrRet := FBlsClient.BzCrypt(cbEncryptionType.ItemIndex,
      StrToInt(leSecretDataNum.Text), InitV, PlainData, EncryptedBytes);

    if ErrRet = scSuccess then
    begin
      memStream.Write(EncryptedBytes[0], Length(EncryptedBytes));
      heOutput.LoadFromStream(memStream);
    end;            }
  finally
    memStream.Free;
  end;

  leResult.Text := IntToStr(ErrRet);
end;

procedure TfmBzCrypt.FillWithData(Sender: TObject);
var
  hePopup: TBCHexEditor;
  FillStream: TMemoryStream;
  FillBytes: TBytes;
  i: Integer;
begin
  hePopup := ((Sender as TMenuItem).GetParentMenu as TPopupMenu)
    .PopupComponent as TBCHexEditor;

  FillStream := TMemoryStream.Create;
  try
    case (Sender as TMenuItem).Tag of
      1:
        begin
          SetLength(FillBytes, 16);
          FillStream.Write(FillBytes[0], 16);
        end;
      2:
        begin
          SetLength(FillBytes, 32);
          FillStream.Write(FillBytes[0], 32);
        end;
      3:
        begin
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

class function TfmBzCrypt.GetFrame: TFrame;
begin
  if not Assigned(FFrame) then
    FFrame := Create(nil);

  Result := FFrame;
end;

procedure TfmBzCrypt.pmiClearClick(Sender: TObject);
var
  hePopup: TBCHexEditor;
begin
  hePopup := ((Sender as TMenuItem).GetParentMenu as TPopupMenu)
    .PopupComponent as TBCHexEditor;
  hePopup.DataSize := 0;
end;

procedure TfmBzCrypt.pmiCopyClick(Sender: TObject);
var
  hePopup: TBCHexEditor;
begin
  hePopup := ((Sender as TMenuItem).GetParentMenu as TPopupMenu)
    .PopupComponent as TBCHexEditor;
  ClipboardStream.Clear;
  hePopup.SaveToStream(ClipboardStream);
end;

procedure TfmBzCrypt.pmiPasteClick(Sender: TObject);
var
  hePopup: TBCHexEditor;
begin
  hePopup := ((Sender as TMenuItem).GetParentMenu as TPopupMenu)
    .PopupComponent as TBCHexEditor;
  hePopup.LoadFromStream(ClipboardStream);
end;

end.
