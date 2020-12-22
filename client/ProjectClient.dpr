program ProjectClient;

uses
  Vcl.Forms,
  UnitLogin in 'UnitLogin.pas' {Form1},
  UnitMain in 'UnitMain.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
