object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Image IOC'
  ClientHeight = 515
  ClientWidth = 703
  Color = clBtnHighlight
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
    Top = 88
    Width = 257
    Height = 233
  end
  object Panel1: TPanel
    Left = 24
    Top = 8
    Width = 609
    Height = 49
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 24
      Top = 0
      Width = 153
      Height = 33
      Caption = 'Open Image'
      OnClick = SpeedButton1Click
    end
  end
  object Memo1: TMemo
    Left = 287
    Top = 88
    Width = 346
    Height = 233
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    Left = 336
    Top = 64
  end
end
