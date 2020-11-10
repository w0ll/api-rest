unit uInterfaces;

interface

type
  ICliente = interface
    ['{FA60411D-BE6A-444C-A6F7-0A3D571837F4}']

    procedure SetID(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetDataNascimento(const Value: TDate);
    procedure SetDocumento(const Value: string);

    function GetID: Integer;
    function GetNome: string;
    function GetDataNascimento: TDate;
    function GetDocumento: string;

    property ID: Integer read GetID write SetID;
    property Nome: string read GetNome write SetNome;
    property DataNascimento: TDate read GetDataNascimento write SetDataNascimento;
    property Documento: string read GetDocumento write SetDocumento;

  end;

  IProduto = interface
    ['{80F2C0F3-F333-4416-AE4E-EF1F8CC1DE4C}']

    procedure SetID(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetValor(const Value: Double);

    function GetID: Integer;
    function GetNome: string;
    function GetValor: Double;

    property ID: Integer read GetID write SetID;
    property Nome: string read GetNome write SetNome;
    property Valor: Double read GetValor write SetValor;

  end;

  IVenda = interface
    ['{5E3CEBFB-2A22-4027-8CD3-A98739BF8ED2}']

    procedure SetID(const Value: Integer);
    procedure SetDataVenda(const Value: TDate);
    procedure SetCliente(const Value: Integer);

    function GetID: Integer;
    function GetDataVenda: TDate;
    function GetCliente: Integer;

    property ID: Integer read GetID write SetID;
    property DataVenda: TDate read GetDataVenda write SetDataVenda;
    property Cliente: Integer read GetCliente write SetCliente;

  end;

  IItensVendidos = interface
    ['{FF8E3C4A-C09A-4D7B-9D8B-021032DF01F4}']

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

  end;

implementation

end.
