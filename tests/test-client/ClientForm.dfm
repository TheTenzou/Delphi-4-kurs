object Client: TClient
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 452
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object IP_label: TLabel
    Left = 24
    Top = 8
    Width = 10
    Height = 13
    Caption = 'IP'
  end
  object port_label: TLabel
    Left = 24
    Top = 51
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Edit1: TEdit
    Left = 24
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 24
    Top = 70
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 192
    Top = 8
    Width = 257
    Height = 145
    Caption = 'GroupBox1'
    TabOrder = 2
    object Label1: TLabel
      Left = 24
      Top = 41
      Width = 34
      Height = 13
      Caption = 'Addres'
    end
    object Label2: TLabel
      Left = 24
      Top = 88
      Width = 22
      Height = 13
      Caption = 'Host'
    end
    object CheckBox1: TCheckBox
      Left = 24
      Top = 18
      Width = 97
      Height = 17
      Caption = 'Connected'
      Enabled = False
      TabOrder = 0
    end
    object Edit3: TEdit
      Left = 24
      Top = 60
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 1
    end
    object Edit4: TEdit
      Left = 24
      Top = 107
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 2
    end
  end
  object Edit5: TEdit
    Left = 24
    Top = 176
    Width = 338
    Height = 21
    TabOrder = 3
  end
  object Button1: TButton
    Left = 24
    Top = 113
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 368
    Top = 174
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 24
    Top = 216
    Width = 419
    Height = 217
    TabOrder = 6
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 392
    Top = 32
  end
  object IdThreadComponent1: TIdThreadComponent
    Active = False
    Loop = False
    Priority = tpNormal
    StopMode = smTerminate
    OnRun = IdThreadComponent1Run
    Left = 336
    Top = 24
  end
end
