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
    procedure N3Click(Sender: TObject);
    procedure StringGridProductsClick(Sender: TObject);

  private
    { Private declarations }
  public
    type
    TRow = Record
        id : string;
        name : string;
        price : string;
      end;
    var
    records : array of TRow;
    choos : Integer;
    { Public declarations }
  end;

var
  FormProducts: TFormProducts;

implementation

{$R *.dfm}

uses UnitLogin, UnitMain, UnitProductsAddUpdate, UnitOrderinfoAddUpdate;

procedure TFormProducts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormLogin.close;
end;

procedure TFormProducts.FormCreate(Sender: TObject);
begin
  StringGridProducts.Cells[0,0] := '№';
  StringGridProducts.Cells[1,0] := 'Наименование';
  StringGridProducts.Cells[2,0] := 'Цена';
  StringGridProducts.ColWidths[0] := 40;
  StringGridProducts.ColWidths[1] := 150;
  StringGridProducts.ColWidths[2] := 150;
  StringGridProducts.ColCount := 3;
  n2.Enabled := False;
  n3.Enabled := False;
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
 FormProductsAddUpdate.mode := 'update';
  FormProductsAddUpdate.id := records[StringGridProducts.Row-1].id;
  FormProductsAddUpdate.EditName.Text := records[StringGridProducts.Row-1].name;
  FormProductsAddUpdate.EditPrice.Text := records[StringGridProducts.Row-1].price;
  FormProductsAddUpdate.ShowModal;
end;

procedure TFormProducts.N3Click(Sender: TObject);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonObj : TJSONObject;
  jsonResponse : TJSONArray;

  i : integer;
begin
if (MessageDlg('Удалить товар ' + records[StringGridProducts.Row-1].name + ' ?', mtConfirmation, [mbYes, mbNo],0)=mrYes) then
  begin
    HTTPProducts.Request.ContentType := 'application/json';
    HTTPProducts.Request.CharSet := 'utf-8';

    url := 'http://' + FormLogin.IP + '/products/delete/';

    request := TStringStream.Create(UTF8Encode('{"id":"'+records[StringGridProducts.Row-1].id+'"}'));

    try
      response := HTTPProducts.Post(url, request);
    except
      ShowMessage('Проблемы с соединенем');
    end;
    UpdateData;
  end;
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

procedure TFormProducts.StringGridProductsClick(Sender: TObject);
begin
  if choos = 1 then
    begin
      if StringGridProducts.Row > 0 then
        begin
          n2.Enabled := True;
          n3.Enabled := True;
        end
      else
        begin
          n2.Enabled := False;
          n3.Enabled := False;
        end;
    end
  else if choos = 2 then
    begin
      FormOrderInfoAddUpdate.EditName.Text := records[StringGridProducts.Row-1].name;
      FormOrderInfoAddUpdate.EditPrice.Text := records[StringGridProducts.Row-1].price;
      hide;
    end;

end;

procedure TFormProducts.UpdateData();

var
  url : string;
  request : TStringStream;
  response : string;

  jsonObj : TJSONObject;
  jsonResponse : TJSONArray;

  i : integer;
begin
  HTTPProducts.Request.ContentType := 'application/json';
  HTTPProducts.Request.CharSet := 'utf-8';

  url := 'http://' + FormLogin.IP + '/products/list/';

  request := TStringStream.Create(UTF8Encode(''));

  try
    response := HTTPProducts.Post(url, request);
    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONArray;

    SetLength(records, jsonResponse.Count);

    StringGridProducts.RowCount := 1;

    for i := 0 to jsonResponse.Count-1 do
      begin
        jsonObj := jsonResponse.items[i] as TJSONObject;

        records[i].id := jsonObj.Values['id'].Value;
        records[i].name := jsonObj.Values['name'].Value;
        records[i].price := jsonObj.Values['price'].Value;

        StringGridProducts.RowCount := StringGridProducts.RowCount + 1;

        StringGridProducts.Cells[0,i+1] := IntToStr(i+1);
        StringGridProducts.Cells[1,i+1] := records[i].name;
        StringGridProducts.Cells[2,i+1] := records[i].price;
      end;
  except
    ShowMessage('Проблемы с соединенем');
  end;
end;

end.
