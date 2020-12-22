program ProjectClient;

uses
  Vcl.Forms,
  UnitLogin in 'UnitLogin.pas' {FormLogin},
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitProducts in 'UnitProducts.pas' {FormProducts},
  UnitProductsAddUpdate in 'UnitProductsAddUpdate.pas' {FormProductsAddUpdate};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormProducts, FormProducts);
  Application.CreateForm(TFormProductsAddUpdate, FormProductsAddUpdate);
  Application.Run;
end.
