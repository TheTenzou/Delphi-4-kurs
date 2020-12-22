object FormCouriers: TFormCouriers
  Left = 0
  Top = 0
  Caption = #1050#1091#1088#1100#1077#1088#1099
  ClientHeight = 319
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StringGridCouriers: TStringGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 319
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 256
    ExplicitTop = 104
    ExplicitWidth = 320
    ExplicitHeight = 120
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 32
    object N1: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N3: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1090#1100
    end
    object N4: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
    end
    object N5: TMenuItem
      Caption = #1059#1076#1072#1080#1090#1100
    end
    object N6: TMenuItem
      Caption = #1053#1072#1079#1072#1076
    end
  end
  object HTTPCouriers: TIdHTTP
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
    Left = 560
    Top = 24
  end
end
