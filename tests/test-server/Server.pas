unit Server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.StdCtrls,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer, IdContext;

type
  TServerForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label6: TLabel;
    Button2: TButton;
    Memo1: TMemo;
    IdTCPServer1: TIdTCPServer;
    procedure Button1Click(Sender: TObject);
    procedure ServerSocket1Accept(Sender: TObject; Socket: TCustomWinSocket);
    procedure Button2Click(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure IdTCPServer1Execute(AContext: TIdContext);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServerForm: TServerForm;

implementation

{$R *.dfm}




procedure TServerForm.Button1Click(Sender: TObject);
begin
IdTCPServer1.Active:=False;
IdTCPServer1.Bindings.Clear;
IdTCPServer1.Bindings.Add.Port:=StrToInt(Edit1.Text);
IdTCPServer1.Active:=True;

Edit4.Text:='Listening...';
end;

procedure TServerForm.Button2Click(Sender: TObject);
var tmpList:TList;
    contexClient:TIdContext;
begin
//ServerSocket1.Socket.Connections[0].SendText(Edit6.Text);
tmpList:=IdTCPServer1.Contexts.LockList;
contexClient:=tmpList[0];
contexClient.Connection.IOHandler.WriteLn(Edit6.Text);
Memo1.Lines.Add('Me : ' + Edit6.Text);
Edit6.Text:='';
end;

procedure TServerForm.IdTCPServer1Execute(AContext: TIdContext);
begin
Memo1.Lines.Add(AContext.Connection.IOHandler.ReadLn());
end;

procedure TServerForm.ServerSocket1Accept(Sender: TObject;
  Socket: TCustomWinSocket);
begin
CheckBox1.Checked:=True;
Edit2.Text:=Socket.RemoteAddress;
Edit3.Text:=Socket.RemoteHost;
Edit4.Text:='Connected';
Edit5.Text:=Socket.LocalAddress;
end;

procedure TServerForm.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var buf:String;
    size:Integer;
begin
Socket.ReceiveBuf(size, 4);
Socket.ReceiveBuf(buf, size);
Memo1.Lines.Add(buf);
//Memo1.Lines.Add(Socket.RemoteHost + ' : ' + Socket.ReceiveBuf());
end;

end.
