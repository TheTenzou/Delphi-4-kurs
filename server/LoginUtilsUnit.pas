unit LoginUtilsUnit;
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

  function operatorLogin(connectionName : string; request : string): String;
  function courierLogin(connectionName : string; request : string): String;

implementation

function operatorLogin(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;
  login : string;
  password : string;
begin
connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    login := jsonRequest.Values['login'].Value;
    password := jsonRequest.Values['password'].Value;
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
    query.SQL.Text:='SELECT * FROM operators where login=''' + login +''' and '
                                                + 'password=''' + password + ''';';

    query.Active:=True;

    jsonResponse := TJSONObject.Create;
    if (query.RowsAffected = 1) then
    begin
      jsonResponse.AddPair('status', 'login successfully');
    end
    else
    begin
      jsonResponse.AddPair('status', 'login faild');
    end;
    result := jsonResponse.Format();

    connection.Commit;
  except
    on E : Exception do
    begin
      ShowMessage('Ñîîøåíè îøèáêè: '+E.Message);
      connection.Rollback;
      exit;
    end;

  end;

  query.Close;
  connection.Close;
  connection.Free;
  query.Free;
  jsonRequest.Free;

end;

function courierLogin(connectionName : string; request : string): String;
var
  connection : TFDConnection;
  query : TFDQuery;
  jsonRequest : TJSONObject;
  jsonResponse : TJSONObject;
  login : string;
  password : string;
begin
connection := TFDConnection.Create(nil);
  connection.ConnectionDefName := connectionName;

  query := TFDQuery.Create(nil);
  query.Connection := connection;
  //================================
  try
    jsonRequest := TJSONObject.ParseJSONValue(request, False, True) as TJSONObject;
    login := jsonRequest.Values['login'].Value;
    password := jsonRequest.Values['password'].Value;
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
    query.SQL.Text:='SELECT * FROM couriers where login=''' + login +''' and '
                                                + 'password=''' + password + ''';';

    query.Active:=True;

    jsonResponse := TJSONObject.Create;
    if (query.RowsAffected = 1) then
    begin
      jsonResponse.AddPair('status', 'login successfully');
    end
    else
    begin
      jsonResponse.AddPair('status', 'login faild');
    end;
    result := jsonResponse.Format();

    connection.Commit;
  except
    on E : Exception do
    begin
      ShowMessage('Ñîîøåíè îøèáêè: '+E.Message);
      connection.Rollback;
      exit;
    end;

  end;

  query.Close;
  connection.Close;
  connection.Free;
  query.Free;
  jsonRequest.Free;

end;


end.
