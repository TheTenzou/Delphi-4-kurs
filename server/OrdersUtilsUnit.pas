unit OrdersUtilsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, IdContext, System.JSON;

function ordersList(connectionName : string): String;
function order(connectionName : string; request : string): String;
function addOrder(connectionName : string; request : string): String;
function updateOrder(connectionName : string; request : string): String;
function deleteOrder(connectionName : string; request : string): String;

implementation


//==============================================================================
function ordersList(connectionName : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  i : integer;
  jsonArray : TJSONArray;
  json : TJSONObject;
  fieldName : string;
begin
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================

  connection.Open;
  connection.StartTransaction;

  query.Active:=False;
  query.SQL.Text:='SELECT * FROM orders;';
  query.Active:=True;

  jsonArray := TJSONArray.Create;

  while (not query.Eof) do
  begin
    json := TJSONObject.Create;

    for i := 0 to query.FieldDefs.Count-1 do
    begin
      fieldName:=query.FieldDefs[i].Name.ToLower;
      json.AddPair(fieldName, query.FieldByName(fieldName).AsString);
    end;

    jsonArray.AddElement(json);
    query.Next;
  end;

  connection.Commit;

  result := jsonArray.Format();

  query.Close;
  connection.Close;
  connection.Free;
  query.Free;

end;

//==============================================================================
function order(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  i : integer;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;
  fieldName : string;
  id : string;
begin
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    id := jsonRequest.Values['id'].Value;
  except
    jsonResponse := TJSONObject.Create;
    jsonResponse.AddPair('error','bad json');
    result := jsonResponse.Format();
    exit;
  end;
  //================================
  connection.Open;
  connection.StartTransaction;

  query.Active:=False;
  query.SQL.Text:='SELECT * FROM orders where id=' + id +';';
  query.Active:=True;

  jsonResponse := TJSONObject.Create;

  for i := 0 to query.FieldDefs.Count-1 do
  begin
    fieldName:=query.FieldDefs[i].Name.ToLower;
    jsonResponse.AddPair(fieldName, query.FieldByName(fieldName).AsString);
  end;

  connection.Commit;

  result := jsonResponse.Format();

  query.Close;
  connection.Close;
  connection.Free;
  query.Free;
  jsonRequest.Free;

end;

//==============================================================================
function addOrder(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;

  courierId : string;
  operatorId : string;
  createdTime : string;
  startDileryTime : string;
  endDeliveryTime : string;
  deliveryAddress : string;
begin
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;


  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    courierId := jsonRequest.Values['courierid'].Value;
    operatorId := jsonRequest.Values['operatorid'].Value;
    createdTime := jsonRequest.Values['created_time'].Value;
    startDileryTime := jsonRequest.Values['start_delivery_time'].Value;
    endDeliveryTime := jsonRequest.Values['end_delivery_time'].Value;
    deliveryAddress := jsonRequest.Values['delivery_address'].Value;
  except
    on E : Exception do
    begin
      jsonResponse := TJSONObject.Create;
      jsonResponse.AddPair('error','bad json');
      result := jsonResponse.Format();
      exit;
    end;
  end;

  //================================
  connection.Open;
  connection.StartTransaction;


  try
    query.Active:=False;
    query.SQL.Clear;
    query.SQL.Text:='INSERT INTO orders(CourierID, '
                                        + 'OperatorID, '
                                        + 'Created_time, '
                                        + 'Start_delivery_time, '
                                        + 'End_delivery_time, '
                                        + 'Total_summ, Delivery_address) '
                                        + 'VALUES( '
                                          + '' + courierId + ', '
                                          + '' + operatorId + ', '
                                          + '''' + startDileryTime + ''', '
                                          + '''' + endDeliveryTime + ''', '
                                          + '''' + endDeliveryTime + ''', '
                                          + '0 , '
                                          + '''' + deliveryAddress + ''');';

    query.Execute;
    connection.Commit;
  except
    on E : Exception do
    begin
      ShowMessage('Соошени ошибки: '+E.Message);
      connection.Rollback;
      exit;
    end;

  end;

  jsonResponse := TJSONObject.Create;
  jsonResponse.AddPair('status', 'ok');
  result := jsonResponse.Format();

  query.Close;
  connection.Close;
  connection.Free;
  query.Free;

end;

//==============================================================================
function updateOrder(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;

  id : string;
  courierId : string;
  operatorId : string;
  createdTime : string;
  startDileryTime : string;
  endDeliveryTime : string;
  deliveryAddress : string;
begin
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    id := jsonRequest.Values['id'].Value;
    courierId := jsonRequest.Values['courierid'].Value;
    operatorId := jsonRequest.Values['operatorid'].Value;
    createdTime := jsonRequest.Values['created_time'].Value;
    startDileryTime := jsonRequest.Values['start_delivery_time'].Value;
    endDeliveryTime := jsonRequest.Values['end_delivery_time'].Value;
    deliveryAddress := jsonRequest.Values['delivery_address'].Value;
  except
    jsonResponse := TJSONObject.Create;
    jsonResponse.AddPair('error','bad json');
    result := jsonResponse.Format();
    exit;
  end;
  //================================
  connection.Open;
  connection.StartTransaction;

  try
    query.Active:=False;
    query.SQL.Clear;
    query.SQL.Text:='update orders set courierId=''' + courierId + ''', '
                                    + 'operatorId=''' + operatorId + ''', '
                                    + 'created_time=''' + createdTime + ''', '
                                    + 'start_delivery_time=''' + startDileryTime + ''', '
                                    + 'end_delivery_time=''' + endDeliveryTime + ''', '
                                    + 'delivery_address=''' + deliveryAddress + ''' '
                                    + 'where id=' + id + ';';

    query.Execute;
    connection.Commit;
  except
    on E : Exception do
    begin
      ShowMessage('Соошени ошибки: '+E.Message);
      connection.Rollback;
      exit;
    end;

  end;

  jsonResponse := TJSONObject.Create;
  jsonResponse.AddPair('status', 'ok');
  result := jsonResponse.Format();

  query.Close;
  connection.Close;
  connection.Free;
  query.Free;

end;

//==============================================================================
function deleteOrder(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;
  id : string;
begin
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    id := jsonRequest.Values['id'].Value;
  except
    jsonResponse := TJSONObject.Create;
    jsonResponse.AddPair('error','bad json');
    result := jsonResponse.Format();
    exit;
  end;
  //================================
  connection.Open;
  connection.StartTransaction;

  try
    query.Active:=False;
    query.SQL.Clear;
    query.SQL.Text:='delete from orders where id=' + id + ';';

    query.Execute;
    connection.Commit;
  except
    on E : Exception do
    begin
      ShowMessage('Соошени ошибки: '+E.Message);
      connection.Rollback;
      exit;
    end;

  end;

  jsonResponse := TJSONObject.Create;
  jsonResponse.AddPair('status', 'ok');
  result := jsonResponse.Format();

  query.Close;
  connection.Close;
  connection.Free;
  query.Free;

end;

end.

