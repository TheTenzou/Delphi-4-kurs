unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFormMain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N5Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses UnitLogin, UnitProducts, UnitCouriers, UnitOperators, UnitOrders;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormLogin.close;
end;

procedure TFormMain.N2Click(Sender: TObject);
begin
  FormOrders.show;
  hide;
end;

procedure TFormMain.N3Click(Sender: TObject);
begin
  FormCouriers.show;
  FormCouriers.choose := 1;
  Hide;
end;

procedure TFormMain.N4Click(Sender: TObject);
begin
  FormOperators.show;
  Hide;
end;

procedure TFormMain.N5Click(Sender: TObject);
begin
  FormProducts.choos:=1;
  FormProducts.show;
  Hide;
end;

end.
