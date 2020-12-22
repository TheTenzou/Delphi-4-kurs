unit UnitProducts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Data.DB, Vcl.Grids,
  Vcl.DBGrids, REST.Response.Adapter, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, System.JSON,
  Datasnap.DBClient;

type
  TFormProducts = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    HTTPProducts: TIdHTTP;
    N5: TMenuItem;
    StringGridProducts: TStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N4Click(Sender: TObject);
    procedure UpdateData();
    procedure FormShow(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProducts: TFormProducts;

implementation

{$R *.dfm}

uses UnitLogin, UnitMain, UnitProductsAddUpdate;

procedure TFormProducts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormLogin.close;
end;

procedure TFormProducts.FormCreate(Sender: TObject);
begin
  StringGridProducts.Cells[0,0] := '№';
  StringGridProducts.Cells[1,0] := 'Наименование';
  StringGridProducts.Cells[2,0] := 'Цена';
  StringGridProducts.ColWidths[0] := 20;
  StringGridProducts.ColWidths[1] := 150;
  StringGridProducts.ColWidths[2] := 150;
end;

procedure TFormProducts.FormShow(Sender: TObject);
begin
  UpdateData;
end;

procedure TFormProducts.N1Click(Sender: TObject);
begin
  FormProductsAddUpdate.mode := 'add';
  FormProductsAddUpdate.id := '0';
  FormProductsAddUpdate.ShowModal;
end;

procedure TFormProducts.N2Click(Sender: TObject);
begin
ShowMessage(IntToStr(StringGridProducts.Row));
end;

procedure TFormProducts.N4Click(Sender: TObject);
begin
  FormMain.show;
  hide;
end;

procedure TFormProducts.N5Click(Sender: TObject);
begin
  UpdateData;
end;

procedure TFormProducts.UpdateData();
type
  TRow = Record
    id : string;
    name : string;
    price : string;
  end;
var
  url : string;
  request : TStringStream;
  response : string;

  jsonObj : TJSONObject;
  jsonResponse : TJSONArray;

  i : integer;
  records : array of TRow;
begin
  HTTPProducts.Request.ContentType := 'application/json';
  HTTPProducts.Request.CharSet := 'utf-8';

  url := 'http://' + FormLogin.IP + '/products/list/';

  request := TStringStream.Create(UTF8Encode(''));

  try
    response := HTTPProducts.Post(url, request);
    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONArray;

    SetLength(records, jsonResponse.Size);

    for i := 0 to jsonResponse.Size-1 do
      begin
        jsonObj := jsonResponse.Get(i) as TJSONObject;

        records[i].id := jsonObj.Values['id'].Value;
        records[i].name := jsonObj.Values['name'].Value;
        records[i].price := jsonObj.Values['price'].Value;

        StringGridProducts.Cells[0,i+1] := IntToStr(i+1);
        StringGridProducts.Cells[1,i+1] := records[i].name;
        StringGridProducts.Cells[2,i+1] := records[i].price;

        StringGridProducts.RowCount := StringGridProducts.RowCount + 1;
      end;
  except
    ShowMessage('Проблемы с соединенем');
  end;
end;

end.
