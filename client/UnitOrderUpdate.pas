unit UnitOrderUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, system.json;

type
  TFormOrderUpdate = class(TForm)
    LabelAddres: TLabel;
    EditAddress: TEdit;
    ButtonAdd: TButton;
    ButtonCancel: TButton;
    HTTPUpdateOrder: TIdHTTP;
    LabelCourier: TLabel;
    EditCourier: TEdit;
    ButtonCourier: TButton;
    CheckBoxVerified: TCheckBox;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonCourierClick(Sender: TObject);
    procedure EditAddressChange(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure close_();
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    courierId : string;
    id : string;
  end;

var
  FormOrderUpdate: TFormOrderUpdate;

implementation

{$R *.dfm}

uses UnitCouriers, UnitOrders, UnitLogin;

procedure TFormOrderUpdate.ButtonCancelClick(Sender: TObject);
begin
  close_;
end;

procedure TFormOrderUpdate.ButtonCourierClick(Sender: TObject);
begin
  FormCouriers.choose := 3;
  FormCouriers.Show;
end;

procedure TFormOrderUpdate.close_();
begin
  EditAddress.Text := '';
  EditCourier.Text := '';
  FormOrders.UpdateOrders;
  close;
end;

procedure TFormOrderUpdate.EditAddressChange(Sender: TObject);
begin
  if (EditAddress.Text <> '') then
    ButtonAdd.Enabled := True
  else
    ButtonAdd.Enabled := False;
end;

procedure TFormOrderUpdate.FormCreate(Sender: TObject);
begin
  ButtonAdd.Enabled := EditAddress.Text <> '';
end;

procedure TFormOrderUpdate.ButtonAddClick(Sender: TObject);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonResponse : TJSONObject;
  jsonRequest : TJSONObject;
begin
  HTTPUpdateOrder.Request.ContentType := 'application/json';
  HTTPUpdateOrder.Request.CharSet := 'utf-8';


  url := 'http://' + FormLogin.EditIP.Text + '/orders/update/';

  jsonRequest := TJSONObject.Create;
  jsonRequest.AddPair('id', id);
  jsonRequest.AddPair('operatorid', FormLogin.operatorId);
  jsonRequest.AddPair('delivery_address', EditAddress.Text);
  jsonRequest.AddPair('courierid', courierId);
  if CheckBoxVerified.Checked then
    jsonRequest.AddPair('verified', '3')
  else
    begin
      if ((FormOrders.records[FormOrders.StringGridOrders.Row-1].start_delivery_time = '')
          and (FormOrders.records[FormOrders.StringGridOrders.Row-1].end_delivery_time = '')) then
          jsonRequest.AddPair('verified', '0')
      else if ((FormOrders.records[FormOrders.StringGridOrders.Row-1].start_delivery_time <> '')
          and (FormOrders.records[FormOrders.StringGridOrders.Row-1].end_delivery_time = '')) then
          jsonRequest.AddPair('verified', '1')
      else if ((FormOrders.records[FormOrders.StringGridOrders.Row-1].start_delivery_time <> '')
          and (FormOrders.records[FormOrders.StringGridOrders.Row-1].end_delivery_time <> '')) then
          jsonRequest.AddPair('verified', '2');
    end;

  request := TStringStream.Create(UTF8Encode(jsonRequest.Format()));

  try
    response := HTTPUpdateOrder.Post(url, request);
    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONObject;

  except
    ShowMessage('Проблемы с соединенем');
  end;
  close_;
end;

end.
