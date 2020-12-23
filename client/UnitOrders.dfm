object FormOrders: TFormOrders
  Left = 0
  Top = 0
  Caption = #1047#1072#1082#1072#1079#1099
  ClientHeight = 444
  ClientWidth = 630
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
    Top = 280
    Width = 630
    Height = 164
    Align = alBottom
    TabOrder = 0
  end
  object StringGridOrders: TStringGrid
    Left = 0
    Top = 0
    Width = 630
    Height = 280
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 168
    ExplicitTop = 144
    ExplicitWidth = 320
    ExplicitHeight = 120
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 24
    object N1: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    end
    object N2: TMenuItem
      Caption = #1053#1072#1079#1072#1076
      OnClick = N2Click
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
    Top = 184
  end
end
