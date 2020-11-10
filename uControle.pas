unit uControle;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Variants,
  Contnrs,
  StrUtils,
  inifiles,
  uConexaoBanco,
  FireDAC.Comp.Client,
  FireDAC.Stan.Def,
  FireDAC.DApt;

type
  TControle = class
  private
    FConexao  : TConexaoBanco;
    FSqqGeral : TFDQuery;

  public
    constructor Create;
    destructor  Destroy; override;
    property SqqGeral : TFDQuery read FSqqGeral write FSqqGeral;

    procedure VerificarTabelaCliente;
    procedure VerificarTabelaProduto;
    procedure VerificarTabelaVenda;
    procedure VerificarTabelaItensVendidos;

  end;

implementation

constructor TControle.Create;
begin
  FConexao  := TConexaoBanco.Create;
  FSqqGeral := TFDQuery.Create(nil);
  FSqqGeral.Connection := FConexao.ConexaoBanco;

  VerificarTabelaCliente;
  VerificarTabelaProduto;
  VerificarTabelaVenda;
  VerificarTabelaItensVendidos;

end;

destructor TControle.Destroy;
begin
  inherited;
end;

procedure TControle.VerificarTabelaCliente;
begin
  sqqGeral.Close;
  sqqGeral.SQL.Clear;

  sqqGeral.SQL.Add(' SELECT name ');
  sqqGeral.SQL.Add(' FROM sqlite_master ');
  sqqGeral.SQL.Add(' WHERE type= '+ QuotedStr('table'));
  sqqGeral.SQL.Add(' AND name= '+ QuotedStr('Cliente'));

  sqqGeral.Open;

  if SqqGeral.RecordCount = 0 then
  begin
    sqqGeral.Close;
    sqqGeral.SQL.Clear;

    sqqGeral.SQL.Add(' CREATE TABLE Cliente ( ');
	  sqqGeral.SQL.Add(' ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ');
	  sqqGeral.SQL.Add(' Nome VARCHAR(50), ');
	  sqqGeral.SQL.Add(' DataNascimento DATE, ');
	  sqqGeral.SQL.Add(' Documento VARCHAR(14) ); ');

    try
      sqqGeral.ExecSQL;

    finally

    end;

  end;

end;

procedure TControle.VerificarTabelaItensVendidos;
begin
  sqqGeral.Close;
  sqqGeral.SQL.Clear;

  sqqGeral.SQL.Add(' SELECT name ');
  sqqGeral.SQL.Add(' FROM sqlite_master ');
  sqqGeral.SQL.Add(' WHERE type= '+ QuotedStr('table'));
  sqqGeral.SQL.Add(' AND name= '+ QuotedStr('ItensVendidos'));

  sqqGeral.Open;

  if SqqGeral.RecordCount = 0 then
  begin
    sqqGeral.Close;
    sqqGeral.SQL.Clear;

    sqqGeral.SQL.Add(' CREATE TABLE ItensVendidos ( ');
	  sqqGeral.SQL.Add(' ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ');
	  sqqGeral.SQL.Add(' Produto INTEGER, ');
	  sqqGeral.SQL.Add(' Venda INTEGER, ');
	  sqqGeral.SQL.Add(' Quantidade DECIMAL(10 , 2) ); ');

    try
      sqqGeral.ExecSQL;

    finally

    end;

  end;

end;

procedure TControle.VerificarTabelaProduto;
begin
  sqqGeral.Close;
  sqqGeral.SQL.Clear;

  sqqGeral.SQL.Add(' SELECT name ');
  sqqGeral.SQL.Add(' FROM sqlite_master ');
  sqqGeral.SQL.Add(' WHERE type= '+ QuotedStr('table'));
  sqqGeral.SQL.Add(' AND name= '+ QuotedStr('Produto'));

  sqqGeral.Open;

  if SqqGeral.RecordCount = 0 then
  begin
    sqqGeral.Close;
    sqqGeral.SQL.Clear;

    sqqGeral.SQL.Add(' CREATE TABLE Produto ( ');
	  sqqGeral.SQL.Add(' ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ');
	  sqqGeral.SQL.Add(' Nome VARCHAR(50), ');
	  sqqGeral.SQL.Add(' Valor DECIMAL(10 , 2) ); ');

    try
      sqqGeral.ExecSQL;

    finally

    end;

  end;

end;

procedure TControle.VerificarTabelaVenda;
begin
  sqqGeral.Close;
  sqqGeral.SQL.Clear;

  sqqGeral.SQL.Add(' SELECT name ');
  sqqGeral.SQL.Add(' FROM sqlite_master ');
  sqqGeral.SQL.Add(' WHERE type= '+ QuotedStr('table'));
  sqqGeral.SQL.Add(' AND name= '+ QuotedStr('Venda'));

  sqqGeral.Open;

  if SqqGeral.RecordCount = 0 then
  begin
    sqqGeral.Close;
    sqqGeral.SQL.Clear;

    sqqGeral.SQL.Add(' CREATE TABLE Venda ( ');
	  sqqGeral.SQL.Add(' ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ');
	  sqqGeral.SQL.Add(' DataVenda DATE, ');
	  sqqGeral.SQL.Add(' Cliente INTEGER ); ');

    try
      sqqGeral.ExecSQL;

    finally

    end;

  end;

end;

end.
