object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Look precisely'
  ClientHeight = 433
  ClientWidth = 731
  Color = clWhite
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 24
    Top = 64
    Width = 441
    Height = 361
    Stretch = True
  end
  object Panel1: TPanel
    Left = 8
    Top = 1
    Width = 705
    Height = 64
    Color = clCream
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 77
      Height = 16
      Caption = 'Scale=100 %'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 398
      Top = 8
      Width = 59
      Height = 16
      Caption = 'Top =o px'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 204
      Top = 8
      Width = 58
      Height = 16
      Caption = 'Left= 0 px'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Image2: TImage
      Left = 48
      Top = 30
      Width = 360
      Height = 30
      Stretch = True
    end
    object Label4: TLabel
      Left = 11
      Top = 30
      Width = 24
      Height = 13
      Caption = '____'
    end
    object Label5: TLabel
      Left = 104
      Top = 30
      Width = 24
      Height = 13
      Caption = '____'
    end
    object Label6: TLabel
      Left = 204
      Top = 30
      Width = 24
      Height = 13
      Caption = '____'
    end
    object Label7: TLabel
      Left = 304
      Top = 30
      Width = 24
      Height = 13
      Caption = '____'
    end
    object Label8: TLabel
      Left = 414
      Top = 30
      Width = 24
      Height = 13
      Caption = '____'
    end
    object SpeedButton1: TSpeedButton
      Left = 463
      Top = 32
      Width = 104
      Height = 22
      Caption = 'Save img'#39's'
      OnClick = SpeedButton1Click
    end
    object ScrollBar1: TScrollBar
      Left = 91
      Top = 8
      Width = 107
      Height = 16
      Max = 200
      PageSize = 0
      Position = 100
      TabOrder = 0
      OnChange = ScrollBar1Change
    end
    object ScrollBar2: TScrollBar
      Left = 277
      Top = 8
      Width = 102
      Height = 16
      PageSize = 0
      TabOrder = 1
      OnChange = ScrollBar2Change
    end
    object ScrollBar3: TScrollBar
      Left = 463
      Top = 10
      Width = 104
      Height = 16
      PageSize = 0
      TabOrder = 2
      OnChange = ScrollBar3Change
    end
    object CheckBox1: TCheckBox
      Left = 589
      Top = 9
      Width = 76
      Height = 17
      Caption = 'Rastr/Frac'
      TabOrder = 3
      OnClick = CheckBox1Click
    end
  end
end
