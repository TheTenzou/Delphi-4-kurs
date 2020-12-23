object FormOrders: TFormOrders
  Left = 0
  Top = 0
  Caption = #1047#1072#1082#1072#1079#1099
  ClientHeight = 627
  ClientWidth = 1250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StringGridOrderInfo: TStringGrid
    Left = 0
    Top = 383
    Width = 1250
    Height = 244
    Align = alBottom
    TabOrder = 0
    OnClick = StringGridOrderInfoClick
    ExplicitTop = 200
    ExplicitWidth = 630
  end
  object StringGridOrders: TStringGrid
    Left = 0
    Top = 0
    Width = 1250
    Height = 383
    Align = alClient
    TabOrder = 1
    OnClick = StringGridOrdersClick
    OnDrawCell = StringGridOrdersDrawCell
    ExplicitTop = -6
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 24
    object N1: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1053#1072#1079#1072#1076
      OnClick = N2Click
    end
    object N4: TMenuItem
      Caption = #1047#1072#1082#1072#1079#1099
      object N3: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1090#1100
        OnClick = N3Click
      end
      object N5: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        OnClick = N5Click
      end
    end
    object N6: TMenuItem
      Caption = #1058#1086#1074#1072#1088#1099
      object N7: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1090#1100
        OnClick = N7Click
      end
      object N8: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        OnClick = N8Click
      end
      object N9: TMenuItem
        Caption = #1059#1076#1072#1083#1090#1100
        OnClick = N9Click
      end
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
    Left = 504
    Top = 56
  end
end
