object FormOperatorsAddUpdate: TFormOperatorsAddUpdate
  Left = 0
  Top = 0
  Caption = #1042#1074#1077#1089#1090#1080' '#1076#1072#1085#1085#1099#1077
  ClientHeight = 223
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabelName: TLabel
    Left = 24
    Top = 24
    Width = 23
    Height = 13
    Caption = #1060#1048#1054
  end
  object LabelLogin: TLabel
    Left = 24
    Top = 64
    Width = 30
    Height = 13
    Caption = #1051#1086#1075#1080#1085
  end
  object LabelPass: TLabel
    Left = 24
    Top = 104
    Width = 37
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object EditName: TEdit
    Left = 120
    Top = 21
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = EditChange
  end
  object EditLogin: TEdit
    Left = 120
    Top = 61
    Width = 121
    Height = 21
    TabOrder = 1
    OnChange = EditChange
  end
  object ButtonAdd: TButton
    Left = 24
    Top = 136
    Width = 217
    Height = 25
    Caption = #1042#1074#1086#1076
    TabOrder = 3
    OnClick = ButtonAddClick
  end
  object ButtonCancel: TButton
    Left = 24
    Top = 176
    Width = 217
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = ButtonCancelClick
  end
  object EditPass: TEdit
    Left = 120
    Top = 101
    Width = 121
    Height = 21
    TabOrder = 2
    OnChange = EditChange
  end
  object HTTPCouriersAddUpdate: TIdHTTP
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
    Left = 208
    Top = 160
  end
end
