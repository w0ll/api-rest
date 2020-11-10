unit uCliente;

interface

uses
  uInterfaces,
  uControle,

  Windows,
  SysUtils,
  Classes,
  Data.DB;

type
  TCliente = class(TInterfacedObject, ICliente)

    private
      FID: Integer;
      FNome: string;
      FDataNascimento: TDate;
      FDocumento: string;

      FControle :TControle;

    public
      constructor Create(pConexaoControle:TControle);
      destructor Destroy; override;

    public
      procedure SetID(const Value: Integer);
      procedure SetNome(const Value: string);
      procedure SetDataNascimento(const Value: TDate);
      procedure SetDocumento(const Value: string);

      function GetID: Integer;
      function GetNome: string;
      function GetDataNascimento: TDate;
      function GetDocumento: string;

      property ID: Integer read GetID write SetID;
      property Nome: string read GetNome write SetNome;
      property DataNascimento: TDate read GetDataNascimento write SetDataNascimento;
      property Documento: string read GetDocumento write SetDocumento;

    public
      function Get : TDataSet;overload;
      function Get(clienteID: Integer) : TDataSet;overload;
      function Post : Boolean;
      function Put  : Boolean;
      function Delete(clienteID: Integer) : Boolean;

    end;

implementation

{ TCliente }
constructor TCliente.Create(pConexaoControle: TControle);
begin
  FControle := pConexaoControle;
end;

destructor TCliente.Destroy;
begin
  inherited;
end;

function TCliente.Get: TDataSet;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' SELECT * ');
  FControle.sqqGeral.SQL.Add(' FROM Cliente ');

  FControle.sqqGeral.Open;

  Result := FControle.SqqGeral;

end;

function TCliente.Get(clienteID: Integer): TDataSet;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' SELECT * ');
  FControle.sqqGeral.SQL.Add(' FROM Cliente ');
  FControle.sqqGeral.SQL.Add(' WHERE ID = :vID ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := clienteID;

  FControle.sqqGeral.Open;

  Result := FControle.SqqGeral;

end;

function TCliente.Post: Boolean;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' INSERT INTO Cliente ');
  FControle.sqqGeral.SQL.Add(' VALUES (null, ');
  FControle.sqqGeral.SQL.Add(' :vNome, ');
  FControle.sqqGeral.SQL.Add(' :vDataNascimento, ');
  FControle.sqqGeral.SQL.Add(' :vDocumento) ');

  FControle.sqqGeral.ParamByName('vNome').AsString := Self.Nome;
  FControle.sqqGeral.ParamByName('VDataNascimento').AsDate := Self.DataNascimento;
  FControle.sqqGeral.ParamByName('VDocumento').AsString := Self.Documento;

  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;

end;

function TCliente.Put: Boolean;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' UPDATE Cliente ');
  FControle.sqqGeral.SQL.Add(' SET Nome = :vNome, ');
  FControle.sqqGeral.SQL.Add(' DataNascimento = :vDataNascimento, ');
  FControle.sqqGeral.SQL.Add(' Documento = :vDocumento ');
  FControle.sqqGeral.SQL.Add(' WHERE (ID = :vID) ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := Self.ID;
  FControle.sqqGeral.ParamByName('vNome').AsString := Self.Nome;
  FControle.sqqGeral.ParamByName('vDataNascimento').AsDate := Self.DataNascimento;
  FControle.sqqGeral.ParamByName('vDocumento').AsString := Self.Documento;

  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;

end;

function TCliente.Delete(clienteID: Integer): Boolean;
begin
  Fcontrole.SqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' DELETE FROM Cliente ');
  FControle.sqqGeral.SQL.Add(' WHERE ID = :vID ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := clienteID;

  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;
end;

function TCliente.GetDataNascimento: TDate;
begin
  Result := FDataNascimento;
end;

function TCliente.GetDocumento: string;
begin
  Result := FDocumento;
end;

function TCliente.GetID: Integer;
begin
  Result := FID;
end;

function TCliente.GetNome: string;
begin
  Result := FNome;
end;

procedure TCliente.SetDataNascimento(const Value: TDate);
begin
  FDataNascimento := Value;
end;

procedure TCliente.SetDocumento(const Value: string);
begin
  FDocumento := Value;
end;

procedure TCliente.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

end.
