unit uControleVenda;

interface

procedure Registrar;

implementation

uses
  Horse,
  System.JSON,
  DataSet.Serialize,
  SysUtils,

  uVenda,
  uConexaoBanco,
  uControle;

var
  App: THorse;
  Venda: TVenda;
  Conexao: TConexaoBanco;
  Controle: TControle;

procedure DoGetAllVenda(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    Conexao  := TConexaoBanco.Create;
    Controle := TControle.Create;
    Venda    := TVenda.Create(Controle);

    Res.Send(Venda.Get.ToJSONArray());

  finally
    Conexao.Free;
    Controle.Free;
    Venda.Free;

  end;
end;

procedure DoGetVenda(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vendaID: Integer;
begin
  try
    Conexao  := TConexaoBanco.Create;
    Controle := TControle.Create;
    Venda    := TVenda.Create(Controle);

    vendaID := Req.Params['venda_id'].ToInteger;
    Res.Send(Venda.Get(vendaID).ToJSONObject());

  finally
    Conexao.Free;
    Controle.Free;
    Venda.Free;

  end;
end;

procedure DoPostVenda(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONPostVenda: TJSONObject;
begin
  try
    Conexao  := TConexaoBanco.Create;
    Controle := TControle.Create;
    Venda    := TVenda.Create(Controle);

    JSONPostVenda := Req.Body<TJSONObject>;

    Venda.SetDataVenda(StrToDate(JSONPostVenda.GetValue('datavenda').Value));
    Venda.SetCliente(StrToInt(JSONPostVenda.GetValue('cliente').Value));

    if Venda.Post then
      Res.Send('CREATED').Status(201)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    Venda.Free;

  end;
end;

procedure DoPutVenda(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONPutVenda: TJSONObject;
begin
  try
    Conexao  := TConexaoBanco.Create;
    Controle := TControle.Create;
    Venda    := TVenda.Create(Controle);

    JSONPutVenda := Req.Body<TJSONObject>;

    Venda.SetID(StrToInt(JSONPutVenda.GetValue('id').Value));
    Venda.SetDataVenda(StrToDate(JSONPutVenda.GetValue('datavenda').Value));
    Venda.SetCliente(StrToInt(JSONPutVenda.GetValue('cliente').Value));

    if Venda.Put then
      Res.Send('ACCEPTED').Status(202)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    Venda.Free;

  end;
end;

procedure DoDeleteVenda(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vendaID: Integer;
begin
  try
    Conexao  := TConexaoBanco.Create;
    Controle := TControle.Create;
    Venda    := TVenda.Create(Controle);

    vendaID := Req.Params['venda_id'].ToInteger;
    if Venda.Delete(vendaID) then
      Res.Send('ACCEPTED').Status(202)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    Venda.Free;

  end;
end;

procedure Registrar;
begin
  THorse.Get('/venda/', DoGetAllVenda);
  THorse.Get('/venda/:venda_id/', DoGetVenda);
  THorse.Post('/venda/', DoPostVenda);
  THorse.Put('/venda/', DoPutVenda);
  THorse.Delete('/venda/:venda_id', DoDeleteVenda);

end;

end.

