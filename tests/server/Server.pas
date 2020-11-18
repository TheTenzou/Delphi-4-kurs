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
  System.Win.ScktComp, System.JSON, Vcl.ComCtrls, system.NetEncoding,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer, IdContext;

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
    IdHTTPServer1: TIdHTTPServer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Button3Click(Sender: TObject);
    procedure IdHTTPServer1CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure FormCreate(Sender: TObject);

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

procedure TForm1.FormCreate(Sender: TObject);
begin
IdHTTPServer1.Active:=True;
end;

procedure TForm1.IdHTTPServer1CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
stream: TStream;
str1: TStringList;

answareStream: TStringStream;
answareString: TStringList;

begin
//ShowMessage('context' + AContext.ToString);
ShowMessage(ARequestInfo.URI);
stream := ARequestInfo.PostStream;

str1 := TStringList.Create;
str1.LoadFromStream(stream, TEncoding.UTF8);

//SetString(str, PChar(stream), stream.Size div SizeOf(Char));
ShowMessage(str1.Text);

AResponseInfo.ResponseNo := 200;
AResponseInfo.ContentType := 'text/plain';
AResponseInfo.CharSet := 'utf-8';
AResponseInfo.ContentText:='dsfответa';
AResponseInfo.ContentLength := -1;


//answareString := TStringList.Create;
//answareString.Add('asdf фыа');
//answareStream := TStringStream.Create(UTF8Encode(answareString.Text));
//AResponseInfo.ContentType := 'application/json';
//AResponseInfo.CharSet := 'utf-8';
//AResponseInfo.ContentStream:= answareStream;
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var JsonObject: TJSONObject;
begin
ShowMessage(TNetEncoding.Base64.Decode(Socket.ReceiveText()));
JsonObject:=TJSONObject.Create;
JsonObject.AddPair('answare','ответ');
Socket.SendText(TNetEncoding.Base64.Encode(JsonObject.Format()));
end;

end.
