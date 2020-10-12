unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IniFiles, Data.DB, IBX.IBDatabase,
  Vcl.Grids, Vcl.DBGrids, IBX.IBCustomDataSet, IBX.IBQuery;

type
  TForm1 = class(TForm)
    IBDatabase1: TIBDatabase;
    IBQuery1: TIBQuery;
    IBTransaction1: TIBTransaction;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  IBQuery1.Close;
  IBDatabase1.Connected := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  FIniFile: TIniFile;
begin
  try
    FIniFile:=TIniFile.Create(ExtractFilePath(Application.ExeName) +  'config.ini');
    try
    IBDatabase1.DatabaseName := FIniFile.ReadString('Base', 'Path', '');
    finally
    FIniFile.Free;
    end;
    IBDatabase1.Connected := true;
    with IBQuery1 do
    begin
       SQL.Text:='select * from products';
       Open;
    end;
  except
      on E: Exception do
      begin
          Application.MessageBox(PChar(E.Message), 'Ошибка', MB_ICONERROR);
          Halt;
      end;
  end;
end;

end.
