unit UnitOrderinfoAddUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, system.json;

type
  TFormOrderInfoAddUpdate = class(TForm)
    LabelName: TLabel;
    LabelPrice: TLabel;
    LabelCount: TLabel;
    EditName: TEdit;
    EditPrice: TEdit;
    EditCount: TEdit;
    ButtonProduct: TButton;
    ButtonInsert: TButton;
    ButtonCancel: TButton;
    HTTPOrderInfoAddUpdate: TIdHTTP;
    procedure close_();
    procedure ButtonCancelClick(Sender: TObject);
    procedure EditNameChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditPriceKeyPress(Sender: TObject;var Key: Char);
    procedure ButtonInsertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id : string;
    orderid_id : string;
    mode : string;
  end;

var
  FormOrderInfoAddUpdate: TFormOrderInfoAddUpdate;

implementation

{$R *.dfm}

uses UnitOrders, UnitLogin;

procedure TFormOrderInfoAddUpdate.close_();
begin
  EditName.Text := '';
  EditPrice.Text := '';
  FormOrders.UpdateOrderInfo;
  close;
end;

procedure TFormOrderInfoAddUpdate.ButtonCancelClick(Sender: TObject);
begin
  close_;
end;

procedure TFormOrderInfoAddUpdate.EditNameChange(Sender: TObject);
begin
if ((EditName.Text <> '') and (EditPrice.Text <> '') and (EditCount.Text <> '')) then
  ButtonInsert.Enabled := True
else
  ButtonInsert.Enabled := False;
end;

procedure TFormOrderInfoAddUpdate.FormShow(Sender: TObject);
begin
if ((EditName.Text <> '') and (EditPrice.Text <> '') and (EditCount.Text <> '')) then
  ButtonInsert.Enabled := True
else
  ButtonInsert.Enabled := False;
end;

procedure TFormOrderInfoAddUpdate.EditPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  if ((Key<'0') or (key>'9')) and (key<>#8) then
    begin
      if (key<>FormatSettings.DecimalSeparator) or (pos(FormatSettings.DecimalSeparator,EditPrice.Text)>0) then
      key:=#0;
    end;
end;

procedure TFormOrderInfoAddUpdate.ButtonInsertClick(Sender: TObject);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonResponse : TJSONObject;
  jsonRequest : TJSONObject;
begin
  HTTPOrderInfoAddUpdate.Request.ContentType := 'application/json';
  HTTPOrderInfoAddUpdate.Request.CharSet := 'utf-8';


  url := 'http://' + FormLogin.EditIP.Text + '/order-info/'+mode+'/';

  jsonRequest := TJSONObject.Create;
  jsonRequest.AddPair('id', id);
  jsonRequest.AddPair('order_id', orderid_id);
  jsonRequest.AddPair('name',EditName.Text);
  jsonRequest.AddPair('price',EditPrice.Text);
  jsonRequest.AddPair('count_',EditCount.Text);

  request := TStringStream.Create(UTF8Encode(jsonRequest.format));

  try
    response := HTTPOrderInfoAddUpdate.Post(url, request);

    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONObject;

  except
    ShowMessage('Проблемы с соединенем');
  end;
  close_;
end;

end.
