unit UnitOperatorsAddUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, system.json;

type
  TFormOperatorsAddUpdate = class(TForm)
    LabelName: TLabel;
    LabelLogin: TLabel;
    LabelPass: TLabel;
    EditName: TEdit;
    EditLogin: TEdit;
    ButtonAdd: TButton;
    ButtonCancel: TButton;
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
  FormOperatorsAddUpdate: TFormOperatorsAddUpdate;

implementation

{$R *.dfm}

uses UnitOperators, UnitLogin;

procedure TFormOperatorsAddUpdate.close_();
begin
  EditName.Text := '';
  EditLogin.Text := '';
  EditPass.Text := '';
  FormOperators.updatedata;
  close;
end;

procedure TFormOperatorsAddUpdate.ButtonAddClick(Sender: TObject);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonResponse : TJSONObject;
  jsonRequest : TJSONObject;
begin
  HTTPCouriersAddUpdate.Request.ContentType := 'application/json';
  HTTPCouriersAddUpdate.Request.CharSet := 'utf-8';


  url := 'http://' + FormLogin.EditIP.Text + '/operators/'+mode+'/';

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

procedure TFormOperatorsAddUpdate.ButtonCancelClick(Sender: TObject);
begin
  close_;
end;

procedure TFormOperatorsAddUpdate.EditChange(Sender: TObject);
begin
if ((EditName.Text <> '') and (EditLogin.Text <> '') and (EditPass.Text <> '')) then
  ButtonAdd.Enabled := True
else
  ButtonAdd.Enabled := False;
end;

procedure TFormOperatorsAddUpdate.FormShow(Sender: TObject);
begin
  ButtonAdd.Enabled := False;
end;



end.
