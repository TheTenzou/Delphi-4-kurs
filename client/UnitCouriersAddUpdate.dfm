object FormCouriresAddUpdate: TFormCouriresAddUpdate
  Left = 0
  Top = 0
  Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 227
  ClientWidth = 274
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
  object LabelName: TLabel
    Left = 32
    Top = 32
    Width = 23
    Height = 13
    Caption = #1060#1048#1054
  end
  object LabelLogin: TLabel
    Left = 32
    Top = 72
    Width = 30
    Height = 13
    Caption = #1051#1086#1075#1080#1085
  end
  object LabelPass: TLabel
    Left = 32
    Top = 112
    Width = 37
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object EditName: TEdit
    Left = 128
    Top = 29
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object EditLogin: TEdit
    Left = 128
    Top = 69
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object ButtonAdd: TButton
    Left = 32
    Top = 144
    Width = 217
    Height = 25
    Caption = #1042#1074#1086#1076
    TabOrder = 2
  end
  object ButtonCancel: TButton
    Left = 32
    Top = 184
    Width = 217
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = ButtonCancelClick
  end
  object EditPass: TEdit
    Left = 128
    Top = 109
    Width = 121
    Height = 21
    TabOrder = 4
  end
end
