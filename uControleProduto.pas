unit uControleProduto;

interface

procedure Registrar;

implementation

uses
  Horse,
  System.JSON,
  DataSet.Serialize,
  SysUtils,

  uProduto,
  uConexaoBanco,
  uControle;

var
  App: THorse;
  Produto: TProduto;
  Conexao: TConexaoBanco;
  Controle: TControle;

procedure DoGetAllProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  try
    Conexao  := TConexaoBanco.Create;
    Controle := TControle.Create;
    Produto  := TProduto.Create(Controle);

    Res.Send(Produto.Get.ToJSONArray());

  finally
    Conexao.Free;
    Controle.Free;
    Produto.Free;

  end;
end;

procedure DoGetProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  produtoID: Integer;
begin
  try
    Conexao    := TConexaoBanco.Create;
    Controle   := TControle.Create;
    Produto    := TProduto.Create(Controle);

    produtoID := Req.Params['produto_id'].ToInteger;
    Res.Send(Produto.Get(produtoID).ToJSONObject());

  finally
    Conexao.Free;
    Controle.Free;
    Produto.Free;

  end;
end;

procedure DoPostProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONPostProduto: TJSONObject;
begin
  try
    Conexao    := TConexaoBanco.Create;
    Controle   := TControle.Create;
    Produto    := TProduto.Create(Controle);

    JSONPostProduto := Req.Body<TJSONObject>;

    Produto.SetNome(JSONPostProduto.GetValue('nome').Value);
    Produto.SetValor(StrToFloat(JSONPostProduto.GetValue('valor').Value));

    if Produto.Post then
      Res.Send('CREATED').Status(201)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    Produto.Free;

  end;
end;

procedure DoPutProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  JSONPutProduto: TJSONObject;
begin
  try
    Conexao    := TConexaoBanco.Create;
    Controle   := TControle.Create;
    Produto    := TProduto.Create(Controle);

    JSONPutProduto := Req.Body<TJSONObject>;

    Produto.SetID(StrToInt(JSONPutProduto.GetValue('id').Value));
    Produto.SetNome(JSONPutProduto.GetValue('nome').Value);
    Produto.SetValor(StrToFloat(JSONPutProduto.GetValue('valor').Value));

    if Produto.Put then
      Res.Send('ACCEPTED').Status(202)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    Produto.Free;

  end;
end;

procedure DoDeleteProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  produtoID: Integer;
begin
  try
    Conexao    := TConexaoBanco.Create;
    Controle   := TControle.Create;
    Produto    := TProduto.Create(Controle);

    produtoID := Req.Params['produto_id'].ToInteger;
    if Produto.Delete(produtoID) then
      Res.Send('ACCEPTED').Status(202)
    else
      Res.Send('INTERNAL SERVER ERROR').Status(500);

  finally
    Conexao.Free;
    Controle.Free;
    Produto.Free;

  end;
end;

procedure Registrar;
begin
  THorse.Get('/produto/', DoGetAllProduto);
  THorse.Get('/produto/:produto_id/', DoGetProduto);
  THorse.Post('/produto/', DoPostProduto);
  THorse.Put('/produto/', DoPutProduto);
  THorse.Delete('/produto/:produto_id', DoDeleteProduto);

end;

end.

