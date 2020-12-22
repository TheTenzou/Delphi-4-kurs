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
    procedure EditPriceKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    id : string;
    mode : string;
  end;

var
  FormProductsAddUpdate: TFormProductsAddUpdate;

implementation

{$R *.dfm}

uses UnitLogin, UnitProducts;

procedure TFormProductsAddUpdate.close_();
begin
  EditName.Text := '';
  EditPrice.Text := '';
  FormProducts.updatedata;
  close;
end;

procedure TFormProductsAddUpdate.ButtonCancelClick(Sender: TObject);
begin
  close_;
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


  url := 'http://' + FormLogin.EditIP.Text + '/products/'+mode+'/';

  request := TStringStream.Create(UTF8Encode('{"id":"' + id + '", "name":"' + EditName.Text+ '","price":"' + EditPrice.Text + '"}'));

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

procedure TFormProductsAddUpdate.EditPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if ((Key<'0') or (key>'9')) and (key<>#8) then
    begin
      if (key<>FormatSettings.DecimalSeparator) or (pos(FormatSettings.DecimalSeparator,EditPrice.Text)>0) then
      key:=#0;
    end;
end;

end.
