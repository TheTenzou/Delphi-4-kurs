unit UnitOrders;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, system.json;

type
  TFormOrders = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    StringGridOrderInfo: TStringGrid;
    StringGridOrders: TStringGrid;
    HTTPOrders: TIdHTTP;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpdateOrders();
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public

    type
    TRow = Record
        id : string;
        courierid : string;
        courier_name : string;
        operatorid : string;
        operator_name : string;
        created_time : string;
        start_delivery_time : string;
        end_delivery_time : string;
        total_summ : string;
        delivery_address : string;
        verified : string;
      end;
    var
    records : array of TRow;
    { Public declarations }
  end;

var
  FormOrders: TFormOrders;

implementation

{$R *.dfm}

uses UnitLogin, UnitMain;

procedure TFormOrders.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormLogin.close;
end;

procedure TFormOrders.FormCreate(Sender: TObject);
begin
  StringGridOrders.Cols
end;

procedure TFormOrders.FormResize(Sender: TObject);
begin
  StringGridOrderInfo.Height := ClientHeight div 2;
end;

procedure TFormOrders.FormShow(Sender: TObject);
begin
StringGridOrderInfo.Height := ClientHeight div 2;
end;

procedure TFormOrders.N2Click(Sender: TObject);
begin
  FormMain.show;
  hide;
end;

procedure TFormOrders.UpdateOrders();

var
  url : string;
  request : TStringStream;
  response : string;

  jsonObj : TJSONObject;
  jsonResponse : TJSONArray;

  i : integer;
begin
  HTTPOrders.Request.ContentType := 'application/json';
  HTTPOrders.Request.CharSet := 'utf-8';

  url := 'http://' + FormLogin.IP + '/orders/list/';

  request := TStringStream.Create(UTF8Encode(''));

  try
    response := HTTPOrders.Post(url, request);
    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONArray;

    SetLength(records, jsonResponse.Count);

    StringGridOrders.RowCount := 1;

    for i := 0 to jsonResponse.Count-1 do
      begin
        jsonObj := jsonResponse.items[i] as TJSONObject;

        records[i].id := jsonObj.Values['id'].Value;
        records[i].courierid := jsonObj.Values['courierid'].Value;
        records[i].courier_name := jsonObj.Values['courier_name'].Value;
        records[i].operatorid := jsonObj.Values['operatorid'].Value;
        records[i].operator_name := jsonObj.Values['operator_name'].Value;
        records[i].created_time := jsonObj.Values['created_time'].Value;
        records[i].start_delivery_time := jsonObj.Values['start_delivery_time'].Value;
        records[i].end_delivery_time := jsonObj.Values['end_delivery_time'].Value;
        records[i].total_summ := jsonObj.Values['total_summ'].Value;
        records[i].delivery_address := jsonObj.Values['delivery_address'].Value;
        records[i].verified := jsonObj.Values['verified'].Value;

        StringGridOrders.RowCount := StringGridOrders.RowCount + 1;

        StringGridOrders.Cells[0,i+1] := IntToStr(i+1);
        StringGridOrders.Cells[1,i+1] := records[i].courier_name;
        StringGridOrders.Cells[2,i+1] := records[i].operator_name;
        StringGridOrders.Cells[3,i+1] := records[i].created_time;
        StringGridOrders.Cells[4,i+1] := records[i].start_delivery_time;
        StringGridOrders.Cells[6,i+1] := records[i].end_delivery_time;
        StringGridOrders.Cells[7,i+1] := records[i].total_summ;
        StringGridOrders.Cells[8,i+1] := records[i].delivery_address;
        StringGridOrders.Cells[9,i+1] := records[i].verified;
      end;
  except
    ShowMessage('Проблемы с соединенем');
  end;
end;


end.
