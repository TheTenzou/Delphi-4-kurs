program TestClientProject;

uses
  Vcl.Forms,
  TestClientUnit in 'TestClientUnit.pas' {TestClientForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestClientForm, TestClientForm);
  Application.Run;
end.
