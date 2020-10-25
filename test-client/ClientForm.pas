unit ClientForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdUDPBase,
  IdUDPClient, IdThreadComponent;

type
  TClient = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    IP_label: TLabel;
    port_label: TLabel;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    IdTCPClient1: TIdTCPClient;
    IdThreadComponent1: TIdThreadComponent;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure IdThreadComponent1Run(Sender: TIdThreadComponent);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Client: TClient;

implementation

{$R *.dfm}

procedure TClient.Button1Click(Sender: TObject);
begin
//ClientSocket1.Active:=False;
//ClientSocket1.Host:=Edit1.Text;
//ClientSocket1.Port:=StrToInt(Edit2.Text);
//ClientSocket1.Active:=True;


IdTCPClient1.Host:=Edit1.Text;
IdTCPClient1.Port:=StrToInt(Edit2.Text);
IdTCPClient1.Connect;
if idtcpclient1.Connected=true then
  begin
    idTcpClient1.Socket.WriteLn('Client is connected');
    IdThreadComponent1.Active:=True;
  end;
end;

procedure TClient.Button2Click(Sender: TObject);
var size:Integer;
    buf:string;
begin
//buf:=Edit5.Text;
//size:=Length(buf);
//ClientSocket1.Socket.SendBuf(size, 4);
//ClientSocket1.Socket.SendBuf(buf, size);
//ClientSocket1.Socket.SendText(Edit5.Text);

//IdTCPClient1.Send(Edit5.Text);
IdTCPClient1.IOHandler.Writeln(Edit5.Text);
Memo1.Lines.Add('Me : '+Edit5.Text);
end;

procedure TClient.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
CheckBox1.Checked:=Socket.Connected;
Edit3.Text:=Socket.LocalAddress;
Edit4.Text:=Socket.LocalHost;
Memo1.Lines.Clear;
end;

procedure TClient.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
CheckBox1.Checked:=Socket.Connected;
end;

procedure TClient.IdThreadComponent1Run(Sender: TIdThreadComponent);
begin
Memo1.Lines.Add(IdTCPClient1.IOHandler.ReadLn());
end;

end.
