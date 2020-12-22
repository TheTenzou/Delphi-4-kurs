unit UnitProductsAddUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, system.json;

type
  TFormProductsAddUpdate = class(TForm)
    LabelName: TLabel;
    LabelPrice: TLabel;
    EditName: TEdit;
    EditPrice: TEdit;
    ButtonInsert: TButton;
    ButtonCancel: TButton;
    HTTPProductsAddUpdate: TIdHTTP;
    procedure EditNameChange(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonInsertClick(Sender: TObject);
    procedure close_();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormProductsAddUpdate: TFormProductsAddUpdate;

implementation

{$R *.dfm}

uses UnitLogin;

procedure TFormProductsAddUpdate.close_();
begin
  EditName.Text := '';
  EditPrice.Text := '';
  close_;
end;

procedure TFormProductsAddUpdate.ButtonCancelClick(Sender: TObject);
begin
  close;
end;

procedure TFormProductsAddUpdate.ButtonInsertClick(Sender: TObject);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonResponse : TJSONObject;
begin
  HTTPProductsAddUpdate.Request.ContentType := 'application/json';
  HTTPProductsAddUpdate.Request.CharSet := 'utf-8';

  url := 'http://' + FormLogin.EditIP.Text + '/products/add/';

  request := TStringStream.Create(UTF8Encode('{"name":"' + EditName.Text+ '","price":"' + EditPrice.Text + '"}'));

  try
    response := HTTPProductsAddUpdate.Post(url, request);

    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONObject;

  except
    ShowMessage('Проблемы с соединенем');
  end;
  close_;
end;

procedure TFormProductsAddUpdate.EditNameChange(Sender: TObject);
begin
if ((EditName.Text <> '') and (EditPrice.Text <> '')) then
  ButtonInsert.Enabled := True
else
  ButtonInsert.Enabled := False;
end;

end.
