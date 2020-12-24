object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1086#1074
  ClientHeight = 531
  ClientWidth = 915
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDragDrop = OrderDragDrop
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainLabel2: TLabel
    Left = 732
    Top = 35
    Width = 138
    Height = 13
    Caption = #1053#1077#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1085#1099#1077' '#1079#1072#1082#1072#1079#1099
  end
  object MainLaibel1: TLabel
    Left = 8
    Top = 35
    Width = 108
    Height = 13
    Caption = #1050#1091#1088#1100#1077#1088#1099' '#1080' '#1080#1093' '#1079#1072#1082#1072#1079#1099
  end
  object Orders1: TPanel
    Left = 732
    Top = 56
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    TabOrder = 0
    OnDragDrop = OrderDragDrop
    OnDragOver = OrdersDragOver
    OnMouseDown = MouseDown
    object OrderId1: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object OrderAdress1: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object ScrollBar1: TScrollBar
    Left = 883
    Top = 54
    Width = 18
    Height = 313
    Kind = sbVertical
    PageSize = 0
    TabOrder = 1
    OnChange = ScrollBar1Change
  end
  object ScrollBar2: TScrollBar
    Left = 8
    Top = 54
    Width = 17
    Height = 313
    Kind = sbVertical
    PageSize = 0
    TabOrder = 2
    OnChange = ScrollBar2Change
  end
  object Courier1: TPanel
    Left = 31
    Top = 56
    Width = 145
    Height = 57
    TabOrder = 3
    object CourierLableName1: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
    object CourierLableId1: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
  end
  object Courier2: TPanel
    Left = 31
    Top = 119
    Width = 145
    Height = 58
    TabOrder = 4
    object CourierLableId2: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object CourierLableName2: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object Courier3: TPanel
    Left = 31
    Top = 183
    Width = 145
    Height = 57
    TabOrder = 5
    object CourierLableId3: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object CourierLableName3: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object Devide1: TPanel
    Left = 184
    Top = 56
    Width = 17
    Height = 313
    TabOrder = 6
  end
  object CourierOrder1_1: TPanel
    Left = 207
    Top = 56
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 7
    OnDragDrop = CourierOrder1DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId1_1: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress1_1: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object Devide2: TPanel
    Left = 660
    Top = 56
    Width = 65
    Height = 312
    TabOrder = 8
  end
  object ScrollBar3: TScrollBar
    Left = 207
    Top = 374
    Width = 447
    Height = 19
    PageSize = 0
    TabOrder = 9
    OnChange = ScrollBar3Change
  end
  object Courier4: TPanel
    Left = 31
    Top = 248
    Width = 145
    Height = 57
    TabOrder = 10
    object CourierLableId4: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object CourierLableName4: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object Courier5: TPanel
    Left = 31
    Top = 311
    Width = 145
    Height = 57
    TabOrder = 11
    object CourierLableId5: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object CourierLableName5: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object Orders2: TPanel
    Left = 731
    Top = 119
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    TabOrder = 12
    OnDragDrop = OrderDragDrop
    OnDragOver = OrdersDragOver
    OnMouseDown = MouseDown
    object OrderId2: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object OrderAdress2: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object Orders3: TPanel
    Left = 731
    Top = 182
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    TabOrder = 13
    OnDragDrop = OrderDragDrop
    OnDragOver = OrdersDragOver
    OnMouseDown = MouseDown
    object OrderId3: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object OrderAdress3: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object Orders4: TPanel
    Left = 731
    Top = 248
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    TabOrder = 14
    OnDragDrop = OrderDragDrop
    OnDragOver = OrdersDragOver
    OnMouseDown = MouseDown
    object OrderId4: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object OrderAdress4: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object Orders5: TPanel
    Left = 732
    Top = 311
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    TabOrder = 15
    OnDragDrop = OrderDragDrop
    OnDragOver = OrdersDragOver
    OnMouseDown = MouseDown
    object OrderId5: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object OrderAdress5: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder1_2: TPanel
    Left = 358
    Top = 56
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 16
    OnClick = CourierOrderClick
    OnDragDrop = CourierOrder1DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId1_2: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress1_2: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder1_3: TPanel
    Left = 509
    Top = 56
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 17
    OnDragDrop = CourierOrder1DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId1_3: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress1_3: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder2_1: TPanel
    Left = 207
    Top = 119
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 18
    OnDragDrop = CourierOrder2DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId2_1: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress2_1: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder2_2: TPanel
    Left = 358
    Top = 119
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 19
    OnDragDrop = CourierOrder2DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId2_2: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress2_2: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder2_3: TPanel
    Left = 509
    Top = 119
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 20
    OnDragDrop = CourierOrder2DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId2_3: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress2_3: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder3_1: TPanel
    Left = 207
    Top = 182
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 21
    OnDragDrop = CourierOrder3DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId3_1: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress3_1: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder3_2: TPanel
    Left = 358
    Top = 182
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 22
    OnDragDrop = CourierOrder3DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId3_2: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress3_2: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder3_3: TPanel
    Left = 509
    Top = 182
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 23
    OnDragDrop = CourierOrder3DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId3_3: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress3_3: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder4_1: TPanel
    Left = 207
    Top = 248
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 24
    OnDragDrop = CourierOrder4DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId4_1: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress4_1: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder4_2: TPanel
    Left = 358
    Top = 248
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 25
    OnDragDrop = CourierOrder4DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId4_2: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress4_2: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder4_3: TPanel
    Left = 509
    Top = 248
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 26
    OnDragDrop = CourierOrder4DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId4_3: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress4_3: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder5_1: TPanel
    Left = 207
    Top = 311
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 27
    OnDragDrop = CourierOrder5DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId5_1: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress5_1: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder5_2: TPanel
    Left = 358
    Top = 311
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 28
    OnDragDrop = CourierOrder5DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId5_2: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress5_2: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object CourierOrder5_3: TPanel
    Left = 509
    Top = 311
    Width = 145
    Height = 57
    DragMode = dmAutomatic
    ParentBackground = False
    TabOrder = 29
    OnDragDrop = CourierOrder5DragDrop
    OnDragOver = CourierOrderDragOver
    OnMouseDown = MouseDown
    object COId5_3: TLabel
      Left = 16
      Top = 8
      Width = 3
      Height = 13
    end
    object COAdress5_3: TLabel
      Left = 16
      Top = 27
      Width = 3
      Height = 13
    end
  end
  object MainMenu1: TMainMenu
    Left = 352
    object N1: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnClick = FormShow
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Caption = #1047#1072#1082#1072#1079#1099
      OnClick = N2Click
    end
    object N5: TMenuItem
      Caption = #1058#1086#1074#1072#1088#1099
      OnClick = N5Click
    end
    object N3: TMenuItem
      Caption = #1050#1091#1088#1100#1077#1088#1099
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #1054#1087#1077#1088#1072#1090#1086#1088#1099
      OnClick = N4Click
    end
  end
  object HTTPOrders: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 312
  end
end
