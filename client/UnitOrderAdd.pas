unit UnitOrderAdd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, system.json;

type
  TFormAddOrder = class(TForm)
    LabelAddres: TLabel;
    EditAddress: TEdit;
    ButtonAdd: TButton;
    ButtonCancel: TButton;
    HTTPAddOrder: TIdHTTP;
    LabelCourier: TLabel;
    EditCourier: TEdit;
    ButtonCourier: TButton;
    procedure close_();
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure EditAddressChange(Sender: TObject);
    procedure ButtonCourierClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    courierId : string;
  end;

var
  FormAddOrder: TFormAddOrder;

implementation

{$R *.dfm}

uses UnitOrders, UnitLogin, UnitCouriers;

procedure TFormAddOrder.ButtonCancelClick(Sender: TObject);
begin
close_;
end;

procedure TFormAddOrder.ButtonCourierClick(Sender: TObject);
begin
  FormCouriers.choose := 2;
  FormCouriers.Show;
end;

procedure TFormAddOrder.close_();
begin
  EditAddress.Text := '';
  EditCourier.Text := '';
  FormOrders.UpdateOrders;
  close;
end;

procedure TFormAddOrder.EditAddressChange(Sender: TObject);
begin
  if (EditAddress.Text <> '') then
    ButtonAdd.Enabled := True
  else
    ButtonAdd.Enabled := False;
end;

procedure TFormAddOrder.ButtonAddClick(Sender: TObject);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonResponse : TJSONObject;
  jsonRequest : TJSONObject;
begin
  HTTPAddOrder.Request.ContentType := 'application/json';
  HTTPAddOrder.Request.CharSet := 'utf-8';


  url := 'http://' + FormLogin.EditIP.Text + '/orders/add/';

  jsonRequest := TJSONObject.Create;
  jsonRequest.AddPair('operatorid', FormLogin.operatorId);
  jsonRequest.AddPair('delivery_address', EditAddress.Text);
  jsonRequest.AddPair('courierid', courierId);

  request := TStringStream.Create(UTF8Encode(jsonRequest.Format()));

  try
    response := HTTPAddOrder.Post(url, request);
    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONObject;

  except
    ShowMessage('Проблемы с соединенем');
  end;
  close_;
end;

end.
