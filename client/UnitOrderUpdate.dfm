object FormOrderUpdate: TFormOrderUpdate
  Left = 0
  Top = 0
  Caption = #1054#1073#1085#1086#1074#1090#1100' '#1079#1072#1082#1072#1079
  ClientHeight = 238
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelAddres: TLabel
    Left = 32
    Top = 32
    Width = 31
    Height = 13
    Caption = #1040#1076#1088#1077#1089
  end
  object LabelCourier: TLabel
    Left = 32
    Top = 72
    Width = 37
    Height = 13
    Caption = #1050#1091#1088#1100#1077#1088
  end
  object EditAddress: TEdit
    Left = 112
    Top = 29
    Width = 121
    Height = 21
    TabOrder = 0
    OnClick = EditAddressChange
  end
  object ButtonAdd: TButton
    Left = 32
    Top = 157
    Width = 201
    Height = 25
    Caption = #1054#1073#1085#1086#1074#1090#1100
    TabOrder = 1
    OnClick = ButtonAddClick
  end
  object ButtonCancel: TButton
    Left = 32
    Top = 196
    Width = 201
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = ButtonCancelClick
  end
  object EditCourier: TEdit
    Left = 112
    Top = 69
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object ButtonCourier: TButton
    Left = 112
    Top = 96
    Width = 121
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1050#1091#1088#1100#1077#1088#1072
    TabOrder = 4
    OnClick = ButtonCourierClick
  end
  object CheckBoxVerified: TCheckBox
    Left = 32
    Top = 127
    Width = 97
    Height = 17
    Alignment = taLeftJustify
    Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
    TabOrder = 5
  end
  object HTTPUpdateOrder: TIdHTTP
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
    Left = 128
    Top = 16
  end
end
