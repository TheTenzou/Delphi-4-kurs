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
function orderNext(connectionName : string; request : string): String;
function addOrder(connectionName : string; request : string): String;
function updateOrder(connectionName : string; request : string): String;
function deleteOrder(connectionName : string; request : string): String;
function completeOrder(connectionName : string; request : string): String;

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
  query.SQL.Text:='SELECT ord.id, '
                        + 'ord.courierid, '
                        + 'co.name as courier_name, '
                        + 'ord.operatorid, '
                        + 'op.name as operator_name, '
                        + 'ord.created_time, '
                        + 'ord.start_delivery_time, '
                        + 'ord.end_delivery_time, '
                        + 'ord.total_summ, '
                        + 'ord.delivery_address '
                        + 'FROM orders as ord, '
                              + 'couriers as co, '
                              + 'operators as op '
                        + 'where ord.courierid = co.id and '
                              + 'ord.operatorid = op.id;';
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
  query.SQL.Text:='SELECT ord.id, '
                        + 'ord.courierid, '
                        + 'co.name as courier_name, '
                        + 'ord.operatorid, '
                        + 'op.name as operator_name, '
                        + 'ord.created_time, '
                        + 'ord.start_delivery_time, '
                        + 'ord.end_delivery_time, '
                        + 'ord.total_summ, '
                        + 'ord.delivery_address '
                        + 'FROM orders as ord, '
                              + 'couriers as co, '
                              + 'operators as op '
                        + 'where ord.courierid = co.id and '
                              + 'ord.operatorid = op.id and '
                              + 'ord.id=' + id +';';
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

function orderNext(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  i : integer;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;
  fieldName : string;
  login : string;
begin
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    login := jsonRequest.Values['login'].Value;
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
  query.SQL.Text:='SELECT ord.id, '
                        + 'ord.courierid, '
                        + 'co.name as courier_name, '
                        + 'ord.operatorid, '
                        + 'op.name as operator_name, '
                        + 'ord.created_time, '
                        + 'ord.start_delivery_time, '
                        + 'ord.end_delivery_time, '
                        + 'ord.total_summ, '
                        + 'ord.delivery_address '
                        + 'FROM orders as ord, '
                              + 'couriers as co, '
                              + 'operators as op '
                        + 'where ord.courierid = co.id and '
                              + 'ord.operatorid = op.id and '
                              + 'ord.end_delivery_time is NULL and '
                              + 'co.login = ''' + login + ''' '
                        + 'order by Created_time ASC '
                        + 'limit 1;';
  query.Active:=True;

  jsonResponse := TJSONObject.Create;

  if query.RowsAffected = 1 then
    begin
      for i := 0 to query.FieldDefs.Count-1 do
      begin
        fieldName:=query.FieldDefs[i].Name.ToLower;
        jsonResponse.AddPair(fieldName, query.FieldByName(fieldName).AsString);
      end;
    end
  else
    begin
      jsonResponse.AddPair('status','no orders to deliver');
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
  deliveryAddress : string;
begin
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;


  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    operatorId := jsonRequest.Values['operatorid'].Value;
    try
      courierId := jsonRequest.Values['courierid'].Value;
      if courierId = '' then
        courierId := 'NULL';
    except
       courierId := 'NULL';
    end;
    createdTime := '''' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) + '''';
    if courierId <> 'NULL' then
      startDileryTime := '''' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) + ''''
    else
      startDileryTime := 'NULL';
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
    query.SQL.Text:='INSERT INTO orders(CourierID, '
                                        + 'OperatorID, '
                                        + 'Created_time, '
                                        + 'Start_delivery_time, '
                                        + 'Total_summ, Delivery_address) '
                                        + 'VALUES( '
                                          + courierId + ', '
                                          + operatorId + ', '
                                          + createdTime + ', '
                                          + startDileryTime + ', '
                                          + '0 , '
                                          + '''' + deliveryAddress + ''');';

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
  startDileryTime : string;
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
    try
      courierId := jsonRequest.Values['courierid'].Value;
      if courierId = '' then
        courierId := 'NULL';
    except
       courierId := 'NULL';
    end;
    operatorId := jsonRequest.Values['operatorid'].Value;

    if courierId <> 'NULL' then
      startDileryTime := '''' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) + ''''
    else
      startDileryTime := 'NULL';

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
    query.SQL.Text:='update orders set courierId=' + courierId + ', '
                                    + 'operatorId=' + operatorId + ', '
                                    + 'start_delivery_time=' + startDileryTime + ', '
                                    + 'delivery_address=''' + deliveryAddress + ''' '
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

end;

function completeOrder(connectionName : string; request : string): String;
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
    query.SQL.Text:='update orders set '
      + 'end_delivery_time=''' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now) + ''' '
                                    + 'where id=' + id + ';';

    query.Execute;
    connection.Commit;
  except
    connection.Rollback;
    jsonResponse := TJSONObject.Create;
    jsonResponse.AddPair('error', 'faild complete');
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

end;

end.

