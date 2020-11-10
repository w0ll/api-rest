unit uItensVendidos;

interface

uses
  uInterfaces,
  uControle,

  Windows,
  SysUtils,
  Classes,
  Data.DB;

type
  TItensVendidos = class(TInterfacedObject, IItensVendidos)

    private
      FID: Integer;
      FProduto: Integer;
      FVenda: Integer;
      FQuantidade: Double;

      FControle :TControle;

    public
      constructor Create(pConexaoControle:TControle);
      destructor Destroy; override;

    public
      procedure SetID(const Value: Integer);
      procedure SetProduto(const Value: Integer);
      procedure SetVenda(const Value: Integer);
      procedure SetQuantidade(const Value: Double);

      function GetID: Integer;
      function GetProduto: Integer;
      function GetVenda: Integer;
      function GetQuantidade: Double;

      property ID: Integer read GetID write SetID;
      property Produto: Integer read GetVenda write SetProduto;
      property Venda: Integer read GetVenda write SetVenda;
      property Quantidade: Double read GetQuantidade write SetQuantidade;

    public
      function Get : TDataSet;overload;
      function Get(itensvendidosID: Integer) : TDataSet;overload;
      function Post : Boolean;
      function Put  : Boolean;
      function Delete(itensvendidosID: Integer) :Boolean;

    end;

implementation

{ TCliente }
constructor TItensVendidos.Create(pConexaoControle: TControle);
begin
  FControle := pConexaoControle;
end;

destructor TItensVendidos.Destroy;
begin
  inherited;
end;

function TItensVendidos.Get: TDataSet;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' SELECT * ');
  FControle.sqqGeral.SQL.Add(' FROM ItensVendidos ');

  FControle.sqqGeral.Open;

  Result := FControle.SqqGeral;

end;

function TItensVendidos.Get(itensvendidosID: Integer): TDataSet;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' SELECT * ');
  FControle.sqqGeral.SQL.Add(' FROM ItensVendidos ');
  FControle.sqqGeral.SQL.Add(' WHERE ID = :vID ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := itensvendidosID;

  FControle.sqqGeral.Open;

  Result := FControle.SqqGeral;

end;

function TItensVendidos.Post: Boolean;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' INSERT INTO ItensVendidos ');
  FControle.sqqGeral.SQL.Add(' VALUES (null, ');
  FControle.sqqGeral.SQL.Add(' :vProduto, ');
  FControle.sqqGeral.SQL.Add(' :vVenda, ');
  FControle.sqqGeral.SQL.Add(' :vQuantidade) ');

  FControle.sqqGeral.ParamByName('vProduto').AsInteger := Self.Produto;
  FControle.sqqGeral.ParamByName('vVenda').AsInteger := Self.Venda;
  FControle.sqqGeral.ParamByName('vQuantidade').AsFloat := Self.Quantidade;

  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;

end;

function TItensVendidos.Put: Boolean;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' UPDATE ItensVendidos ');
  FControle.sqqGeral.SQL.Add(' SET Produto = :vProduto, ');
  FControle.sqqGeral.SQL.Add(' Venda = :vVenda, ');
  FControle.sqqGeral.SQL.Add(' Quantidade = :vQuantidade ');
  FControle.sqqGeral.SQL.Add(' WHERE (ID = :vID) ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := Self.ID;
  FControle.sqqGeral.ParamByName('vProduto').AsInteger := Self.Produto;
  FControle.sqqGeral.ParamByName('vVenda').AsInteger := Self.Venda;
  FControle.sqqGeral.ParamByName('vQuantidade').AsFloat := Self.Quantidade;

  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;

end;

function TItensVendidos.Delete(itensvendidosID: Integer): Boolean;
begin
  Fcontrole.SqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' DELETE FROM ItensVendidos ');
  FControle.sqqGeral.SQL.Add(' WHERE ID = :vID ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := itensvendidosID;

  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;
end;

function TItensVendidos.GetID: Integer;
begin
  Result := FID;
end;

function TItensVendidos.GetProduto: Integer;
begin
  Result := FProduto;
end;

function TItensVendidos.GetVenda: Integer;
begin
  Result := FVenda;
end;

function TItensVendidos.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

procedure TItensVendidos.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TItensVendidos.SetProduto(const Value: Integer);
begin
  FProduto := Value;
end;

procedure TItensVendidos.SetVenda(const Value: Integer);
begin
  FVenda := Value;
end;

procedure TItensVendidos.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

end.
