unit ServerUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,

  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, IdContext, System.JSON,

  ProductsUtilsUnit,
  CouriersUtilsUnit,
  OperatorsUtilsUnit,
  OrdersUtilsUnit,
  OrdersInfoUtilsUnit;

type
  TServerForm = class(TForm)
    HTTPServer: TIdHTTPServer;
    PortEdit: TEdit;
    PortLabel: TLabel;
    StartButton: TButton;
    StopButton: TButton;
    StatusMemo: TMemo;
    procedure StartButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure HTTPServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServerForm : TServerForm;
  datePadding : integer;
  ipPadding : integer;
  connectionName : String;

implementation

{$R *.dfm}


procedure TServerForm.FormCreate(Sender: TObject);
var
    params : TStrings;
begin
  PortEdit.Text := '80';
  StopButton.Enabled := False;
  datePadding := 60;
  ipPadding := 40;
  connectionName := 'sqlitePooled';

  params := TStringList.Create;
  params.Add('DriverID=SQLite');
  params.Add('Pooled=True');
  params.Add('SharedCache=False');
  params.Add('LockingMode=Normal');
  params.Add('Database='
              + ExtractFilePath(Application.ExeName)
              + '\DataBase.db');

  FDManager.AddConnectionDef(connectionName,'SQLite', params);

end;

function memoMessage(message_ : string; ip : string): string;
begin
    result := (message_.PadRight(ipPadding)
              + 'IP ' + ip).PadRight(datePadding)
              + 'Время ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now);
end;

procedure TServerForm.HTTPServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  url : string;
  ip : string;
  requestStream : TStream;
  requestString : TStringList;
  responseJson : TJSONObject;
