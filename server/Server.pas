unit Server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDTransaction1: TFDTransaction;
    DataSource1: TDataSource;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var str,name:String;
    i:Integer;
begin
FDQuery1.Active:=False;
FDQuery1.SQL.Text:='SELECT name, seq FROM sqlite_sequence ;';
FDQuery1.SQL.Text:='SELECT id, name, price FROM Products;';
FDQuery1.Active:=True;
FDQuery1.First;

ShowMessage(IntToStr(FDQuery1.RowsAffected));

while (not FDQuery1.Eof) do
  begin
    str:='';
    for i := 0 to FDQuery1.FieldDefs.Count-1 do
      begin
        name:=FDQuery1.FieldDefs[i].Name;
        str:=str+ ', ' +name +': '+ FDQuery1.FieldByName(name).AsString;
      end;
    ShowMessage(str);
    FDQuery1.Next;
  end;
end;

end.
