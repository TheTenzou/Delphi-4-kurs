unit TestClientUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TTestClientForm = class(TForm)
    IPAddressLabel: TLabel;
    IPAddressEdit: TEdit;
    PortLabel: TLabel;
    PortEdit: TEdit;
    URLLabel: TLabel;
    URLEdit: TEdit;
    SendButton: TButton;
    RequestMemo: TMemo;
    ResponseMemo: TMemo;
    HTTP: TIdHTTP;
    procedure SendButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestClientForm: TTestClientForm;

implementation

{$R *.dfm}

procedure TTestClientForm.SendButtonClick(Sender: TObject);
var
  request : TStringStream;
  response : string;
  url : string;
begin
HTTP.Request.ContentType := 'application/json';
HTTP.Request.CharSet := 'utf-8';

url := 'http://' + IPAddressEdit.Text + ':' + PortEdit.Text + URLEdit.Text;

request := TStringStream.Create(UTF8Encode(RequestMemo.Lines.Text));

response := HTTP.Post(url, request);

ResponseMemo.Lines.Text := '';
ResponseMemo.Lines.Add(response);
end;

end.
