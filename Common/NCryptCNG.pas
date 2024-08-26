unit NCryptCNG;

// Delphi implementation of Windows Cryptography API: Next Generation with NCrypt
// Created by Aleksey Pletnev @ Bazis-Center (zix@bazissoft.ru)
// 28.03.2024

interface

uses Winapi.Windows, NTStatusConsts;

type
  BCRYPT_OAEP_PADDING_INFO = packed record
    pszAlgId: LPWSTR;
    pbLabel: PByte;
    cbLabel: UInt32;
  end;

  TNCryptKeyName = packed record
    pszName: LPWSTR;
    pszAlgid: LPWSTR;
    dwLegacyKeySpec: DWORD;
    dwFlags: DWORD;
  end;
  PNCryptKeyName = ^TNCryptKeyName;

  TNCryptCNG = class
  public
    class var hProvider: THandle;
    class var hKey: THandle;

    class function GetErrorDescription(ErrCode: UInt32): String;
  end;

const
  // Don't forget to add this dll into application manifest for prevent dll hijacking
  NCryptDll = 'Ncrypt.dll';

  ERROR_SUCCESS = $00000000;

  NCRYPT_MACHINE_KEY_FLAG = $00000020;      // same as CAPI CRYPT_MACHINE_KEYSET
  NCRYPT_SILENT_FLAG = $00000040;           // same as CAPI CRYPT_SILENT
  NCRYPT_OVERWRITE_KEY_FLAG  = $00000080;
  NCRYPT_WRITE_KEY_TO_LEGACY_STORE_FLAG = $00000200;
  NCRYPT_DO_NOT_FINALIZE_FLAG = $00000400;
  NCRYPT_PERSIST_ONLY_FLAG = $40000000;
  NCRYPT_PERSIST_FLAG = $80000000;
  NCRYPT_REGISTER_NOTIFY_FLAG = $00000001;
  NCRYPT_UNREGISTER_NOTIFY_FLAG = $00000002;
  NCRYPT_NO_KEY_VALIDATION = $00000008;

  // For NCryptEncrypt
  NCRYPT_NO_PADDING_FLAG = $00000001;
  NCRYPT_PAD_PKCS1_FLAG = $00000002;
  NCRYPT_PAD_OAEP_FLAG = $00000004;
  NCRYPT_PAD_PSS_FLAG = $00000008;

  AT_KEYEXCHANGE = $00000001;
  AT_SIGNATURE = $00000002;

  function NCryptOpenStorageProvider(phProvider: Pointer; pszProviderName: PWideChar;
    dwFlags: Dword): UInt32; stdcall; external NCryptDll;
  function NCryptCreatePersistedKey(hProvider: THandle; phKey: Pointer;
    pszAlgId: PWideChar; pszKeyName: PWideChar; dwLegacyKeySpec: DWord;
    dwFlags: DWord): UInt32; stdcall; external NCryptDll;
  function NCryptOpenKey(hProvider: THandle; phKey: Pointer; pszKeyName: PWideChar;
    dwLegacyKeySpec: DWord; dwFlags: DWord): UInt32; stdcall; external NCryptDll;
  function NCryptDeleteKey(hKey: THandle; dwFlags: DWord): UInt32; stdcall; external NCryptDll;
  function NCryptFinalizeKey(hKey: THandle; dwFlags: DWord): UInt32; stdcall; external NCryptDll;
  function NCryptFreeObject(hObject: THandle): UInt32; stdcall; external NCryptDll;
  function NCryptEncrypt(hKey: THandle; pbInput: Pointer; cbInput: ULONG;
    pPaddingInfo: Pointer; pbOutput: Pointer; cbOutput: ULONG;
    pcbResult: Pointer; dwFlags: ULONG): DWORD; stdcall; external NCryptDll;
  function NCryptDecrypt(hKey: THandle; pbInput: Pointer; cbInput: ULONG;
    pPaddingInfo: Pointer; pbOutput: Pointer; cbOutput: ULONG;
    pcbResult: Pointer; dwFlags: ULONG): DWORD; stdcall; external NCryptDll;
  function NCryptEnumKeys(hProvider: THandle; pszScope: LPCWSTR; ppKeyName: Pointer;
    ppEnumState: PVOID; dwFlags: DWORD): DWORD; stdcall; external NCryptDll;
  function NCryptFreeBuffer(pvInput: PVOID): DWORD; stdcall; external NCryptDll;
  function NCryptGetProperty(hObject: THandle; pszProperty: LPCWSTR;
    pbOutput: PByte; cbOutput: DWORD; pcbResult: PDWORD;
    dwFlags: DWORD): DWORD; stdcall; external NCryptDll;
  function NCryptSetProperty(hObject: THandle; pszProperty: LPCWSTR;
    pbInput: PByte; cbInput: DWORD; dwFlags: DWORD): DWORD; stdcall; external NCryptDll;

implementation

{ TNCryptCNG }

class function TNCryptCNG.GetErrorDescription(ErrCode: UInt32): String;
begin
  Result := 'Unknown error';

  case ErrCode of
     ERROR_SUCCESS: Result := 'The function was successful';
     NTE_BAD_FLAGS: Result := 'The dwFlags parameter contains one or more flags that are not supported';
     NTE_INVALID_PARAMETER: Result := 'One or more parameters are not valid';
     NTE_NO_MEMORY: Result := 'A memory allocation failure occurred';
     NTE_INVALID_HANDLE: Result := 'The handle in the hObject parameter is not valid';
     NTE_EXISTS: Result := 'A key with the specified name already exists and the NCRYPT_OVERWRITE_KEY_FLAG was not specified';
     NTE_BAD_KEYSET: Result := 'The specified key was not found';
     NTE_NO_MORE_ITEMS: Result := 'No more data is available';
     NTE_SILENT_CONTEXT: Result := 'Provider could not perform the action because the context was acquired as silent';
     NTE_NOT_SUPPORTED: Result := 'The requested operation is not supported';
     STATUS_INVALID_BUFFER_SIZE: Result := 'Invalid buffer size';
     NTE_BAD_KEY_STATE: Result := 'Key not valid for use in specified state';
     NTE_NOT_FOUND: Result := 'Object was not found';
     NTE_PERM: Result := 'Access denied';
     //NTE_VBS_UNAVAILABLE: Result := 'VBS is unavailable.';
  end;
end;

end.
