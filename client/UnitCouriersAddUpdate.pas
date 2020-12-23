unit UnitCouriersAddUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, system.json;

type
  TFormCouriresAddUpdate = class(TForm)
    LabelName: TLabel;
    LabelLogin: TLabel;
    EditName: TEdit;
    EditLogin: TEdit;
    ButtonAdd: TButton;
    ButtonCancel: TButton;
    LabelPass: TLabel;
    EditPass: TEdit;
    HTTPCouriersAddUpdate: TIdHTTP;
    procedure close_();
    procedure ButtonCancelClick(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id : string;
    mode : string;
  end;

var
  FormCouriresAddUpdate: TFormCouriresAddUpdate;

implementation

{$R *.dfm}

uses UnitCouriers, UnitLogin;

procedure TFormCouriresAddUpdate.close_();
begin
  EditName.Text := '';
  EditLogin.Text := '';
  EditPass.Text := '';
  FormCouriers.updatedata;
  close;
end;

procedure TFormCouriresAddUpdate.ButtonAddClick(Sender: TObject);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonResponse : TJSONObject;
  jsonRequest : TJSONObject;
begin
  HTTPCouriersAddUpdate.Request.ContentType := 'application/json';
  HTTPCouriersAddUpdate.Request.CharSet := 'utf-8';


  url := 'http://' + FormLogin.EditIP.Text + '/couriers/'+mode+'/';

  jsonRequest := TJSONObject.Create;
  jsonRequest.AddPair('id', id);
  jsonRequest.AddPair('name',EditName.Text);
  jsonRequest.AddPair('login',EditLogin.Text);
  jsonRequest.AddPair('password',EditPass.Text);

  request := TStringStream.Create(UTF8Encode(jsonRequest.Format()));

  try
    response := HTTPCouriersAddUpdate.Post(url, request);

    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONObject;

    try
      jsonResponse.Values['error'].Value;
      MessageDlg('Логин ' + EditLogin.Text + ' уже сушествует.', mtInformation, [mbOK],0);
    except

    end;


  except
    ShowMessage('Проблемы с соединенем');
  end;
  close_;
end;

procedure TFormCouriresAddUpdate.ButtonCancelClick(Sender: TObject);
begin
  close_;
end;

procedure TFormCouriresAddUpdate.EditChange(Sender: TObject);
begin
if ((EditName.Text <> '') and (EditLogin.Text <> '') and (EditPass.Text <> '')) then
  ButtonAdd.Enabled := True
else
  ButtonAdd.Enabled := False;
end;

procedure TFormCouriresAddUpdate.FormShow(Sender: TObject);
begin
  ButtonAdd.Enabled := False;
end;

end.
