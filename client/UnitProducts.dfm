object FormProducts: TFormProducts
  Left = 0
  Top = 0
  Caption = #1058#1086#1074#1072#1088#1099
  ClientHeight = 540
  ClientWidth = 635
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StringGridProducts: TStringGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 540
    Align = alClient
    TabOrder = 0
    OnClick = StringGridProductsClick
    ExplicitLeft = 24
    ExplicitTop = 80
    ExplicitWidth = 569
    ExplicitHeight = 177
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 16
    object N5: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnClick = N5Click
    end
    object N1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1090#1100
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #1047#1072#1082#1088#1099#1090#1100
      OnClick = N4Click
    end
  end
  object HTTPProducts: TIdHTTP
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
    Left = 576
    Top = 16
  end
end
