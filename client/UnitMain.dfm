object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1086#1074
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
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object N1: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Caption = #1047#1072#1082#1072#1079#1099
    end
    object N5: TMenuItem
      Caption = #1058#1086#1074#1072#1088#1099
      OnClick = N5Click
    end
    object N3: TMenuItem
      Caption = #1050#1091#1088#1100#1077#1088#1099
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #1054#1087#1077#1088#1072#1090#1086#1088#1099
    end
  end
end
