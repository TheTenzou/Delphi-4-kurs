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
    N3: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpdateOrders();
    procedure UpdateOrderInfo();
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure StringGridOrdersClick(Sender: TObject);
    procedure StringGridOrdersDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure N3Click(Sender: TObject);
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
    TRowInfo = Record
      id : string;
      order_id : string;
      name : string;
      price : string;
      count_ : string;
    End;
    var
    records : array of TRow;
    recordsInfo : array of TRowInfo;
    infoId : string;
    { Public declarations }
  end;

var
  FormOrders: TFormOrders;

implementation

{$R *.dfm}

uses UnitLogin, UnitMain, UnitOrderAdd;

procedure TFormOrders.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormLogin.close;
end;

procedure TFormOrders.FormCreate(Sender: TObject);
begin
  StringGridOrders.ColCount := 9;
  StringGridOrders.RowCount := 1;
  StringGridOrders.Cells[0,0] := '№';
  StringGridOrders.Cells[1,0] := 'Курьер';
  StringGridOrders.Cells[2,0] := 'Оператор';
  StringGridOrders.Cells[3,0] := 'Время создания';
  StringGridOrders.Cells[4,0] := 'Время начала доставки';
  StringGridOrders.Cells[5,0] := 'Время окончания доставки';
  StringGridOrders.Cells[6,0] := 'Сумма';
  StringGridOrders.Cells[7,0] := 'Адрес доставки';
  StringGridOrders.Cells[8,0] := 'Состояние';

  StringGridOrders.ColWidths[0] := 40;
  StringGridOrders.ColWidths[1] := 150;
  StringGridOrders.ColWidths[2] := 150;
  StringGridOrders.ColWidths[3] := 150;
  StringGridOrders.ColWidths[4] := 150;
  StringGridOrders.ColWidths[5] := 150;
  StringGridOrders.ColWidths[6] := 150;
  StringGridOrders.ColWidths[7] := 150;
  StringGridOrders.ColWidths[8] := 150;

  StringGridOrderInfo.ColCount := 4;
  StringGridOrderInfo.RowCount := 1;

  StringGridOrderInfo.Cells[0,0] := '№';
  StringGridOrderInfo.Cells[1,0] := 'Наименование';
  StringGridOrderInfo.Cells[2,0] := 'Цена';
  StringGridOrderInfo.Cells[3,0] := 'Колличество';


  StringGridOrderInfo.ColWidths[0] := 40;
  StringGridOrderInfo.ColWidths[1] := 150;
  StringGridOrderInfo.ColWidths[2] := 150;
  StringGridOrderInfo.ColWidths[3] := 150;
  //n2.Enabled := False;
  //n3.Enabled := False;
end;

procedure TFormOrders.FormResize(Sender: TObject);
begin
  StringGridOrderInfo.Height := ClientHeight div 2;
end;

procedure TFormOrders.FormShow(Sender: TObject);
begin
  StringGridOrderInfo.Height := ClientHeight div 2;
  UpdateOrders;
end;

procedure TFormOrders.N1Click(Sender: TObject);
begin
  UpdateOrders;
end;

procedure TFormOrders.N2Click(Sender: TObject);
begin
  FormMain.show;
  hide;
end;

procedure TFormOrders.N3Click(Sender: TObject);
begin
  FormAddOrder.showModal();
  UpdateOrders;
end;

procedure TFormOrders.StringGridOrdersClick(Sender: TObject);
begin
  if StringGridOrders.Row > 0 then
    begin
      infoId := records[StringGridOrders.Row-1].id;
      UpdateOrderInfo;
    end;
end;

procedure TFormOrders.StringGridOrdersDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
if (ACol = 8) and (ARow <> 0) then
    with TStringGrid(Sender) do
    begin
      if Cells[ACol, Arow] = 'заказ создан' then
      begin
        Canvas.Brush.Color := RGB(150,150,150);
        Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol, ARow]);
      end
      else if Cells[ACol, Arow] = 'назначен не доставлен' then
      begin
        Canvas.Brush.Color := RGB(200,50,50);
        Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol, ARow]);
      end
      else if Cells[ACol, Arow] = 'доставлен курьером' then
      begin
        Canvas.Brush.Color := RGB(50,50,200);
        Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol, ARow]);
      end
      else if Cells[ACol, Arow] = 'подтверждён курьером' then
      begin
        Canvas.Brush.Color := RGB(50,200,50);
        Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol, ARow]);
      end;
    end;
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
        StringGridOrders.Cells[5,i+1] := records[i].end_delivery_time;
        StringGridOrders.Cells[6,i+1] := records[i].total_summ;
        StringGridOrders.Cells[7,i+1] := records[i].delivery_address;
        //StringGridOrders.Cells[8,i+1] := records[i].verified;
        case StrToInt(records[i].verified) of
          0 : StringGridOrders.Cells[8,i+1] := 'заказ создан';
          1 : StringGridOrders.Cells[8,i+1] := 'назначен не доставлен';
          2 : StringGridOrders.Cells[8,i+1] := 'доставлен курьером';
          3 : StringGridOrders.Cells[8,i+1] := 'подтверждён курьером';
        end;

      end;
  except
    ShowMessage('Ïðîáëåìû ñ ñîåäèíåíåì');
  end;
end;

procedure TFormOrders.UpdateOrderInfo();

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

  url := 'http://' + FormLogin.IP + '/order-info/list/';

  request := TStringStream.Create(UTF8Encode('{"order_id":"'+infoId+'"}'));

  try
    response := HTTPOrders.Post(url, request);
    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONArray;

    SetLength(recordsInfo, jsonResponse.Count);

    StringGridOrderInfo.RowCount := 1;

    for i := 0 to jsonResponse.Count-1 do
      begin
        jsonObj := jsonResponse.items[i] as TJSONObject;

        recordsInfo[i].id := jsonObj.Values['id'].Value;
        recordsInfo[i].order_id := jsonObj.Values['order_id'].Value;
        recordsInfo[i].name := jsonObj.Values['name'].Value;
        recordsInfo[i].price := jsonObj.Values['price'].Value;
        recordsInfo[i].count_ := jsonObj.Values['count_'].Value;

        StringGridOrderInfo.RowCount := StringGridOrderInfo.RowCount + 1;

        StringGridOrderInfo.Cells[0,i+1] := IntToStr(i+1);
        StringGridOrderInfo.Cells[1,i+1] := recordsInfo[i].name;
        StringGridOrderInfo.Cells[2,i+1] := recordsInfo[i].price;
        StringGridOrderInfo.Cells[3,i+1] := recordsInfo[i].count_;
      end;
  except
  on E : Exception do
      ShowMessage(E.ClassName+' поднята ошибка, с сообщением : '+E.Message);
    //ShowMessage('Ïðîáëåìû ñ ñîåäèíåíåì');
  end;
end;



end.
