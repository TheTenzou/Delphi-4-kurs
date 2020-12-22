unit UnitLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.JSON;

type
  TFormLogin = class(TForm)
    LabelLogin: TLabel;
    LabelPass: TLabel;
    EditLogin: TEdit;
    EditPassword: TEdit;
    ButtonLogin: TButton;
    IdHTTPLogin: TIdHTTP;
    LabelIP: TLabel;
    EditIP: TEdit;
    procedure ButtonLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    IP : string;
    login : string;
    password : string;
    operatorId : string;
  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.dfm}

uses UnitMain;

procedure TFormLogin.ButtonLoginClick(Sender: TObject);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonResponse : TJSONObject;
begin
  IdHTTPLogin.Request.ContentType := 'application/json';
  IdHTTPLogin.Request.CharSet := 'utf-8';

  url := 'http://' + EditIP.Text + '/operators/login/';

  request := TStringStream.Create(UTF8Encode('{"login":"' + EditLogin.Text+ '","password":"' + EditPassword.Text + '"}'));

  try
    response := IdHTTPLogin.Post(url, request);

    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONObject;

    if jsonResponse.Values['status'].Value = 'login successfully' then
      begin
        IP := EditIP.Text;
        login := EditLogin.Text;
        password := EditPassword.Text;
        operatorId := jsonResponse.Values['id'].Value;
        FormMain.show;
        Hide;
      end
    else
      ShowMessage('Неправельный логин или пароль');

  except
    ShowMessage('Проблемы с соединенем');
  end;
end;

end.
