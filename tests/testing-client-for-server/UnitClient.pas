unit UnitClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  System.Win.ScktComp, system.JSON, system.NetEncoding, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TForm1 = class(TForm)
    RichEdit1: TRichEdit;
    RichEdit2: TRichEdit;
    Button1: TButton;
    ClientSocket1: TClientSocket;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    IdHTTP1: TIdHTTP;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
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
var json:TJSONObject;
    str:AnsiString;
begin
//ClientSocket1.Socket.SendText(RichEdit1.Lines.Text);
//json:=TJSONObject.Create;
//json.Parse(TEncoding.UTF8.GetBytes(RichEdit1.Lines.Text),0);
json:=TJSONObject.ParseJSONValue(RichEdit1.Lines.Text, False, True) as TJSONObject;
str:=TNetEncoding.Base64.Encode(json.Format());
//RichEdit2.Lines.Add(str);
//RichEdit2.Lines.Add(TNetEncoding.Base64.Decode(str));
ClientSocket1.Socket.SendText(str);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
ClientSocket1.Active:=False;
ClientSocket1.Host:=Edit1.Text;
ClientSocket1.Port:=StrToInt(Edit2.Text);
ClientSocket1.Active:=True;
end;

procedure TForm1.Button3Click(Sender: TObject);
var message:string;
    msg:TstringStream;
    result:string;

    answareStream: TStringStream;
    answareString: TStringList;

begin
message:='test';
IdHTTP1.Request.ContentType := 'application/json';
IdHTTP1.Request.CharSet := 'utf-8';
IdHTTP1.Request.Method := 'POST';
msg := TStringStream.Create(UTF8Encode(RichEdit1.Lines.Text));

answareStream := TStringStream.Create(UTF8Encode('test'));

//IdHTTP1.Post('http://localhost:80/test/hah/', msg, answareStream);
result := IdHTTP1.Post('http://localhost:80/test/hah/', msg);

//answareStream := IdHTTP1.Response.ContentStream;

//answareString := TStringList.Create;
//answareString.LoadFromStream(answareStream, TEncoding.UTF8);
//ShowMessage(answareString.Text);

ShowMessage(result);
end;

procedure TForm1.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
begin
RichEdit2.Lines.Add(TNetEncoding.Base64.Decode(Socket.ReceiveText));

end;

end.
