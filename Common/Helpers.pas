unit Helpers;

interface

type
  TStringObject = class
  private
    FValue: String;
  public
    constructor Create(Value: String);

    property Value: String read FValue write FValue;
  end;

implementation

{ TStringObject }

constructor TStringObject.Create(Value: String);
begin
  FValue := Value;
end;

end.
