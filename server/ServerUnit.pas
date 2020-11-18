unit ServerUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs;

type
  TServerForm = class(TForm)
    HTTPServer: TIdHTTPServer;
    PortEdit: TEdit;
    PortLabel: TLabel;
    StartButton: TButton;
    StopButton: TButton;
    StatusMemo: TMemo;
    DBConnection: TFDConnection;
    Query: TFDQuery;
    procedure StartButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServerForm: TServerForm;
  datePadding: integer;

implementation

{$R *.dfm}

procedure TServerForm.FormCreate(Sender: TObject);
begin
PortEdit.Text := '80';
StopButton.Enabled := False;
datePadding := 60;
end;

procedure TServerForm.StartButtonClick(Sender: TObject);
var
  params : TStrings;
  i : integer;
  str : string;
begin
  try
    HTTPServer.DefaultPort := StrToInt(PortEdit.Text);
    HTTPServer.Active := True;

    StatusMemo.Lines.Add(('Сервер запушен на порте: '
                          + PortEdit.Text + '.').PadRight(datePadding)
                          + 'Време ' + DateTimeToStr(Now));

    StopButton.Enabled := True;

    StartButton.Enabled := False;
    PortEdit.Enabled := False;

    params := TStringList.Create;
    params.Add('DriverID=SQLite');
    params.Add('Pooled=True');
    params.Add('Database='
                + ExtractFilePath(Application.ExeName)
                + '\DataBase.db');

    try
      DBConnection.Close;
      FDManager.AddConnectionDef('sqlitePooled','SQLite', params);
      DBConnection.ConnectionDefName := 'sqlitePooled';
      
      DBConnection.Open;
      StatusMemo.Lines.Add('Успешное подлючение к базеданных.'.PadRight(datePadding)
                           + 'Время ' +  DateTimeToStr(Now));

      DBConnection.Close;
    except
      on E : Exception do
      begin
        ShowMessage('Соошени ошибки: '+E.Message);

        StatusMemo.Lines.Add('Ошибка подлючения к базеданных.'.PadRight(datePadding)
                           + 'Время ' +  DateTimeToStr(Now));
        exit;
      end;
    end;

  except
    StatusMemo.Lines.Add(('Ошибка запуска сервера.').PadRight(datePadding)
                          + DateTimeToStr(Now));
  end;
  
end;

procedure TServerForm.StopButtonClick(Sender: TObject);
begin
  try
    HTTPServer.Active := False;

    StatusMemo.Lines.Add('Сервер остановлен.'.PadRight(datePadding)
                          + 'Време ' + DateTimeToStr(Now));

    StartButton.Enabled := True;
    PortEdit.Enabled := True;

    StopButton.Enabled := False;
  except
     StatusMemo.Lines.Add(('Ошибка остановки сервера.').PadRight(datePadding)
                            + DateTimeToStr(Now));
  end;
end;

end.
