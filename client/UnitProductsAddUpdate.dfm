object FormProductsAddUpdate: TFormProductsAddUpdate
  Left = 0
  Top = 0
  Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 164
  ClientWidth = 258
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = EditNameChange
  PixelsPerInch = 96
  TextHeight = 13
  object LabelName: TLabel
    Left = 32
    Top = 24
    Width = 73
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object LabelPrice: TLabel
    Left = 32
    Top = 56
    Width = 26
    Height = 13
    Caption = #1062#1077#1085#1072
  end
  object EditName: TEdit
    Left = 111
    Top = 21
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = EditNameChange
  end
  object EditPrice: TEdit
    Left = 111
    Top = 53
    Width = 121
    Height = 21
    TabOrder = 1
    OnChange = EditNameChange
    OnKeyPress = EditPriceKeyPress
  end
  object ButtonInsert: TButton
    Left = 32
    Top = 88
    Width = 200
    Height = 25
    Caption = #1042#1074#1077#1089#1090#1080
    TabOrder = 2
    OnClick = ButtonInsertClick
  end
  object ButtonCancel: TButton
    Left = 32
    Top = 125
    Width = 200
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = ButtonCancelClick
  end
  object HTTPProductsAddUpdate: TIdHTTP
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
    Top = 104
  end
end
