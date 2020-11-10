unit uControleCliente;

interface

procedure Registrar;

implementation

uses
  Horse,
  System.JSON,
  DataSet.Serialize,
  SysUtils,

  uCliente,
  uConexaoBanco,
  uControle;

var
  App: THorse;
  Cliente: TCliente;
  Conexao: TConexaoBanco;
  Controle: TControle;

procedure DoGetAllCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    Conexao    := TConexaoBanco.Create;
    Controle   := TControle.Create;
    Cliente    := TCliente.Create(Controle);

    Res.Send(Cliente.Get.ToJSONArray());

  finally
    Conexao.Free;
    Controle.Free;
    Cliente.Free;

  end;
end;

procedure DoGetCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  clienteID: Integer;
begin
  try
    Conexao    := TConexaoBanco.Create;
    Controle   := TControle.Create;
    Cliente    := TCliente.Create(Controle);

    clienteID := Req.Params['cliente_id'].ToInteger;
    Res.Send(Cliente.Get(clienteID).ToJSONObject());

  finally
    Conexao.Free;
    Controle.Free;
    Cliente.Free;

  end;
end;

procedure DoPostCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONPostCliente: TJSONObject;
begin
  try
    Conexao    := TConexaoBanco.Create;
    Controle   := TControle.Create;
    Cliente    := TCliente.Create(Controle);

    JSONPostCliente := Req.Body<TJSONObject>;

    Cliente.SetNome(JSONPostCliente.GetValue('nome').Value);
    Cliente.SetDataNascimento(StrToDate(JSONPostCliente.GetValue('datanascimento').Value));
    Cliente.SetDocumento(JSONPostCliente.GetValue('documento').Value);

    if Cliente.Post then
      Res.Send('CREATED').Status(201)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    Cliente.Free;

  end;
end;

procedure DoPutCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONPutCliente: TJSONObject;
begin
  try
    Conexao    := TConexaoBanco.Create;
    Controle   := TControle.Create;
    Cliente    := TCliente.Create(Controle);

    JSONPutCliente := Req.Body<TJSONObject>;

    Cliente.SetID(StrToInt(JSONPutCliente.GetValue('id').Value));
    Cliente.SetNome(JSONPutCliente.GetValue('nome').Value);
    Cliente.SetDataNascimento(StrToDate(JSONPutCliente.GetValue('datanascimento').Value));
    Cliente.SetDocumento(JSONPutCliente.GetValue('documento').Value);

    if Cliente.Put then
      Res.Send('ACCEPTED').Status(202)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    Cliente.Free;

  end;
end;

procedure DoDeleteCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  clienteID: Integer;
begin
  try
    Conexao    := TConexaoBanco.Create;
    Controle   := TControle.Create;
    Cliente    := TCliente.Create(Controle);

    clienteID := Req.Params['cliente_id'].ToInteger;
    if Cliente.Delete(clienteID) then
      Res.Send('ACCEPTED').Status(202)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    Cliente.Free;

  end;
end;

procedure Registrar;
begin
  THorse.Get('/cliente/', DoGetAllCliente);
  THorse.Get('/cliente/:cliente_id/', DoGetCliente);
  THorse.Post('/cliente/', DoPostCliente);
  THorse.Put('/cliente/', DoPutCliente);
  THorse.Delete('/cliente/:cliente_id', DoDeleteCliente);

end;

end.
