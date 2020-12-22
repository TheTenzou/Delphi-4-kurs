object FormCouriresAddUpdate: TFormCouriresAddUpdate
  Left = 0
  Top = 0
  Caption = #1042#1074#1086#1076' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 221
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
  object LabelAvailability: TLabel
    Left = 32
    Top = 64
    Width = 54
    Height = 13
    Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
  end
  object LabelLogin: TLabel
    Left = 32
    Top = 96
    Width = 30
    Height = 13
    Caption = #1051#1086#1075#1080#1085
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
    Top = 93
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object ComboBoxAvailability: TComboBox
    Left = 128
    Top = 61
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object ButtonAdd: TButton
    Left = 32
    Top = 136
    Width = 217
    Height = 25
    Caption = #1042#1074#1086#1076
    TabOrder = 3
  end
  object ButtonCancel: TButton
    Left = 32
    Top = 176
    Width = 217
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = ButtonCancelClick
  end
end
