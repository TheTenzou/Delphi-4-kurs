unit UnitCouriers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Grids, system.json;

type
  TFormCouriers = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    StringGridCouriers: TStringGrid;
    HTTPCouriers: TIdHTTP;
    procedure UpdateData();
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    type
      TRowCourier = Record
        id : string;
        name : string;
        availability : string;
        login : string;
      end;
    var
    records : array of TRowCourier;
    { Public declarations }
  end;

var
  FormCouriers: TFormCouriers;

implementation

{$R *.dfm}

uses UnitLogin;

procedure TFormCouriers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormLogin.Close;
end;

procedure TFormCouriers.FormShow(Sender: TObject);
begin
  UpdateData;
end;

procedure TFormCouriers.UpdateData();

var
  url : string;
  request : TStringStream;
  response : string;

  jsonObj : TJSONObject;
  jsonResponse : TJSONArray;

  i : integer;
begin
  HTTPCouriers.Request.ContentType := 'application/json';
  HTTPCouriers.Request.CharSet := 'utf-8';

  url := 'http://' + FormLogin.IP + '/couriers/list/';

  request := TStringStream.Create(UTF8Encode(''));

  try
    response := HTTPCouriers.Post(url, request);
    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONArray;

    SetLength(records, jsonResponse.Count);

    StringGridCouriers.RowCount := 1;

    for i := 0 to jsonResponse.Count-1 do
      begin
        jsonObj := jsonResponse.items[i] as TJSONObject;

        records[i].id := jsonObj.Values['id'].Value;
        records[i].name := jsonObj.Values['name'].Value;
        records[i].availability := jsonObj.Values['availability'].Value;
        records[i].login := jsonObj.Values['login'].Value;

        StringGridCouriers.RowCount := StringGridCouriers.RowCount + 1;

        StringGridCouriers.Cells[0,i+1] := IntToStr(i+1);
        StringGridCouriers.Cells[1,i+1] := records[i].name;
        StringGridCouriers.Cells[2,i+1] := records[i].availability;
        StringGridCouriers.Cells[2,i+1] := records[i].login;
      end;
  except
    ShowMessage('Проблемы с соединенем');
  end;
end;

end.
