object ServerForm: TServerForm
  Left = 0
  Top = 0
  Caption = #1057#1077#1088#1074#1077#1088
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PortLabel: TLabel
    Left = 8
    Top = 24
    Width = 25
    Height = 13
    Caption = #1055#1086#1088#1090
  end
  object PortEdit: TEdit
    Left = 56
    Top = 21
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object StartButton: TButton
    Left = 192
    Top = 19
    Width = 97
    Height = 25
    Caption = #1047#1072#1087#1091#1089#1082' '#1089#1077#1088#1074#1077#1088#1072
    TabOrder = 1
    OnClick = StartButtonClick
  end
  object StopButton: TButton
    Left = 312
    Top = 19
    Width = 105
    Height = 25
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090' '#1089#1077#1088#1074#1077#1088
    TabOrder = 2
    OnClick = StopButtonClick
  end
  object StatusMemo: TMemo
    Left = 0
    Top = 50
    Width = 635
    Height = 249
    Align = alBottom
    Enabled = False
    TabOrder = 3
  end
  object HTTPServer: TIdHTTPServer
    Bindings = <>
    Left = 584
    Top = 16
  end
end
