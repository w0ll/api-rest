unit uControleItensVendidos;

interface

procedure Registrar;

implementation

uses
  Horse,
  System.JSON,
  DataSet.Serialize,
  SysUtils,

  uItensVendidos,
  uConexaoBanco,
  uControle;

var
  App: THorse;
  ItensVendidos: TItensVendidos;
  Conexao: TConexaoBanco;
  Controle: TControle;

procedure DoGetAllItensVendidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    Conexao       := TConexaoBanco.Create;
    Controle      := TControle.Create;
    ItensVendidos := TItensVendidos.Create(Controle);

    Res.Send(ItensVendidos.Get.ToJSONArray());

  finally
    Conexao.Free;
    Controle.Free;
    ItensVendidos.Free;

  end;
end;

procedure DoGetItensVendidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  itensvendidosID: Integer;
begin
  try
    Conexao       := TConexaoBanco.Create;
    Controle      := TControle.Create;
    ItensVendidos := TItensVendidos.Create(Controle);

    itensvendidosID := Req.Params['itensvendidos_id'].ToInteger;
    Res.Send(ItensVendidos.Get(itensvendidosID).ToJSONObject());

  finally
    Conexao.Free;
    Controle.Free;
    ItensVendidos.Free;

  end;
end;

procedure DoPostItensVendidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONPostItensVendidos: TJSONObject;
begin
  try
    Conexao       := TConexaoBanco.Create;
    Controle      := TControle.Create;
    ItensVendidos := TItensVendidos.Create(Controle);

    JSONPostItensVendidos := Req.Body<TJSONObject>;

    ItensVendidos.SetProduto(StrToInt(JSONPostItensVendidos.GetValue('produto').Value));
    ItensVendidos.SetVenda(StrToInt(JSONPostItensVendidos.GetValue('venda').Value));
    ItensVendidos.SetQuantidade(StrToFloat(JSONPostItensVendidos.GetValue('quantidade').Value));

    if ItensVendidos.Post then
      Res.Send('CREATED').Status(201)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    ItensVendidos.Free;

  end;
end;

procedure DoPutItensVendidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONPutItensVendidos: TJSONObject;
begin
  try
    Conexao       := TConexaoBanco.Create;
    Controle      := TControle.Create;
    ItensVendidos := TItensVendidos.Create(Controle);

    JSONPutItensVendidos := Req.Body<TJSONObject>;

    ItensVendidos.SetID(StrToInt(JSONPutItensVendidos.GetValue('id').Value));
    ItensVendidos.SetProduto(StrToInt(JSONPutItensVendidos.GetValue('produto').Value));
    ItensVendidos.SetVenda(StrToInt(JSONPutItensVendidos.GetValue('venda').Value));
    ItensVendidos.SetQuantidade(StrToFloat(JSONPutItensVendidos.GetValue('quantidade').Value));

    if ItensVendidos.Put then
      Res.Send('ACCEPTED').Status(202)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    ItensVendidos.Free;

  end;
end;

procedure DoDeleteItensVendidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  itensvendidosID: Integer;
begin
  try
    Conexao       := TConexaoBanco.Create;
    Controle      := TControle.Create;
    ItensVendidos := TItensVendidos.Create(Controle);

    itensvendidosID := Req.Params['itensvendidos_id'].ToInteger;
    if ItensVendidos.Delete(itensvendidosID) then
      Res.Send('ACCEPTED').Status(202)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    ItensVendidos.Free;

  end;
end;

procedure Registrar;
begin
  THorse.Get('/itensvendidos/', DoGetAllItensVendidos);
  THorse.Get('/itensvendidos/:itensvendidos_id/', DoGetItensVendidos);
  THorse.Post('/itensvendidos/', DoPostItensVendidos);
  THorse.Put('/itensvendidos/', DoPutItensVendidos);
  THorse.Delete('/itensvendidos/:itensvendidos_id', DoDeleteItensVendidos);

end;

end.

