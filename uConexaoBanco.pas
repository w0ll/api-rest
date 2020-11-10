unit uConexaoBanco;

interface

uses
  inifiles,

  SysUtils,
  System.Classes,

  FireDAC.Comp.Client,
  FireDAC.Phys.SQLiteWrapper,
  FireDAC.Phys.SQLite,
  FireDAC.Stan.Def,
  FireDAC.DApt,
  FireDAC.Stan.Async;

type
  TConexaoBanco = class
    private
     FConexaoBanco : TFDConnection;

    public
     constructor Create;
     destructor  Destroy; override;

     function GetConexao : TFDConnection;
     property ConexaoBanco : TFDConnection read GetConexao;

  end;

implementation

constructor TConexaoBanco.Create;
var
  Caminho, DriverID, LockingMode : string;
  LocalServer : Integer;
  Configuracoes : TIniFile;

begin
  Configuracoes := TIniFile.Create(ExtractFilePath(ParamStr(0))+ 'config.ini');

  if FileExists(ExtractFilePath(ParamStr(0))+ 'config.ini') then
  begin
    try
      DriverID    := Configuracoes.ReadString('Dados', 'DriverID', DriverID);
      Caminho     := Configuracoes.ReadString('Dados', 'Database', Caminho);
      LockingMode := Configuracoes.ReadString('Dados', 'LockingMode', LockingMode);


    finally
      Configuracoes.Free;

    end;
  end
  else
  begin
    try
      Configuracoes.WriteString('Dados', 'DriverID', 'SQLite');
      Configuracoes.WriteString('Dados', 'Database', ExtractFilePath(ParamStr(0))+ 'desafio_db.db');
      Configuracoes.WriteString('Dados', 'LockingMode', 'Normal');

      DriverID    := Configuracoes.ReadString('Dados', 'DriverID', DriverID);
      Caminho     := Configuracoes.ReadString('Dados', 'Database', Caminho);
      LockingMode := Configuracoes.ReadString('Dados', 'LockingMode', LockingMode);

    finally
      Configuracoes.Free;

    end;
  end;

  FConexaoBanco := TFDConnection.Create(nil);
  FConexaoBanco.Connected  := False;
  FConexaoBanco.Params.Values['DriverID'] := DriverID;
  FConexaoBanco.Params.Values['Database'] := Caminho;
  FConexaoBanco.Params.Values['LockingMode'] := LockingMode;
  FConexaoBanco.Connected  := True;

end;

destructor TConexaoBanco.Destroy;
begin
  FConexaoBanco.Free;
  inherited;

end;

function TConexaoBanco.GetConexao: TFDConnection;
begin
  Result := FConexaoBanco;
end;

end.
