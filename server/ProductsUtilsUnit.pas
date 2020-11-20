unit ProductsUtilsUnit;

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

function productsList(connectionName : string): String;
function product(connectionName : string; request : string): String;
function addProduct(connectionName : string; request : string): String;
function updateProduct(connectionName : string; request : string): String;
function deleteProduct(connectionName : string; request : string): String;

implementation

//==============================================================================
function productsList(connectionName : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  i : integer;
  jsonArray : TJSONArray;
  json : TJSONObject;
  fieldName : string;
  res : string;
begin
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================

  connection.Open;
  connection.StartTransaction;

  query.Active:=False;
  query.SQL.Text:='SELECT * FROM Products;';
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
  json.Free;

end;

//==============================================================================
function product(connectionName : string; request : string): String;
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
  query.SQL.Text:='SELECT * FROM Products where id=' + id +';';
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
function addProduct(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;
  name : string;
  price : string;
begin
  connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    name := jsonRequest.Values['name'].Value;
    price := jsonRequest.Values['price'].Value;
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
    query.SQL.Text:='INSERT INTO Products(name,price) VALUES(''' + name +''', '
                                                                 + price + ');';

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
  jsonRequest.Free;

end;

//==============================================================================
function updateProduct(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;
  id : string;
  name : string;
  price : string;
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
    query.SQL.Text:='update products set name=''' + name + ''', '
                                        + 'price=' + price + ' '
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
  jsonRequest.Free;

end;

//==============================================================================
function deleteProduct(connectionName : string; request : string): String;
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
    query.SQL.Text:='delete from products where id=' + id + ';';

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
  jsonRequest.Free;

end;

end.
