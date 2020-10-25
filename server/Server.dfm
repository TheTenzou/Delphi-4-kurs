object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Server'
  ClientHeight = 316
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 400
    Top = 13
    Width = 25
    Height = 13
    Caption = #1055#1086#1088#1090
  end
  object Button1: TButton
    Left = 400
    Top = 272
    Width = 75
    Height = 25
    Caption = 'bd connection'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 400
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
    OnChange = Edit1Change
  end
  object Button2: TButton
    Left = 400
    Top = 72
    Width = 75
    Height = 25
    Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 408
    Top = 144
    Width = 75
    Height = 25
    Caption = 'json'
    TabOrder = 3
    OnClick = Button3Click
  end
  object RichEdit1: TRichEdit
    Left = 24
    Top = 13
    Width = 337
    Height = 260
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'RichEdit1')
    ParentFont = False
    TabOrder = 4
    Zoom = 100
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=E:\My_Progs\delphi\Delphi-4-kurs\server\DataBase.db'
      'DriverID=SQLite')
    Left = 424
    Top = 208
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 496
    Top = 208
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientRead = ServerSocket1ClientRead
    Left = 568
    Top = 16
  end
end
