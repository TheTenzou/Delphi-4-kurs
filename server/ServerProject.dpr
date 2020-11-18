program ServerProject;

uses
  Vcl.Forms,
  ServerUnit in 'ServerUnit.pas' {ServerForm},
  ProductsUtilsUnit in 'ProductsUtilsUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerForm, ServerForm);
  Application.Run;
end.