begin
  url := ARequestInfo.URI;
  ip := ARequestInfo.RemoteIP;

  requestStream := ARequestInfo.PostStream;
  requestString := TStringList.Create;
  requestString.LoadFromStream(requestStream, TEncoding.UTF8);

  AResponseInfo.ContentType := 'text/plain';
  AResponseInfo.CharSet := 'utf-8';

  if (url = '/couriers/list/') then begin
    AResponseInfo.ContentText := couriersList(connectionName);
    StatusMemo.Lines.Add(memoMessage('Запрос всех курьеров',ip));
  end
  else if (url = '/couriers/id/') then begin
    AResponseInfo.ContentText := courier(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос курьера',ip));
  end
  else if (url = '/couriers/add/') then begin
    AResponseInfo.ContentText := addCourier(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на добавление курьера',ip));
  end
  else if (url = '/couriers/update/') then begin
    AResponseInfo.ContentText := updateCourier(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на обновление курьера',ip));
  end
  else if (url = '/couriers/delete/') then begin
    AResponseInfo.ContentText := deleteCourier(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на удаление курьера',ip));
  end
  else if (url = '/operators/list/') then begin
    AResponseInfo.ContentText := opearatorsList(connectionName);
    StatusMemo.Lines.Add(memoMessage('Запрос всех операторов',ip));
  end
  else if (url = '/operators/id/') then begin
    AResponseInfo.ContentText := operator_(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос операторa',ip));
  end
  else if (url = '/operators/add/') then begin
    AResponseInfo.ContentText := addOperator(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на добавление операторa',ip));
  end
  else if (url = '/operators/update/') then begin
    AResponseInfo.ContentText := updateOperator(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на обновление операторa',ip));
  end
  else if (url = '/operators/delete/') then begin
    AResponseInfo.ContentText := deleteOperator(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на удаление операторa',ip));
  end
  else if (url = '/orders/list/') then begin
    AResponseInfo.ContentText := ordersList(connectionName);
    StatusMemo.Lines.Add(memoMessage('Запрос всех заказов',ip));
  end
  else if (url = '/orders/id/') then begin
    AResponseInfo.ContentText := order(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос заказа',ip));
  end
  else if (url = '/orders/add/') then begin
    AResponseInfo.ContentText := addorder(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на добавление заказа',ip));
  end
  else if (url = '/orders/update/') then begin
    AResponseInfo.ContentText := updateOrder(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на обновление заказа',ip));
  end
  else if (url = '/orders/delete/') then begin
    AResponseInfo.ContentText := deleteOrder(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на удаление заказа',ip));
  end
  else if (url = '/order-info/list/') then begin
    AResponseInfo.ContentText := orderInfoList(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос всех товаров заказа',ip));
  end
  else if (url = '/order-info/id/') then begin
    AResponseInfo.ContentText := orderInfo(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос таваров из заказа',ip));
  end
  else if (url = '/order-info/add/') then begin
    AResponseInfo.ContentText := addorderInfo(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на добавление товара в заказ',ip));
  end
  else if (url = '/order-info/update/') then begin
    AResponseInfo.ContentText := updateOrderInfo(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на обновление товара в заказе',ip));
  end
  else if (url = '/order-info/delete/') then begin
    AResponseInfo.ContentText := deleteOrderINfo(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на удаление товара из заказа',ip));
  end
  else if (url = '/products/list/') then begin
    AResponseInfo.ContentText := productsList(connectionName);
    StatusMemo.Lines.Add(memoMessage('Запрос всех продуктов',ip));
  end
  else if (url = '/products/id/') then begin
    AResponseInfo.ContentText := product(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос продукта',ip));
  end
  else if (url = '/products/add/') then begin
    AResponseInfo.ContentText := addProduct(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на добавление продукта',ip));
  end
  else if (url = '/products/update/') then begin
    AResponseInfo.ContentText := updateProduct(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на обновление продукта',ip));
  end
  else if (url = '/products/delete/') then begin
    AResponseInfo.ContentText := deleteProduct(connectionName, requestString.Text);
    StatusMemo.Lines.Add(memoMessage('Запрос на удаление продукта',ip));
  end
  else begin
    responseJson := TJSONObject.Create;
    responseJson.AddPair('error','bad url');
    AResponseInfo.ContentText := responseJson.Format();
    StatusMemo.Lines.Add(memoMessage('Не удалось обработать запрос ',ip));
  end;

  requestStream.Free;
  requestString.Free;

end;

procedure TServerForm.StartButtonClick(Sender: TObject);
var
  DBConnection : TFDConnection;
begin
  try
    HTTPServer.DefaultPort := StrToInt(PortEdit.Text);
    HTTPServer.Active := True;

    StatusMemo.Lines.Add(('Сервер запушен на порте: '
                          + PortEdit.Text + '.').PadRight(datePadding)
                          + 'Время ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now));

    StopButton.Enabled := True;

    StartButton.Enabled := False;
    PortEdit.Enabled := False;

    try
      DBConnection := TFDConnection.Create(nil);
      DBConnection.Close;

      DBConnection.ConnectionDefName := connectionName;
      
      DBConnection.Open;
      StatusMemo.Lines.Add('Успешное подлючение к базеданных.'.PadRight(datePadding)
                           + 'Время ' +  FormatDateTime('dd/mm/yyyy hh:mm:ss', Now));

      DBConnection.Close;
    except
      on E : Exception do
      begin
        ShowMessage('Соошени ошибки: '+E.Message);

        StatusMemo.Lines.Add('Ошибка подлючения к базеданных.'.PadRight(datePadding)
                           + 'Время ' +  FormatDateTime('dd/mm/yyyy hh:mm:ss', Now));
        exit;
      end;
    end;

  except
    StatusMemo.Lines.Add(('Ошибка запуска сервера.').PadRight(datePadding)
                          + DateTimeToStr(Now));
  end;
  
end;

procedure TServerForm.StopButtonClick(Sender: TObject);
begin
  try
    HTTPServer.Active := False;

    StatusMemo.Lines.Add('Сервер остановлен.'.PadRight(datePadding)
                          + 'Време ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now));

    StartButton.Enabled := True;
    PortEdit.Enabled := True;

    StopButton.Enabled := False;
  except
     StatusMemo.Lines.Add(('Ошибка остановки сервера.').PadRight(datePadding)
                            + DateTimeToStr(Now));
  end;
end;

end.
