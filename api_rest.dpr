program api_rest;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.BasicAuthentication,
  DataSet.Serialize,

  System.SysUtils,
  DateUtils,
  System.JSON,

  uInterfaces in 'uInterfaces.pas',
  uCliente in 'uCliente.pas',
  uConexaoBanco in 'uConexaoBanco.pas',
  uControle in 'uControle.pas',
  uVenda in 'uVenda.pas',
  uProduto in 'uProduto.pas',
  uItensVendidos in 'uItensVendidos.pas',
  uControleCliente in 'uControleCliente.pas',
  uControleProduto in 'uControleProduto.pas',
  uControleVenda in 'uControleVenda.pas',
  uControleItensVendidos in 'uControleItensVendidos.pas';

var
  App: THorse;

begin
  App := THorse.Create(9000);
  App.Use(Jhonson);
  App.Use(HorseBasicAuthentication(
    function(const AUsername, APassword: string): Boolean
    begin
      Result := AUsername.Equals('usuario') and APassword.Equals('senha');
    end));

  FormatSettings.dateseparator := '-';

  uControleCliente.Registrar;
  uControleProduto.Registrar;
  uControleVenda.Registrar;
  uControleItensVendidos.Registrar;

  App.Start;

end.
