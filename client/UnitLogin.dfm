object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1050#1083#1080#1077#1085#1090
  ClientHeight = 156
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object LabelLogin: TLabel
    Left = 32
    Top = 48
    Width = 30
    Height = 13
    Caption = #1051#1086#1075#1080#1085
  end
  object LabelPass: TLabel
    Left = 32
    Top = 80
    Width = 37
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object LabelIP: TLabel
    Left = 32
    Top = 16
    Width = 10
    Height = 13
    Caption = 'IP'
  end
  object EditLogin: TEdit
    Left = 88
    Top = 45
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object EditPassword: TEdit
    Left = 88
    Top = 77
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object ButtonLogin: TButton
    Left = 32
    Top = 112
    Width = 177
    Height = 25
    Caption = #1042#1086#1081#1090#1080
    TabOrder = 2
    OnClick = ButtonLoginClick
  end
  object EditIP: TEdit
    Left = 88
    Top = 14
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '127.0.0.1:80'
  end
  object IdHTTPLogin: TIdHTTP
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
    Left = 176
    Top = 112
  end
end
