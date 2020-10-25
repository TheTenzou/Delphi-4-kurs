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
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  System.Win.ScktComp, System.JSON, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    ServerSocket1: TServerSocket;
    Edit1: TEdit;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    RichEdit1: TRichEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Button3Click(Sender: TObject);

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

FDConnection1.Close;
FDConnection1.Params.Clear;
FDConnection1.Params.Add('DriverID=SQLite');
FDConnection1.Params.Add('Database='+ExtractFilePath(Application.ExeName)+'\DataBase.db');
try
  FDConnection1.Open;
  ShowMessage('database open');
except
  ShowMessage('nope');
  exit;
end;

FDConnection1.StartTransaction;
try
  FDQuery1.Active:=False;
  FDQuery1.SQL.Text:='SELECT name, seq FROM sqlite_sequence ;';
  FDQuery1.SQL.Text:='SELECT id, name, price FROM Products;';
  FDQuery1.Active:=True;
  FDQuery1.First;
  FDConnection1.Commit;
except
  FDConnection1.Rollback;
end;

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

procedure TForm1.Button2Click(Sender: TObject);
begin
ServerSocket1.Active:=False;
ServerSocket1.Port:=StrToInt(Edit1.Text);
ServerSocket1.Active:=True;
end;

procedure TForm1.Button3Click(Sender: TObject);
var JsonObject: TJSONObject;
begin
  JsonObject:=TJSONObject.Create;
  JsonObject.AddPair('hello','world');
  RichEdit1.Lines.Add(JsonObject.Format());
  ShowMessage(RichEdit1.Lines.Text);
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
if (Edit1.Text <> '') then
  Button2.Enabled:=True
else
  Button2.Enabled:=False;

end;

procedure TForm1.FormActivate(Sender: TObject);
begin
Button2.Enabled:=False;
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
//
end;

end.
