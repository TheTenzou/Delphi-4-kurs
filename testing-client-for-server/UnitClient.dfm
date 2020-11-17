object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Test Client'
  ClientHeight = 537
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
  object Label1: TLabel
    Left = 40
    Top = 16
    Width = 52
    Height = 13
    Caption = 'IP Address'
  end
  object Label2: TLabel
    Left = 304
    Top = 16
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object RichEdit1: TRichEdit
    Left = 18
    Top = 56
    Width = 601
    Height = 225
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Zoom = 100
  end
  object RichEdit2: TRichEdit
    Left = 18
    Top = 304
    Width = 601
    Height = 225
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Zoom = 100
  end
  object Button1: TButton
    Left = 18
    Top = 280
    Width = 295
    Height = 25
    Caption = 'Send'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 98
    Top = 13
    Width = 200
    Height = 21
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 330
    Top = 13
    Width = 143
    Height = 21
    TabOrder = 4
  end
  object Button2: TButton
    Left = 488
    Top = 11
    Width = 139
    Height = 25
    Caption = 'Connect'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 398
    Top = 280
    Width = 75
    Height = 25
    Caption = 'http'
    TabOrder = 6
    OnClick = Button3Click
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnRead = ClientSocket1Read
    Left = 10
    Top = 8
  end
  object IdHTTP1: TIdHTTP
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
    Left = 64
    Top = 136
  end
end
