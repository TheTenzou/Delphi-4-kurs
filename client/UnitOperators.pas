unit UnitOperators;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Grids, Vcl.Menus, system.json;

type
  TFormOperators = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    StringGridOperators: TStringGrid;
    HTTPOperators: TIdHTTP;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateData();
    procedure N1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure StringGridOperatorsClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  public
    type
      TRowCourier = Record
        id : string;
        name : string;
        login : string;
      end;
    var
    records : array of TRowCourier;
    { Public declarations }
  end;

var
  FormOperators: TFormOperators;

implementation

{$R *.dfm}

uses UnitLogin, UnitMain, UnitOperatorsAddUpdate;

procedure TFormOperators.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormLogin.close;
end;

procedure TFormOperators.FormCreate(Sender: TObject);
begin
  StringGridOperators.Cells[0,0] := '№';
  StringGridOperators.Cells[1,0] := 'ФИО';
  StringGridOperators.Cells[2,0] := 'Логин';
  StringGridOperators.ColWidths[0] := 40;
  StringGridOperators.ColWidths[1] := 150;
  StringGridOperators.ColWidths[2] := 150;
  StringGridOperators.ColCount := 3;
  n4.Enabled := False;
  n5.Enabled := False;
end;

procedure TFormOperators.FormShow(Sender: TObject);
begin
  UpdateData;
end;

procedure TFormOperators.N1Click(Sender: TObject);
begin
   UpdateData;
end;

procedure TFormOperators.N3Click(Sender: TObject);
begin
  FormOperatorsAddUpdate.mode := 'add';
  FormOperatorsAddUpdate.id := '0';
  FormOperatorsAddUpdate.ShowModal;
end;

procedure TFormOperators.N4Click(Sender: TObject);
begin
  FormOperatorsAddUpdate.mode := 'update';
  FormOperatorsAddUpdate.id := records[StringGridOperators.Row-1].id;
  FormOperatorsAddUpdate.EditName.Text := records[StringGridOperators.Row-1].name;
  FormOperatorsAddUpdate.EditLogin.Text := records[StringGridOperators.Row-1].login;
  FormOperatorsAddUpdate.ShowModal;
end;

procedure TFormOperators.N6Click(Sender: TObject);
begin
  FormMain.show;
  hide;
end;

procedure TFormOperators.StringGridOperatorsClick(Sender: TObject);
begin
if StringGridOperators.Row > 0 then
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

procedure TFormOperators.UpdateData();

var
  url : string;
  request : TStringStream;
  response : string;

  jsonObj : TJSONObject;
  jsonResponse : TJSONArray;

  i : integer;
begin
  HTTPOperators.Request.ContentType := 'application/json';
  HTTPOperators.Request.CharSet := 'utf-8';

  url := 'http://' + FormLogin.IP + '/operators/list/';

  request := TStringStream.Create(UTF8Encode(''));

  try
    response := HTTPOperators.Post(url, request);
    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONArray;

    SetLength(records, jsonResponse.Count);

    StringGridOperators.RowCount := 1;

    for i := 0 to jsonResponse.Count-1 do
      begin
        jsonObj := jsonResponse.items[i] as TJSONObject;

        records[i].id := jsonObj.Values['id'].Value;
        records[i].name := jsonObj.Values['name'].Value;
        records[i].login := jsonObj.Values['login'].Value;

        StringGridOperators.RowCount := StringGridOperators.RowCount + 1;

        StringGridOperators.Cells[0,i+1] := IntToStr(i+1);
        StringGridOperators.Cells[1,i+1] := records[i].name;
        StringGridOperators.Cells[2,i+1] := records[i].login;
      end;
  except
    ShowMessage('Проблемы с соединенем');
  end;
end;

end.
