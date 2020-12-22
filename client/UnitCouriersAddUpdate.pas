unit UnitCouriersAddUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormCouriresAddUpdate = class(TForm)
    LabelName: TLabel;
    LabelAvailability: TLabel;
    LabelLogin: TLabel;
    EditName: TEdit;
    EditLogin: TEdit;
    ComboBoxAvailability: TComboBox;
    ButtonAdd: TButton;
    ButtonCancel: TButton;
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
