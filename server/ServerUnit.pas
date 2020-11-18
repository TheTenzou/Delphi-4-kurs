unit ServerUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer;

type
  TServerForm = class(TForm)
    HTTPServer: TIdHTTPServer;
    PortEdit: TEdit;
    PortLabel: TLabel;
    StartButton: TButton;
    StopButton: TButton;
    StatusMemo: TMemo;
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

implementation

{$R *.dfm}

procedure TServerForm.FormCreate(Sender: TObject);
begin
PortEdit.Text := '80';
StopButton.Enabled := False;
end;

procedure TServerForm.StartButtonClick(Sender: TObject);
begin
  try
    HTTPServer.DefaultPort := StrToInt(PortEdit.Text);
    HTTPServer.Active := True;

    StatusMemo.Lines.Add('Сервер запушен на порте: '
                             + PortEdit.Text
                             + '. Време ' + DateTimeToStr(Now));

    StopButton.Enabled := True;

    StartButton.Enabled := False;
    PortEdit.Enabled := False;
  except
    StatusMemo.Lines.Add('Ошибка запуска сервера');
  end;
end;

procedure TServerForm.StopButtonClick(Sender: TObject);
begin
  try
    HTTPServer.Active := False;

    StatusMemo.Lines.Add('Сервер остановлен. Време ' + DateTimeToStr(Now));

    StartButton.Enabled := True;
    PortEdit.Enabled := True;

    StopButton.Enabled := False;
  except
     StatusMemo.Lines.Add('Ошибка остановки сервера');
  end;
end;

end.
