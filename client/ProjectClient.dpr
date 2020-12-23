program ProjectClient;

uses
  Vcl.Forms,
  UnitLogin in 'UnitLogin.pas' {FormLogin},
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitProducts in 'UnitProducts.pas' {FormProducts},
  UnitProductsAddUpdate in 'UnitProductsAddUpdate.pas' {FormProductsAddUpdate},
  UnitCouriers in 'UnitCouriers.pas' {FormCouriers},
  UnitCouriersAddUpdate in 'UnitCouriersAddUpdate.pas' {FormCouriresAddUpdate},
  UnitOperators in 'UnitOperators.pas' {FormOperators},
  UnitOperatorsAddUpdate in 'UnitOperatorsAddUpdate.pas' {FormOperatorsAddUpdate},
  UnitOrders in 'UnitOrders.pas' {FormOrders},
  UnitOrderAdd in 'UnitOrderAdd.pas' {FormAddOrder},
  UnitOrderUpdate in 'UnitOrderUpdate.pas' {FormOrderUpdate},
  UnitOrderinfoAddUpdate in 'UnitOrderinfoAddUpdate.pas' {FormOrderInfoAddUpdate};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormLogin, FormLogin);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormProducts, FormProducts);
  Application.CreateForm(TFormProductsAddUpdate, FormProductsAddUpdate);
  Application.CreateForm(TFormCouriers, FormCouriers);
  Application.CreateForm(TFormCouriresAddUpdate, FormCouriresAddUpdate);
  Application.CreateForm(TFormOperators, FormOperators);
  Application.CreateForm(TFormOperatorsAddUpdate, FormOperatorsAddUpdate);
  Application.CreateForm(TFormOrders, FormOrders);
  Application.CreateForm(TFormAddOrder, FormAddOrder);
  Application.CreateForm(TFormOrderUpdate, FormOrderUpdate);
  Application.CreateForm(TFormOrderInfoAddUpdate, FormOrderInfoAddUpdate);
  Application.Run;
end.
