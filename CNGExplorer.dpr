program CNGExplorer;



uses
  Vcl.Forms,
  uCNGExplorer in 'uCNGExplorer.pas' {frmMain},
  uNCryptEncryptDecrypt in 'Forms\uNCryptEncryptDecrypt.pas',
  NCryptCNG in 'Common\NCryptCNG.pas',
  NTStatusConsts in 'Common\NTStatusConsts.pas',
  uNCryptOpenStorageProvider in 'Forms\uNCryptOpenStorageProvider.pas',
  uNCryptFreeObject in 'Forms\uNCryptFreeObject.pas',
  uNCryptCreatePersistedKey in 'Forms\uNCryptCreatePersistedKey.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
