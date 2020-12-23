unit UnitCouriersAddUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormCouriresAddUpdate = class(TForm)
    LabelName: TLabel;
    LabelLogin: TLabel;
    EditName: TEdit;
    EditLogin: TEdit;
    ButtonAdd: TButton;
    ButtonCancel: TButton;
    LabelPass: TLabel;
    EditPass: TEdit;
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCouriresAddUpdate: TFormCouriresAddUpdate;

implementation

{$R *.dfm}

procedure TFormCouriresAddUpdate.ButtonCancelClick(Sender: TObject);
begin
  close;
end;

end.
