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
    procedure FormCreate(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure StringGridCouriersClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
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

uses UnitLogin, UnitMain, UnitCouriersAddUpdate;

procedure TFormCouriers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormLogin.Close;
end;

procedure TFormCouriers.FormCreate(Sender: TObject);
begin
  StringGridCouriers.Cells[0,0] := '№';
  StringGridCouriers.Cells[1,0] := 'ФИО';
  StringGridCouriers.Cells[2,0] := 'Состояние';
  StringGridCouriers.Cells[3,0] := 'Логин';
  StringGridCouriers.ColWidths[0] := 20;
  StringGridCouriers.ColWidths[1] := 150;
  StringGridCouriers.ColWidths[2] := 150;
  StringGridCouriers.ColWidths[3] := 150;
  StringGridCouriers.ColCount := 4;
  n4.Enabled := False;
  n5.Enabled := False;
end;

procedure TFormCouriers.FormShow(Sender: TObject);
begin
  UpdateData;
end;

procedure TFormCouriers.N1Click(Sender: TObject);
begin
  UpdateData;
end;

procedure TFormCouriers.N3Click(Sender: TObject);
begin
  FormCouriresAddUpdate.mode := 'add';
  FormCouriresAddUpdate.id := '0';
  FormCouriresAddUpdate.ShowModal;
end;

procedure TFormCouriers.N4Click(Sender: TObject);
begin
  FormCouriresAddUpdate.mode := 'update';
  FormCouriresAddUpdate.id := records[StringGridCouriers.Row-1].id;
  FormCouriresAddUpdate.EditName.Text := records[StringGridCouriers.Row-1].name;
  FormCouriresAddUpdate.EditLogin.Text := records[StringGridCouriers.Row-1].login;
  FormCouriresAddUpdate.ShowModal;
end;

procedure TFormCouriers.N5Click(Sender: TObject);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonObj : TJSONObject;
  jsonResponse : TJSONArray;

  i : integer;
begin
if (MessageDlg('Удалить товар ' + records[StringGridCouriers.Row-1].name + ' ?', mtConfirmation, [mbYes, mbNo],0)=mrYes) then
  begin
    HTTPCouriers.Request.ContentType := 'application/json';
    HTTPCouriers.Request.CharSet := 'utf-8';

    url := 'http://' + FormLogin.IP + '/couriers/delete/';

    request := TStringStream.Create(UTF8Encode('{"id":"'+records[StringGridCouriers.Row-1].id+'"}'));

    try
      response := HTTPCouriers.Post(url, request);
    except
      ShowMessage('Проблемы с соединенем');
    end;
    UpdateData;
  end;
end;

procedure TFormCouriers.N6Click(Sender: TObject);
begin
  FormMain.show;
  hide;
end;

procedure TFormCouriers.StringGridCouriersClick(Sender: TObject);
begin
 if StringGridCouriers.Row > 0 then
    begin
      n4.Enabled := True;
      n5.Enabled := True;
    end
  else
    begin
      n4.Enabled := False;
      n5.Enabled := False;
    end;
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
        if records[i].availability = '1' then
          StringGridCouriers.Cells[2,i+1] := 'Доступен'
        else
          StringGridCouriers.Cells[2,i+1] := 'Не доступен';
        StringGridCouriers.Cells[3,i+1] := records[i].login;
      end;
  except
    ShowMessage('Проблемы с соединенем');
  end;
end;

end.
