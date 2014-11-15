object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 433
  ClientWidth = 728
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
    Top = 40
    Width = 441
    Height = 361
    Stretch = True
  end
  object Panel1: TPanel
    Left = 8
    Top = 0
    Width = 681
    Height = 33
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
      Left = 472
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
      Left = 224
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
    object ScrollBar1: TScrollBar
      Left = 105
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
      Left = 317
      Top = 8
      Width = 102
      Height = 16
      PageSize = 0
      TabOrder = 1
      OnChange = ScrollBar2Change
    end
    object ScrollBar3: TScrollBar
      Left = 557
      Top = 8
      Width = 104
      Height = 16
      PageSize = 0
      TabOrder = 2
      OnChange = ScrollBar3Change
    end
  end
end
