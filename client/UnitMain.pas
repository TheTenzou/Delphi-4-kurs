unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,system.json;

type
  TFormMain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Orders1: TPanel;
    MainLabel2: TLabel;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    MainLaibel1: TLabel;
    HTTPOrders: TIdHTTP;
    Courier1: TPanel;
    Courier2: TPanel;
    Courier3: TPanel;
    Devide1: TPanel;
    CourierOrder1_1: TPanel;
    Devide2: TPanel;
    ScrollBar3: TScrollBar;
    CourierLableName1: TLabel;
    CourierLableId1: TLabel;
    CourierLableId2: TLabel;
    CourierLableName2: TLabel;
    CourierLableId3: TLabel;
    CourierLableName3: TLabel;
    Courier4: TPanel;
    CourierLableId4: TLabel;
    CourierLableName4: TLabel;
    Courier5: TPanel;
    CourierLableId5: TLabel;
    CourierLableName5: TLabel;
    OrderId1: TLabel;
    OrderAdress1: TLabel;
    Orders2: TPanel;
    OrderId2: TLabel;
    OrderAdress2: TLabel;
    Orders3: TPanel;
    OrderId3: TLabel;
    OrderAdress3: TLabel;
    Orders4: TPanel;
    OrderId4: TLabel;
    OrderAdress4: TLabel;
    Orders5: TPanel;
    OrderId5: TLabel;
    OrderAdress5: TLabel;
    COId1_1: TLabel;
    COAdress1_1: TLabel;
    CourierOrder1_2: TPanel;
    COId1_2: TLabel;
    COAdress1_2: TLabel;
    CourierOrder1_3: TPanel;
    COId1_3: TLabel;
    COAdress1_3: TLabel;
    CourierOrder2_1: TPanel;
    COId2_1: TLabel;
    COAdress2_1: TLabel;
    CourierOrder2_2: TPanel;
    COId2_2: TLabel;
    COAdress2_2: TLabel;
    CourierOrder2_3: TPanel;
    COId2_3: TLabel;
    COAdress2_3: TLabel;
    CourierOrder3_1: TPanel;
    COId3_1: TLabel;
    COAdress3_1: TLabel;
    CourierOrder3_2: TPanel;
    COId3_2: TLabel;
    COAdress3_2: TLabel;
    CourierOrder3_3: TPanel;
    COId3_3: TLabel;
    COAdress3_3: TLabel;
    CourierOrder4_1: TPanel;
    COId4_1: TLabel;
    COAdress4_1: TLabel;
    CourierOrder4_2: TPanel;
    COId4_2: TLabel;
    COAdress4_2: TLabel;
    CourierOrder4_3: TPanel;
    COId4_3: TLabel;
    COAdress4_3: TLabel;
    CourierOrder5_1: TPanel;
    COId5_1: TLabel;
    COAdress5_1: TLabel;
    CourierOrder5_2: TPanel;
    COId5_2: TLabel;
    COAdress5_2: TLabel;
    CourierOrder5_3: TPanel;
    COId5_3: TLabel;
    COAdress5_3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N5Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure createTableOC(Sender:TObject);
    procedure FormShowOrder(Sender: TObject);
    procedure FromShowCourier(Sender:TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowPanel(Sender:TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure CourierOrderDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure OrdersDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CourierOrder1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure CourierOrder2DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure CourierOrder3DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure CourierOrder4DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure CourierOrder5DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure OrderToCourier(Sender:TObject;id,idcourier:string);
    procedure OrderDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure CourierToOrder(Sender:TObject;id:string);
    procedure CourierOrderClick(Sender: TObject);
    procedure ColorReset(Sender:TObject;El:string;panel:Tpanel);

  private
    { Private declarations }
  public
   type
      TColOrder = Record
        id : string;
        courierid : string;
        courier_name : string;
        operatorid : string;
        operator_name : string;
        created_time : string;
        start_delivery_time : string;
        end_delivery_time : string;
        total_summ : string;
        delivery_address : string;
        verified : string;
      end;
      type
      TRowCourier = Record
        id : string;
        name : string;
        availability : string;
        login : string;
      end;
    var RCourier : array of TRowCourier;
    var orderN,order : array of TColOrder;
    var Ord,Cou,ordN,maxOrder:integer;
      type OrderCourier = Record
        id:string;
        adress:string;
      End;
     var TableOC: array of array of OrderCourier;
    { Public declarations }
    //SetLength
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses UnitLogin, UnitProducts, UnitCouriers, UnitOperators, UnitOrders;


procedure TFormMain.ColorReset(Sender:TObject;El:string;panel:Tpanel);
var a:integer;var a1:integer;
begin
for var i:integer := 0 to Ord - 1 do
       if order[i].id = el then begin
                                Val(order[i].verified,a,a1);
                                case a of
                                1:panel.Color:=clRed;
                                2:panel.Color:=clBlue;
                                end;

       end;

  // if true then panel.Color:=clRed else panel.Color := clGreen;
end;

procedure TFormMain.MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    TPanel(Sender).BeginDrag(True);
end;

procedure TFormMain.CourierOrder1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
  var id :string;
begin
   if Orders1 = Source then id:=orderId1.Caption;
   if Orders2 = Source then id:=orderId2.Caption;
   if Orders3 = Source then id:=orderId3.Caption;
   if Orders4 = Source then id:=orderId4.Caption;
   if Orders5 = Source then id:=orderId5.Caption;
   OrderToCourier(Sender,id,CourierLableId1.Caption);
   ScrollBar2Change(Sender);
   ScrollBar1Change(Sender);
end;

procedure TFormMain.CourierOrderDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     if (Source = Orders1) or (Source = Orders2) or (Source = Orders3)
     or (Source = Orders4) or (Source = Orders5) then Accept := true;

end;

procedure TFormMain.CourierToOrder(Sender: TObject; id: string);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonObj,jsonObj1 : TJSONObject;
  jsonResponse : TJSONArray;

  i : integer;
begin
  HTTPOrders.Request.ContentType := 'application/json';
  HTTPOrders.Request.CharSet := 'utf-8';

  url := 'http://' + FormLogin.IP + '/orders/id/';
  jsonObj := TJSONObject.Create;
  delete(id,1,3);
  jsonObj.AddPair('id',id);

  request := TStringStream.Create(UTF8Encode(jsonObj.ToString()));
  try
    response := HTTPOrders.Post(url, request);
    jsonObj := TJSONObject.ParseJSONValue(response, False, True) as TJSONObject;
  except
    ShowMessage('Проблемы с соединенем');
  end;

  url := 'http://' + FormLogin.IP + '/orders/update/';
  jsonObj1 := TJSONObject.Create;
  jsonObj1.AddPair('id',id)
        .AddPair('courierid','')
        .AddPair('operatorid',jsonObj.Values['operatorid'].Value)
        .AddPair('delivery_address',jsonObj.Values['delivery_address'].Value)
        .AddPair('verified',jsonObj.Values['verified'].Value);

  request := TStringStream.Create(UTF8Encode(jsonObj1.ToString()));
  try
    response := HTTPOrders.Post(url, request);
  except
    ShowMessage('Проблемы с соединенем');
  end;
  for i := 0 to Cou -1 do
    for var k := 0 to Ord - 1 do if TableOC[i,k].id = id then begin
                                    TableOC[i,k].id := '';
                                    TableOC[i,k].adress:= '';
                                    end;
   //ShowMessage(response);
end;

procedure TFormMain.CourierOrderClick(Sender: TObject);
var buttonSelected : Integer;
url : string;
  request : TStringStream;
  response : string;

  jsonObj : TJSONObject;
  jsonResponse : TJSONArray;
begin
   buttonSelected := MessageDlg('Потдверждение',mtError, mbOKCancel, 0);


end;

procedure TFormMain.CourierOrder2DragDrop(Sender, Source: TObject; X,
  Y: Integer);
  var id:string;
begin
   if Orders1 = Source then id:=orderId1.Caption;
   if Orders2 = Source then id:=orderId2.Caption;
   if Orders3 = Source then id:=orderId3.Caption;
   if Orders4 = Source then id:=orderId4.Caption;
   if Orders5 = Source then id:=orderId5.Caption;
   OrderToCourier(Sender,id,CourierLableId2.Caption);
   ScrollBar2Change(Sender);
end;

procedure TFormMain.createTableOC(Sender: TObject);
var k:integer;

begin
     SetLength(TableOC,Cou);
     for var i:=0 to Cou-1 do
     SetLength(TableOC[i],Ord);
     for var i := 0 to Cou - 1 do begin
       k:=0;
       for var j := 0 to Ord - 1 do begin
         TableOC[i,j].id := '';
         TableOC[i,j].adress := '';
         if ((RCourier[i].id = order[j].courierid) and (order[j].verified <> '3')) then begin
         TableOC[i,k].id := order[j].id;
         TableOC[i,k].adress := order[j].delivery_address;
         inc(k,1);
         if k > maxOrder then maxOrder:=k;

         end;
       end;
     end;
end;

procedure TFormMain.CourierOrder3DragDrop(Sender, Source: TObject; X,
  Y: Integer);
  var id:string;
begin
   if Orders1 = Source then id:=orderId1.Caption;
   if Orders2 = Source then id:=orderId2.Caption;
   if Orders3 = Source then id:=orderId3.Caption;
   if Orders4 = Source then id:=orderId4.Caption;
   if Orders5 = Source then id:=orderId5.Caption;
   OrderToCourier(Sender,id,CourierLableId3.Caption);
   ScrollBar2Change(Sender);
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormLogin.close;
end;

procedure TFormMain.CourierOrder4DragDrop(Sender, Source: TObject; X,
  Y: Integer);
  var id:string;
begin
   if Orders1 = Source then id:=orderId1.Caption;
   if Orders2 = Source then id:=orderId2.Caption;
   if Orders3 = Source then id:=orderId3.Caption;
   if Orders4 = Source then id:=orderId4.Caption;
   if Orders5 = Source then id:=orderId5.Caption;
   OrderToCourier(Sender,id,CourierLableId4.Caption);
   ScrollBar2Change(Sender);
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
    SetLength(orderN, 0);
    ordN := 0;
    FormShowOrder(Sender);
    FromShowCourier(Sender);
    createTableOC(Sender);
    if Cou - 4 > 0 then ScrollBar2.Max:= Cou - 4 else ScrollBar2.Max:= 1;
    if maxOrder - 3 > 0 then ScrollBar3.Max:=maxOrder-3 else ScrollBar3.Max:=1;
    if maxOrder = 0 then scrollbar3.Max:=0;
    if Cou = 0 then scrollbar2.Max:=0;
    ScrollBar2Change(Sender);
    if OrdN - 4 > 0 then ScrollBar1.Max:= OrdN - 4 else scrollbar1.Max:=1;
    if OrdN = 0 then scrollbar1.Max:=0;
    ScrollBar1Change(sender);
end;

procedure TFormMain.CourierOrder5DragDrop(Sender, Source: TObject; X,
  Y: Integer);
  var id:string;
begin
   if Orders1 = Source then id:=orderId1.Caption;
   if Orders2 = Source then id:=orderId2.Caption;
   if Orders3 = Source then id:=orderId3.Caption;
   if Orders4 = Source then id:=orderId4.Caption;
   if Orders5 = Source then id:=orderId5.Caption;
   OrderToCourier(Sender,id,CourierLableId5.Caption);
   ScrollBar2Change(Sender);
end;

procedure TFormMain.FormShowOrder(Sender: TObject);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonObj : TJSONObject;
  jsonResponse : TJSONArray;

  i : integer;
begin
  maxOrder:=0;
  HTTPOrders.Request.ContentType := 'application/json';
  HTTPOrders.Request.CharSet := 'utf-8';

  url := 'http://' + FormLogin.IP + '/orders/list/';

  request := TStringStream.Create(UTF8Encode(''));
  try
    response := HTTPOrders.Post(url, request);
    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONArray;


    SetLength(order, jsonResponse.Count);
    SetLength(orderN, jsonResponse.Count);
    //StringGridOrders.RowCount := 1;
    Ord:=0;
    OrdN:=0;
    for i := 0 to jsonResponse.Count-1 do
      begin
        jsonObj := jsonResponse.items[i] as TJSONObject;
        if jsonObj.Values['courierid'].Value = '' then begin
        orderN[ordN].id := jsonObj.Values['id'].Value;
        orderN[ordN].courierid := jsonObj.Values['courierid'].Value;
        orderN[ordN].courier_name := jsonObj.Values['courier_name'].Value;
        orderN[ordN].operatorid := jsonObj.Values['operatorid'].Value;
        orderN[ordN].operator_name := jsonObj.Values['operator_name'].Value;
        orderN[ordN].created_time := jsonObj.Values['created_time'].Value;
        orderN[ordN].start_delivery_time := jsonObj.Values['start_delivery_time'].Value;
        orderN[ordN].end_delivery_time := jsonObj.Values['end_delivery_time'].Value;
        orderN[ordN].total_summ := jsonObj.Values['total_summ'].Value;
        orderN[ordN].delivery_address := jsonObj.Values['delivery_address'].Value;
        orderN[ordN].verified := jsonObj.Values['verified'].Value;
        inc(OrdN,1);
        end else


        begin
        order[Ord].id := jsonObj.Values['id'].Value;
        order[Ord].courierid := jsonObj.Values['courierid'].Value;
        order[Ord].courier_name := jsonObj.Values['courier_name'].Value;
        order[Ord].operatorid := jsonObj.Values['operatorid'].Value;
        order[Ord].operator_name := jsonObj.Values['operator_name'].Value;
        order[Ord].created_time := jsonObj.Values['created_time'].Value;
        order[Ord].start_delivery_time := jsonObj.Values['start_delivery_time'].Value;
        order[Ord].end_delivery_time := jsonObj.Values['end_delivery_time'].Value;
        order[Ord].total_summ := jsonObj.Values['total_summ'].Value;
        order[Ord].delivery_address := jsonObj.Values['delivery_address'].Value;
        order[Ord].verified := jsonObj.Values['verified'].Value;
        inc(Ord,1);
        end;
                //StringGridOrders.RowCount := StringGridOrders.RowCount + 1;

        {StringGridOrders.Cells[0,i+1] := IntToStr(i+1);
        StringGridOrders.Cells[1,i+1] := records[i].courier_name;
        StringGridOrders.Cells[2,i+1] := records[i].operator_name;
        StringGridOrders.Cells[3,i+1] := records[i].created_time;
        StringGridOrders.Cells[4,i+1] := records[i].start_delivery_time;
        StringGridOrders.Cells[6,i+1] := records[i].end_delivery_time;
        StringGridOrders.Cells[7,i+1] := records[i].total_summ;
        StringGridOrders.Cells[8,i+1] := records[i].delivery_address;
        StringGridOrders.Cells[9,i+1] := records[i].verified;}
      end;
      SetLength(order, Ord);
      SetLength(orderN, OrdN);

  except
    ShowMessage('Проблемы с соединенем');
  end;
end;

procedure TFormMain.FromShowCourier(Sender: TObject);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonObj : TJSONObject;
  jsonResponse : TJSONArray;

  i,k : integer;
begin
  HTTPOrders.Request.ContentType := 'application/json';
  HTTPOrders.Request.CharSet := 'utf-8';

  url := 'http://' + FormLogin.IP + '/couriers/list/';

  request := TStringStream.Create(UTF8Encode(''));
   Cou:=0;
   k:=0;
  try
    response := HTTPOrders.Post(url, request);
    jsonResponse := TJSONObject.ParseJSONValue(response, False, True) as TJSONArray;

    SetLength(RCourier, jsonResponse.Count);
    //StringGridOrders.RowCount := 1;
    for i := 0 to jsonResponse.Count-1 do
      begin
        jsonObj := jsonResponse.items[i] as TJSONObject;
        if jsonObj.Values['availability'].Value = '1' then begin
        RCourier[i].id := jsonObj.Values['id'].Value;
        RCourier[i].name := jsonObj.Values['name'].Value;
        RCourier[i].availability := jsonObj.Values['availability'].Value;
        RCourier[i].login := jsonObj.Values['login'].Value;
        inc(k,1);
        inc(Cou,1);
        end;

        //StringGridOrders.RowCount := StringGridOrders.RowCount + 1;

        {StringGridOrders.Cells[0,i+1] := IntToStr(i+1);
        StringGridOrders.Cells[1,i+1] := records[i].courier_name;
        StringGridOrders.Cells[2,i+1] := records[i].operator_name;
        StringGridOrders.Cells[3,i+1] := records[i].created_time;
        StringGridOrders.Cells[4,i+1] := records[i].start_delivery_time;
        StringGridOrders.Cells[6,i+1] := records[i].end_delivery_time;
        StringGridOrders.Cells[7,i+1] := records[i].total_summ;
        StringGridOrders.Cells[8,i+1] := records[i].delivery_address;
        StringGridOrders.Cells[9,i+1] := records[i].verified;}
      end;
  except
    ShowMessage('Проблемы с соединенем');
  end;
end;

procedure TFormMain.N2Click(Sender: TObject);
begin
  FormOrders.show;
  hide;
end;

procedure TFormMain.N3Click(Sender: TObject);
begin
  FormCouriers.choose := 1;
  FormCouriers.show;
  Hide;
end;

procedure TFormMain.N4Click(Sender: TObject);
begin
  FormOperators.show;
  Hide;
end;

procedure TFormMain.N5Click(Sender: TObject);
begin
  FormProducts.choos := 1;
  FormProducts.show;
  Hide;
end;

procedure TFormMain.OrderDragDrop(Sender, Source: TObject; X, Y: Integer);
var id:string;
begin
   if (Source = CourierOrder1_1) then id:=COId1_1.Caption;
   if (Source = CourierOrder1_2) then id:=COId1_2.Caption;
   if (Source = CourierOrder1_3) then id:=COId1_2.Caption;
   if (Source = CourierOrder2_1) then id:=COId2_1.Caption;
   if (Source = CourierOrder2_2) then id:=COId2_2.Caption;
   if (Source = CourierOrder2_3) then id:=COId2_3.Caption;
   if (Source = CourierOrder3_1) then id:=COId3_1.Caption;
   if (Source = CourierOrder3_2) then id:=COId3_2.Caption;
   if (Source = CourierOrder3_3) then id:=COId3_3.Caption;
   if (Source = CourierOrder4_1) then id:=COId4_1.Caption;
   if (Source = CourierOrder4_2) then id:=COId4_2.Caption;
   if (Source = CourierOrder4_3) then id:=COId4_3.Caption;
   if (Source = CourierOrder5_1) then id:=COId5_1.Caption;
   if (Source = CourierOrder5_2) then id:=COId5_2.Caption;
   if (Source = CourierOrder5_3) then id:=COId5_3.Caption;
   CourierToOrder(sender,id);
   ScrollBar2Change(Sender);
   ScrollBar1Change(Sender);
end;

procedure TFormMain.OrdersDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
    if (Source = CourierOrder1_1) or (Source = CourierOrder1_2) or (Source = CourierOrder1_3)
    or (Source = CourierOrder2_1) or (Source = CourierOrder2_2) or (Source = CourierOrder2_3)
    or (Source = CourierOrder3_1) or (Source = CourierOrder3_2) or (Source = CourierOrder3_3)
    or (Source = CourierOrder4_1) or (Source = CourierOrder4_2) or (Source = CourierOrder4_3)
    or (Source = CourierOrder5_1) or (Source = CourierOrder5_2) or (Source = CourierOrder5_3)
    then Accept := true;

end;

procedure TFormMain.OrderToCourier(Sender: TObject; id,idcourier: string);
var
  url : string;
  request : TStringStream;
  response : string;

  jsonObj,jsonObj1 : TJSONObject;
  jsonResponse : TJSONArray;

  i : integer;
begin
  HTTPOrders.Request.ContentType := 'application/json';
  HTTPOrders.Request.CharSet := 'utf-8';

  url := 'http://' + FormLogin.IP + '/orders/id/';
  jsonObj := TJSONObject.Create;
  delete(id,1,3);
  jsonObj.AddPair('id',id);

  request := TStringStream.Create(UTF8Encode(jsonObj.ToString()));
  try
    response := HTTPOrders.Post(url, request);
    jsonObj := TJSONObject.ParseJSONValue(response, False, True) as TJSONObject;
  except
    ShowMessage('Проблемы с соединенем');
  end;

  url := 'http://' + FormLogin.IP + '/orders/update/';
  jsonObj1 := TJSONObject.Create;
  delete(idcourier,1,3);
  jsonObj1.AddPair('id',id)
        .AddPair('courierid',idcourier)
        .AddPair('operatorid',jsonObj.Values['operatorid'].Value)
        .AddPair('delivery_address',jsonObj.Values['delivery_address'].Value)
        .AddPair('verified','1');

  request := TStringStream.Create(UTF8Encode(jsonObj1.ToString()));
  try
    response := HTTPOrders.Post(url, request);
  except
    ShowMessage('Проблемы с соединенем');
  end;
  for i := 0 to OrdN -1 do
        if orderN[i].id = id then begin
                                  orderN[i].id := '';
                                  //ShowMessage(response);
                                  ordN := ordn -1;
                                  end;
   //ShowMessage(response);
end;

procedure TFormMain.ScrollBar1Change(Sender: TObject);
begin
  if (OrdN > 0) and (orderN[ScrollBar1.Position].id <> '') then begin
  OrderId1.Caption:='id ' + orderN[ScrollBar1.Position].id;
  OrderAdress1.Caption:=orderN[ScrollBar1.Position].delivery_address;
  end;

  if (OrdN > 1) and (orderN[ScrollBar1.Position + 1].id <> '')then begin
  OrderId2.Caption:='id ' + orderN[ScrollBar1.Position + 1].id;
  OrderAdress2.Caption:=orderN[ScrollBar1.Position + 1].delivery_address;
  end;

  if (OrdN > 2) and (orderN[ScrollBar1.Position + 2].id <> '')then begin
  OrderId3.Caption:='id ' + orderN[ScrollBar1.Position + 2].id;
  OrderAdress3.Caption:=orderN[ScrollBar1.Position + 2].delivery_address;
  end;

  if (OrdN > 3) and (orderN[ScrollBar1.Position + 3].id <> '')then begin
  OrderId4.Caption:='id ' + orderN[ScrollBar1.Position + 3].id;
  OrderAdress4.Caption:=orderN[ScrollBar1.Position + 3].delivery_address;
  end;

  if (OrdN > 4) and (orderN[ScrollBar1.Position + 4].id <> '')then begin
  OrderId5.Caption:='id ' + orderN[ScrollBar1.Position + 4].id;
  OrderAdress5.Caption:=orderN[ScrollBar1.Position + 4].delivery_address;
  end;
end;

procedure TFormMain.ScrollBar2Change(Sender: TObject);
begin
  if (Cou > 0) and (RCourier[ScrollBar1.Position].id <> '') and (RCourier[ScrollBar1.Position].availability <> '0') then begin
  CourierLableId1.Caption:='id ' + RCourier[ScrollBar1.Position].id;
  CourierLableName1.Caption:=RCourier[ScrollBar1.Position].name;
  end;

  if (Cou > 1) and (RCourier[ScrollBar1.Position + 1].id <> '') and (RCourier[ScrollBar1.Position+1].availability <> '0')then begin
  CourierLableId2.Caption:='id ' + RCourier[ScrollBar1.Position + 1].id;
  CourierLableName2.Caption:=RCourier[ScrollBar1.Position + 1].name;
  end;

  if (Cou > 2) and (RCourier[ScrollBar1.Position + 2].id <> '')and (RCourier[ScrollBar1.Position+2].availability <> '0') then begin
  CourierLableId3.Caption:='id ' + RCourier[ScrollBar1.Position + 2].id;
  CourierLableName3.Caption:=RCourier[ScrollBar1.Position + 2].name;
  end;

  if (Cou > 3) and (RCourier[ScrollBar1.Position + 4].id <> '') and (RCourier[ScrollBar1.Position + 3].availability <> '0')then begin
  CourierLableId4.Caption:='id ' + RCourier[ScrollBar1.Position + 3].id;
  CourierLableName4.Caption:=RCourier[ScrollBar1.Position + 3].name;
  end;

  if (Cou > 4) and (RCourier[ScrollBar1.Position + 4].id <> '')and (RCourier[ScrollBar1.Position+4].availability <> '0') then begin
  CourierLableId5.Caption:='id ' + RCourier[ScrollBar1.Position + 4].id;
  CourierLableName5.Caption:=RCourier[ScrollBar1.Position + 4].name;
  end;
  ScrollBar3Change(Sender);
end;

procedure TFormMain.ScrollBar3Change(Sender: TObject);
begin
try
  if (Ord > 0) and (Cou > 0) then begin
  if TableOC[ScrollBar2.Position,ScrollBar3.Position].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position,ScrollBar3.Position].id,CourierOrder1_1);
  COId1_1.Caption:='id ' + TableOC[ScrollBar2.Position,ScrollBar3.Position].id;
  COAdress1_1.Caption:=TableOC[ScrollBar2.Position,ScrollBar3.Position].adress;
  end;
  if TableOC[ScrollBar2.Position,ScrollBar3.Position + 1].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position,ScrollBar3.Position + 1].id,CourierOrder1_2);
  COId1_2.Caption:='id ' + TableOC[ScrollBar2.Position,ScrollBar3.Position + 1].id;
  COAdress1_2.Caption:=TableOC[ScrollBar2.Position,ScrollBar3.Position + 1].adress;
  end;

  if TableOC[ScrollBar2.Position,ScrollBar3.Position + 2].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position,ScrollBar3.Position + 2].id,CourierOrder1_3);
  COId1_3.Caption:='id ' + TableOC[ScrollBar2.Position,ScrollBar3.Position + 2].id;
  COAdress1_3.Caption:=TableOC[ScrollBar2.Position,ScrollBar3.Position + 2].adress;
  end;
  end;


  if (Ord > 1) and (Cou > 1) then begin
  if TableOC[ScrollBar2.Position + 1,ScrollBar3.Position].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position + 1,ScrollBar3.Position].id,CourierOrder2_1);
  COId2_1.Caption:='id ' + TableOC[ScrollBar2.Position + 1,ScrollBar3.Position].id;
  COAdress2_1.Caption:=TableOC[ScrollBar2.Position + 1,ScrollBar3.Position].adress;
  end;
  if TableOC[ScrollBar2.Position + 1,ScrollBar3.Position + 1].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position + 1,ScrollBar3.Position +1].id,CourierOrder2_2);
  COId2_2.Caption:='id ' + TableOC[ScrollBar2.Position + 1,ScrollBar3.Position + 1].id;
  COAdress2_2.Caption:=TableOC[ScrollBar2.Position + 1,ScrollBar3.Position + 1].adress;
  end;

  if TableOC[ScrollBar2.Position +1,ScrollBar3.Position + 2].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position +1,ScrollBar3.Position + 2].id,CourierOrder2_3);
   COId2_3.Caption:='id ' + TableOC[ScrollBar2.Position + 1,ScrollBar3.Position + 2].id;
  COAdress2_3.Caption:=TableOC[ScrollBar2.Position + 1,ScrollBar3.Position + 2].adress;
  end;

  end;

  if (Ord > 2) and (Cou > 2) then begin
  if TableOC[ScrollBar2.Position + 2,ScrollBar3.Position].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position +2,ScrollBar3.Position].id,CourierOrder3_1);
  COId3_1.Caption:='id ' + TableOC[ScrollBar2.Position + 2,ScrollBar3.Position].id;
  COAdress3_1.Caption:=TableOC[ScrollBar2.Position + 2,ScrollBar3.Position].adress;
  end;

  if TableOC[ScrollBar2.Position + 2,ScrollBar3.Position + 1].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position +2,ScrollBar3.Position+1].id,CourierOrder3_2);
  COId3_2.Caption:='id ' + TableOC[ScrollBar2.Position + 2,ScrollBar3.Position + 1].id;
  COAdress3_2.Caption:=TableOC[ScrollBar2.Position + 2,ScrollBar3.Position + 1].adress;
  end;

  if TableOC[ScrollBar2.Position + 2,ScrollBar3.Position + 2].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position + 2,ScrollBar3.Position + 2].id,CourierOrder3_3);
  COId3_3.Caption:='id ' + TableOC[ScrollBar2.Position + 2,ScrollBar3.Position + 2].id;
  COAdress3_3.Caption:=TableOC[ScrollBar2.Position + 2,ScrollBar3.Position + 2].adress;
  end;

  end;

  if (Ord > 3) and (Cou > 3) then begin
  if TableOC[ScrollBar2.Position + 3,ScrollBar3.Position].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position + 3,ScrollBar3.Position].id,CourierOrder4_1);
  COId4_1.Caption:='id ' + TableOC[ScrollBar2.Position + 3,ScrollBar3.Position].id;
  COAdress4_1.Caption:=TableOC[ScrollBar2.Position + 3,ScrollBar3.Position].adress;
  end;

  if TableOC[ScrollBar2.Position+3,ScrollBar3.Position+1].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position + 3,ScrollBar3.Position + 1].id,CourierOrder4_2);
  COId4_2.Caption:='id ' + TableOC[ScrollBar2.Position + 3,ScrollBar3.Position + 1].id;
  COAdress4_2.Caption:=TableOC[ScrollBar2.Position + 3,ScrollBar3.Position + 1].adress;
  end;

  if TableOC[ScrollBar2.Position+3,ScrollBar3.Position+2].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position + 3,ScrollBar3.Position + 2].id,CourierOrder4_3);
  COId4_3.Caption:='id ' + TableOC[ScrollBar2.Position + 3,ScrollBar3.Position + 2].id;
  COAdress4_3.Caption:=TableOC[ScrollBar2.Position + 3,ScrollBar3.Position + 2].adress;
  end;

  end;

  if (Ord > 4) and (Cou > 4) then begin
  if TableOC[ScrollBar2.Position+4,ScrollBar3.Position].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position + 4,ScrollBar3.Position].id,CourierOrder5_1);
  COId5_1.Caption:='id ' + TableOC[ScrollBar2.Position + 4,ScrollBar3.Position].id;
  COAdress5_1.Caption:=TableOC[ScrollBar2.Position + 4,ScrollBar3.Position].adress;
  end;

  if TableOC[ScrollBar2.Position+4,ScrollBar3.Position+1].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position + 4,ScrollBar3.Position + 1].id,CourierOrder5_2);
  COId5_2.Caption:='id ' + TableOC[ScrollBar2.Position + 4,ScrollBar3.Position + 1].id;
  COAdress5_2.Caption:=TableOC[ScrollBar2.Position + 4,ScrollBar3.Position + 1].adress;

  end;
  if TableOC[ScrollBar2.Position+4,ScrollBar3.Position+2].id <> ''  then begin
  ColorReset(Sender,TableOC[ScrollBar2.Position + 4,ScrollBar3.Position + 2].id,CourierOrder5_3);
  COId5_3.Caption:='id ' + TableOC[ScrollBar2.Position + 4,ScrollBar3.Position + 2].id;
  COAdress5_3.Caption:=TableOC[ScrollBar2.Position + 4,ScrollBar3.Position + 2].adress;

  end;
  end;
  except

end;



end;

procedure TFormMain.ShowPanel(Sender: TObject);
var a:integer;
begin

end;

end.
