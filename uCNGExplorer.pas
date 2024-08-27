unit uCNGExplorer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, System.IOUtils, System.IniFiles, uNCryptCreatePersistedKey,
  uNCryptOpenStorageProvider, NCryptCNG, uNCryptFreeObject, uNCryptFinalizeKey,
  uNCryptDeleteKey, uNCryptOpenKey, uNCryptEnumKeys, uNCryptEncrypt, uNCryptProperty,
  Winapi.ShellAPI, uNCryptSign, uNCryptEnumAlgorithms;

type
  TfrmMain = class(TForm)
    tvFunctions: TTreeView;
    pnlFrames: TPanel;
    lbPointers: TListBox;
    pnlCopyrights: TPanel;
    lblAuthor: TLabel;
    lblGithubLink: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tvFunctionsChange(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
    procedure lblGithubLinkClick(Sender: TObject);
  private
    SelectedFrame: TFrame;
    SelectedFrameIndex: Integer;

    procedure LoadSettings;
    procedure SaveSettings;

    procedure GetAppVersion;

    procedure OnChangePointers(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  tvFunctions.FullExpand;
  GetAppVersion;

  LoadSettings;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if Assigned(SelectedFrame) then
    FreeAndNil(SelectedFrame);

  SaveSettings;
end;

procedure TfrmMain.GetAppVersion;
var S, SS, AppVer, AppDate: string;
    D: TDateTime;
    FileName: string;
    VSize, VIHandle: longword;
    pcBuf: PChar;
    pcValue: Pointer;
    M: array [0 .. 1] of Word;
begin
  AppVer := '';
  AppDate := '';
  FileName := Application.EXEName + chr(0);
  VSize := GetFileVersionInfoSize(@FileName[1], VIHandle);
  pcBuf := AllocMem(VSize);
  try
    if GetFileVersionInfo(@FileName[1], 0, VSize, pcBuf) then
    begin
      if VerQueryValue(pcBuf, PChar('\VarFileInfo\Translation'), pcValue,
        VIHandle) then
      begin
        Move(pcValue^, M, 4);
        s := Format('%x', [M[0]]);
        while Length(s) < 4 do
          s := '0' + s;
        ss := Format('%x', [M[1]]);
        while Length(ss) < 4 do
          ss := '0' + ss;
        s := s + ss;
        if VerQueryValue(pcBuf, PChar('StringFileInfo\' + s + '\FileVersion'),
          pcValue, VIHandle) then
        begin
          SetLength(AppVer, VIHandle - 1);
          Move(pcValue^, AppVer[1], (VIHandle - 1) * 2);
        end;
      end;
    end;
    ss := Application.EXEName;
    FileAge(ss, D);
    AppDate := DateToStr(D);
  finally
    FreeMem(pcBuf);
  end;

  Caption := Caption + ' v.' + AppVer + ' (' + AppDate + ')';
end;

procedure TfrmMain.lblGithubLinkClick(Sender: TObject);
begin
  ShellExecute(0, 'Open',
    'https://github.com/AlexZIX/CNG-Explorer',
    '', '', SW_SHOWNORMAL);
end;

procedure TfrmMain.LoadSettings;
begin
  with TIniFile.Create(TPath.GetHomePath + '\Bazis\CNGExplorer.ini') do
  try
    frmMain.Left := ReadInteger('MainForm', 'Left', 0);
    frmMain.Top := ReadInteger('MainForm', 'Top', 0);
  finally
    Free;
  end;
end;

procedure TfrmMain.OnChangePointers(Sender: TObject);
begin
  lbPointers.Clear;

  if TNCryptCNG.hProvider <> 0 then
    lbPointers.Items.Add('hProvider = $' + IntToHex(TNCryptCNG.hProvider));

  if TNCryptCNG.hKey <> 0 then
    lbPointers.Items.Add('hKey = $' + IntToHex(TNCryptCNG.hKey));
end;

procedure TfrmMain.SaveSettings;
begin
  with TIniFile.Create(TPath.GetHomePath + '\Bazis\CNGExplorer.ini') do
  try
    WriteInteger('MainForm', 'Left', frmMain.Left);
    WriteInteger('MainForm', 'Top', frmMain.Top);
  finally
    Free;
  end;
end;

procedure TfrmMain.tvFunctionsChange(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(SelectedFrame) and (SelectedFrameIndex <> Node.SelectedIndex) then
    SelectedFrame.Parent := nil;

  if Node.SelectedIndex <> 0 then
  begin  
    case Node.SelectedIndex of
      1: SelectedFrame := TfrmNCryptCreatePersistedKey.GetFrame;
      2: SelectedFrame := TfrmNCryptFinalizeKey.GetFrame;
      3: SelectedFrame := TfrmNCryptEncrypt.GetFrame;
      4: SelectedFrame := TfrmNCryptOpenStorageProvider.GetFrame(OnChangePointers);
      5: SelectedFrame := TfrmNCryptFreeObject.GetFrame(OnChangePointers);
      6: SelectedFrame := TfrmNCryptDeleteKey.GetFrame(OnChangePointers);
      7: SelectedFrame := TfrmNCryptOpenKey.GetFrame(OnChangePointers);
      8: SelectedFrame := TfrmNCryptEnumKeys.GetFrame;
      9: SelectedFrame := TfrmNCryptProperty.GetFrame;
     10: SelectedFrame := TfrmNCryptSign.GetFrame;
     11: SelectedFrame := TfrmNCryptEnumAlgorithms.GetFrame;
    end;

    SelectedFrameIndex := Node.SelectedIndex;

    SelectedFrame.Align := alClient;
    SelectedFrame.Parent := pnlFrames;
  end;
end;

end.
