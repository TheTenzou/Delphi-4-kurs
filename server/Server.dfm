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
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 24
    Top = 8
    Width = 353
    Height = 265
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 472
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=E:\My_Progs\delphi\Delphi-4-kurs\server\DataBase.db'
      'DriverID=SQLite')
    Left = 432
    Top = 32
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 568
    Top = 32
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 496
    Top = 32
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 568
    Top = 112
  end
end
