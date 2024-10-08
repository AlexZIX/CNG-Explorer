program CNGExplorer;



uses
  Vcl.Forms,
  uCNGExplorer in 'uCNGExplorer.pas' {frmMain},
  NCryptCNG in 'Common\NCryptCNG.pas',
  NTStatusConsts in 'Common\NTStatusConsts.pas',
  uNCryptOpenStorageProvider in 'Forms\uNCryptOpenStorageProvider.pas',
  uNCryptFreeObject in 'Forms\uNCryptFreeObject.pas',
  uNCryptCreatePersistedKey in 'Forms\uNCryptCreatePersistedKey.pas',
  uNCryptFinalizeKey in 'Forms\uNCryptFinalizeKey.pas',
  uNCryptDeleteKey in 'Forms\uNCryptDeleteKey.pas',
  uNCryptOpenKey in 'Forms\uNCryptOpenKey.pas',
  uNCryptEnumKeys in 'Forms\uNCryptEnumKeys.pas',
  uNCryptEncrypt in 'Forms\uNCryptEncrypt.pas',
  uNCryptProperty in 'Forms\uNCryptProperty.pas',
  uNCryptSign in 'Forms\uNCryptSign.pas',
  uNCryptEnumAlgorithms in 'Forms\uNCryptEnumAlgorithms.pas',
  uNCryptExportImport in 'Forms\uNCryptExportImport.pas',
  uNCryptEnumStorageProviders in 'Forms\uNCryptEnumStorageProviders.pas',
  Helpers in 'Common\Helpers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
