object TestClientForm: TTestClientForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1050#1083#1080#1077#1085#1090' '#1076#1083#1103' '#1090#1077#1089#1090#1086#1074
  ClientHeight = 590
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object IPAddressLabel: TLabel
    Left = 8
    Top = 16
    Width = 43
    Height = 13
    Caption = 'IP '#1072#1076#1088#1077#1089
  end
  object PortLabel: TLabel
    Left = 183
    Top = 16
    Width = 24
    Height = 13
    Caption = #1087#1086#1088#1090
  end
  object URLLabel: TLabel
    Left = 340
    Top = 16
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object IPAddressEdit: TEdit
    Left = 57
    Top = 13
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '127.0.0.1'
  end
  object PortEdit: TEdit
    Left = 213
    Top = 13
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '80'
  end
  object URLEdit: TEdit
    Left = 365
    Top = 13
    Width = 244
    Height = 21
    TabOrder = 2
  end
  object SendButton: TButton
    Left = 8
    Top = 40
    Width = 609
    Height = 25
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
    TabOrder = 3
    OnClick = SendButtonClick
  end
  object RequestMemo: TMemo
    Left = 0
    Top = 73
    Width = 625
    Height = 259
    Align = alBottom
    TabOrder = 4
    ExplicitTop = 76
    ExplicitWidth = 620
  end
  object ResponseMemo: TMemo
    Left = 0
    Top = 332
    Width = 625
    Height = 258
    Align = alBottom
    TabOrder = 5
    ExplicitLeft = 1
    ExplicitTop = 335
    ExplicitWidth = 616
  end
  object HTTP: TIdHTTP
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
    Left = 16
    Top = 88
  end
end
