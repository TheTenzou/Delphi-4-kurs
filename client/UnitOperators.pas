unit UnitOperators;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Grids, Vcl.Menus;

type
  TFormOperators = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    StringGrid1: TStringGrid;
    IdHTTP1: TIdHTTP;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormOperators: TFormOperators;

implementation

{$R *.dfm}

uses UnitLogin;

procedure TFormOperators.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormLogin.close;
end;

end.
