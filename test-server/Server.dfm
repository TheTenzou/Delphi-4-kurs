object ServerForm: TServerForm
  Left = 0
  Top = 0
  Caption = 'Server'
  ClientHeight = 435
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 313
    Height = 401
    Caption = 'GroupBox1'
    TabOrder = 0
    object Label6: TLabel
      Left = 16
      Top = 32
      Width = 31
      Height = 13
      Caption = 'Label6'
    end
    object Edit6: TEdit
      Left = 16
      Top = 51
      Width = 281
      Height = 21
      TabOrder = 0
    end
    object Button2: TButton
      Left = 16
      Top = 78
      Width = 75
      Height = 25
      Caption = 'Button2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Memo1: TMemo
      Left = 16
      Top = 121
      Width = 281
      Height = 256
      Lines.Strings = (
        '')
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 344
    Top = 8
    Width = 275
    Height = 401
    Caption = 'GroupBox2'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 76
      Height = 13
      Caption = 'Port to listen on'
    end
    object Label2: TLabel
      Left = 16
      Top = 115
      Width = 51
      Height = 13
      Caption = 'IP address'
    end
    object Label3: TLabel
      Left = 16
      Top = 152
      Width = 61
      Height = 13
      Caption = 'Remote host'
    end
    object Label4: TLabel
      Left = 16
      Top = 192
      Width = 31
      Height = 13
      Caption = 'Status'
    end
    object Label5: TLabel
      Left = 16
      Top = 232
      Width = 78
      Height = 13
      Caption = 'Local IP address'
    end
    object CheckBox1: TCheckBox
      Left = 16
      Top = 81
      Width = 97
      Height = 17
      Caption = 'Connected'
      Enabled = False
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 16
      Top = 51
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object Button1: TButton
      Left = 152
      Top = 49
      Width = 75
      Height = 25
      Caption = 'Activate'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 99
      Top = 112
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object Edit3: TEdit
      Left = 99
      Top = 149
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 4
    end
    object Edit4: TEdit
      Left = 99
      Top = 189
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 5
    end
    object Edit5: TEdit
      Left = 99
      Top = 229
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 6
    end
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnAccept = ServerSocket1Accept
    OnClientRead = ServerSocket1ClientRead
    Left = 504
    Top = 320
  end
end
