unit OrdersInfoUtilsUnit;

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

function orderInfoList(connectionName : string; request : string): String;
function orderInfo(connectionName : string; request : string): String;
function addOrderInfo(connectionName : string; request : string): String;
function updateOrderInfo(connectionName : string; request : string): String;
function deleteOrderInfo(connectionName : string; request : string): String;

implementation

//==============================================================================
function orderInfoList(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  i : integer;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;
  jsonArray : TJSONArray;
  json : TJSONObject;
  fieldName : string;
  orderId : string;
begin
try
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    orderId := jsonRequest.Values['order_id'].Value;
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
  query.SQL.Text:='SELECT * FROM order_info where order_id=' + orderId + ';';
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
except
on E : Exception do
      ShowMessage(E.ClassName+' поднята ошибка, с сообщением : '+E.Message);

end;

end;

//==============================================================================
function orderInfo(connectionName : string; request : string): String;
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
  query.SQL.Text:='SELECT * FROM order_info where id=' + id +';';
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
function addOrderInfo(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;
  orderId : string;
  name : string;
  price : string;
  count : string;
begin
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    orderId := jsonRequest.Values['order_id'].Value;
    name := jsonRequest.Values['name'].Value;
    price := jsonRequest.Values['price'].Value;
    count := jsonRequest.Values['count_'].Value;
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
    query.SQL.Text:='INSERT INTO order_info(order_id, name, price, count_)'
                                  + 'VALUES(' + orderId + ', '
                                       + '''' + name + ''', '
                                              + price + ', '
                                              + count + ');';

    query.Execute;
    connection.Commit;
  except
    connection.Rollback;
    jsonResponse := TJSONObject.Create;
    jsonResponse.AddPair('error', 'bad foreing key');
    result := jsonResponse.Format();
    exit;
  end;

  jsonResponse := TJSONObject.Create;
  jsonResponse.AddPair('status', 'ok');

  result := jsonResponse.Format();

  query.Close;
  connection.Close;
  connection.Free;
  query.Free;
  jsonRequest.Free;

end;

//==============================================================================
function updateOrderInfo(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;
  id : string;
  orderId : string;
  name : string;
  price : string;
  count : string;
begin
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    id := jsonRequest.Values['id'].Value;
    name := jsonRequest.Values['name'].Value;
    price := jsonRequest.Values['price'].Value;
    count := jsonRequest.Values['count_'].Value;
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
    query.SQL.Text:='update order_info set '
                                      + 'name=''' + name + ''', '
                                      + 'price=' + price + ', '
                                      + 'count_=' + count + ' '
                                      + 'where id=' + id + ';';

    query.Execute;
    connection.Commit;
  except
    connection.Rollback;
    jsonResponse := TJSONObject.Create;
    jsonResponse.AddPair('error', 'bad foreing key');
    result := jsonResponse.Format();
    exit;
  end;

  jsonResponse := TJSONObject.Create;
  jsonResponse.AddPair('status', 'ok');

  result := jsonResponse.Format();

  query.Close;
  connection.Close;
  connection.Free;
  query.Free;
  jsonRequest.Free;

end;

//==============================================================================
function deleteOrderInfo(connectionName : string; request : string): String;
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
    query.SQL.Text:='delete from order_info where id=' + id + ';';

    query.Execute;
    connection.Commit;
  except
    connection.Rollback;
    jsonResponse := TJSONObject.Create;
    jsonResponse.AddPair('error', 'field delete');
    result := jsonResponse.Format();
    exit;
  end;

  jsonResponse := TJSONObject.Create;
  jsonResponse.AddPair('status', 'ok');
  result := jsonResponse.Format();

  query.Close;
  connection.Close;
  connection.Free;
  query.Free;
  jsonRequest.Free;

end;

end.
