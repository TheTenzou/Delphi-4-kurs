unit TestClientUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TTestClientForm = class(TForm)
    IPAddressLabel: TLabel;
    IPAddressEdit: TEdit;
    PortLabel: TLabel;
    PortEdit: TEdit;
    URLLabel: TLabel;
    URLEdit: TEdit;
    SendButton: TButton;
    RequestMemo: TMemo;
    ResponseMemo: TMemo;
    HTTP: TIdHTTP;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestClientForm: TTestClientForm;

implementation

{$R *.dfm}

end.
