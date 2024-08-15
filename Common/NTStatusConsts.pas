unit NTStatusConsts;

interface

const
  STATUS_SUCCESS = $00000000;
  STATUS_INVALID_PARAMETER = $C000000D;
  STATUS_NOT_FOUND = $C0000225;
  STATUS_NO_MEMORY = $C0000017;
  STATUS_INVALID_HANDLE = $C0000008;
  STATUS_BUFFER_TOO_SMALL = $C0000023;
  STATUS_INVALID_BUFFER_SIZE = $C0000206;
  STATUS_NOT_SUPPORTED = $C0000300;

  NTE_BAD_FLAGS = $80090009;
  NTE_EXISTS = $8009000F;
  NTE_INVALID_HANDLE = $80090026;
  NTE_INVALID_PARAMETER = $80090027;
  NTE_BUFFER_TOO_SMALL = $80090028;
  NTE_NOT_SUPPORTED = $80090029;
  NTE_NO_MEMORY = $8009000E;
  NTE_PERM = $80090010;
  NTE_BAD_KEYSET = $80090016;
  NTE_NO_MORE_ITEMS = $8009002A;
  NTE_SILENT_CONTEXT = $80090022;

implementation

end.
