program ServerTest;

uses
  Vcl.Forms,
  Server in 'Server.pas' {ServerForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerForm, ServerForm);
  Application.Run;
end.
