unit uVenda;

interface

uses
  uInterfaces,
  uControle,

  Windows,
  SysUtils,
  Classes,
  Data.DB;

type
  TVenda = class(TInterfacedObject, IVenda)

    private
      FID: Integer;
      FDataVenda: TDate;
      FCliente: Integer;

      FControle :TControle;

    public
      constructor Create(pConexaoControle:TControle);
      destructor Destroy; override;

    public
      procedure SetID(const Value: Integer);
      procedure SetDataVenda(const Value: TDate);
      procedure SetCliente(const Value: Integer);

      function GetID: Integer;
      function GetDataVenda: TDate;
      function GetCliente: Integer;

      property ID: Integer read GetID write SetID;
      property DataVenda: TDate read GetDataVenda write SetDataVenda;
      property Cliente: Integer read GetCliente write SetCliente;

    public
      function Get : TDataSet;overload;
      function Get(vendaID: Integer) : TDataSet;overload;
      function Post : Boolean;
      function Put  : Boolean;
      function Delete(vendaID: Integer) : Boolean;

    end;

implementation

{ TCliente }
constructor TVenda.Create(pConexaoControle: TControle);
begin
  FControle := pConexaoControle;
end;

destructor TVenda.Destroy;
begin
  inherited;
end;

function TVenda.Get : TDataSet;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' SELECT * ');
  FControle.sqqGeral.SQL.Add(' FROM Venda ');

  FControle.sqqGeral.Open;

  Result := FControle.SqqGeral;

end;

function TVenda.Get(vendaID: Integer) : TDataSet;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' SELECT * ');
  FControle.sqqGeral.SQL.Add(' FROM Venda ');
  FControle.sqqGeral.SQL.Add(' WHERE ID = :vID ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := vendaID;

  FControle.sqqGeral.Open;

  Result := FControle.SqqGeral;

end;

function TVenda.Post: Boolean;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' INSERT INTO Venda ');
  FControle.sqqGeral.SQL.Add(' VALUES (null, ');
  FControle.sqqGeral.SQL.Add(' :vDataVenda, ');
  FControle.sqqGeral.SQL.Add(' :VCliente) ');

  FControle.sqqGeral.ParamByName('vDataVenda').AsDate := Self.DataVenda;
  FControle.sqqGeral.ParamByName('VCliente').AsInteger := Self.Cliente;

  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;

end;

function TVenda.Put: Boolean;
begin
  FControle.sqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' UPDATE Venda ');
  FControle.sqqGeral.SQL.Add(' SET DataVenda = :vDataVenda, ');
  FControle.sqqGeral.SQL.Add(' Cliente = :vCliente ');
  FControle.sqqGeral.SQL.Add(' WHERE (ID = :vID) ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := Self.ID;
  FControle.sqqGeral.ParamByName('vDataVenda').AsDate := Self.DataVenda;
  FControle.sqqGeral.ParamByName('vCliente').AsInteger := Self.Cliente;

  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;

end;

function TVenda.Delete(vendaID: Integer) : Boolean;
begin
  Fcontrole.SqqGeral.Close;
  FControle.sqqGeral.SQL.Clear;

  FControle.sqqGeral.SQL.Add(' DELETE FROM Venda ');
  FControle.sqqGeral.SQL.Add(' WHERE ID = :vID ');

  FControle.sqqGeral.ParamByName('vID').AsInteger := vendaID;

  try
    FControle.sqqGeral.ExecSQL;
    Result := True;

  except
    Result := False;

  end;
end;

function TVenda.GetID: Integer;
begin
  Result := FID;
end;

function TVenda.GetDataVenda: TDate;
begin
  Result := FDataVenda;
end;

function TVenda.GetCliente: Integer;
begin
  Result := FCliente;
end;

procedure TVenda.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TVenda.SetDataVenda(const Value: TDate);
begin
  FDataVenda := Value;
end;

procedure TVenda.SetCliente(const Value: Integer);
begin
  FCliente := Value;
end;

end.
