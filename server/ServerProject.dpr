program ServerProject;

uses
  Vcl.Forms,
  ServerUnit in 'ServerUnit.pas' {ServerForm},
  ProductsUtilsUnit in 'ProductsUtilsUnit.pas',
  CouriersUtilsUnit in 'CouriersUtilsUnit.pas',
  OperatorsUtilsUnit in 'OperatorsUtilsUnit.pas',
  OrdersUtilsUnit in 'OrdersUtilsUnit.pas',
  OrdersInfoUtilsUnit in 'OrdersInfoUtilsUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerForm, ServerForm);
  Application.Run;
end.
