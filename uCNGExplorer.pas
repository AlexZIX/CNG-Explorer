unit uCNGExplorer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, System.IOUtils, System.IniFiles, uNCryptCreatePersistedKey,
  uNCryptOpenStorageProvider, NCryptCNG, uNCryptFreeObject;

type
  TfrmMain = class(TForm)
    tvFunctions: TTreeView;
    pnlFrames: TPanel;
    lbPointers: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure tvFunctionsChange(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
  private
    SelectedFrame: TFrame;
    SelectedFrameIndex: Integer;

    procedure LoadSettings;
    procedure SaveSettings;

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

  LoadSettings;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if Assigned(SelectedFrame) then
    FreeAndNil(SelectedFrame);

  SaveSettings;
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
      4: SelectedFrame := TfrmNCryptOpenStorageProvider.GetFrame(OnChangePointers);
      5: SelectedFrame := TfrmNCryptFreeObject.GetFrame(OnChangePointers);
    end;

    SelectedFrameIndex := Node.SelectedIndex;

    SelectedFrame.Align := alClient;
    SelectedFrame.Parent := pnlFrames;
  end;
end;

end.
