unit uProduto;

interface

uses
  uInterfaces,
  uControle,

  Windows,
  SysUtils,
  Classes,
  Data.DB;

type
  TProduto = class(TInterfacedObject, IProduto)

    private
      FID: Integer;
      FNome: string;
      FValor: Double;

      FControle :TControle;

    public
      constructor Create(pConexaoControle:TControle);
      destructor Destroy; override;

    public
      procedure SetID(const Value: Integer);
      procedure SetNome(const Value: string);
      procedure SetValor(const Value: Double);

      function GetID: Integer;
      function GetNome: string;
      function GetValor: Double;

      property ID: Integer read GetID write SetID;
      property Nome: string read GetNome write SetNome;
      property Valor: Double read GetValor write SetValor;

    public
      function Get: TDataSet;overload;
      function Get(produtoID: Integer) : TDataSet;overload;
      function Post : Boolean;
      function Put  : Boolean;
      function Delete(produtoID: Integer) : Boolean;

    end;

implementation

{ TCliente }
constructor TProduto.Create(pConexaoControle: TControle);
begin
  FControle := pConexaoControle;
end;

destructor TProduto.Destroy;
begin
  inherited;
end;

function TProduto.Get: TDataSet;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' SELECT * ');
  FControle.sqqGeral.SQL.Add(' FROM Produto ');

  FControle.sqqGeral.Open;

  Result := FControle.SqqGeral;

end;

function TProduto.Get(produtoID: Integer): TDataSet;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' SELECT * ');
  FControle.sqqGeral.SQL.Add(' FROM Produto ');
  FControle.sqqGeral.SQL.Add(' WHERE ID = :vID ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := produtoID;

  FControle.sqqGeral.Open;

  Result := FControle.SqqGeral;

end;

function TProduto.Post: Boolean;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' INSERT INTO Produto ');
  FControle.sqqGeral.SQL.Add(' VALUES (null, ');
  FControle.sqqGeral.SQL.Add(' :vNome, ');
  FControle.sqqGeral.SQL.Add(' :vValor) ');

  FControle.sqqGeral.ParamByName('vNome').AsString := Self.Nome;
  FControle.sqqGeral.ParamByName('vValor').AsFloat := Self.Valor;

  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;

end;

function TProduto.Put: Boolean;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' UPDATE Produto ');
  FControle.sqqGeral.SQL.Add(' SET Nome = :vNome, ');
  FControle.sqqGeral.SQL.Add(' Valor = :vValor ');
  FControle.sqqGeral.SQL.Add(' WHERE (ID = :vID) ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := Self.ID;
  FControle.sqqGeral.ParamByName('vNome').AsString := Self.Nome;
  FControle.sqqGeral.ParamByName('vValor').AsFloat := Self.Valor;
  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;

end;

function TProduto.Delete(produtoID: Integer): Boolean;
begin
  Fcontrole.SqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' DELETE FROM Produto ');
  FControle.sqqGeral.SQL.Add(' WHERE ID = :vID ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := produtoID;

  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;
end;

function TProduto.GetID: Integer;
begin
  Result := FID;
end;

function TProduto.GetNome: string;
begin
  Result := FNome;
end;

function TProduto.GetValor: Double;
begin
  Result := FValor;
end;

procedure TProduto.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TProduto.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TProduto.SetValor(const Value: Double);
begin
  FValor := Value;
end;

end.
