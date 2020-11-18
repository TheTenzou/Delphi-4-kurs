unit ProductsUtilsUnit;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, IdContext, System.JSON;

function productsList(connectionName : string): String;

implementation

function productsList(connectionName : string): String;
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

  connection.Open;

  connection.StartTransaction;

  query.Active:=False;
  query.SQL.Text:='SELECT id, name, price FROM Products;';
  query.Active:=True;

  jsonArray := TJSONArray.Create;

  while (not query.Eof) do
  begin
    json := TJSONObject.Create;

    for i := 0 to query.FieldDefs.Count-1 do
      begin
        fieldName:=query.FieldDefs[i].Name;
        json.AddPair(fieldName, query.FieldByName(fieldName).AsString);
      end;

    jsonArray.AddElement(json);
    query.Next;
  end;

  result := jsonArray.Format();

end;

end.
