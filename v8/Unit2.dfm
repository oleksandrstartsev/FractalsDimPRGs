object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Image'
  ClientHeight = 469
  ClientWidth = 886
  Color = clBtnHighlight
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
    Left = 32
    Top = 80
    Width = 800
    Height = 591
    Stretch = True
  end
  object SpeedButton1: TSpeedButton
    Left = 71
    Top = -8
    Width = 146
    Height = 33
    Caption = 'Convert to grayscale'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 215
    Top = -8
    Width = 98
    Height = 33
    Caption = 'Save gray as .txt'
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 8
    Top = -8
    Width = 67
    Height = 33
    Caption = 'Load Image'
    OnClick = SpeedButton3Click
  end
  object SpeedButton4: TSpeedButton
    Left = 311
    Top = -8
    Width = 98
    Height = 33
    BiDiMode = bdRightToLeft
    Caption = 'Show Dfc '
    ParentBiDiMode = False
    OnClick = SpeedButton4Click
  end
  object Image2: TImage
    Left = 14
    Top = 44
    Width = 443
    Height = 30
    Stretch = True
  end
  object SpeedButton5: TSpeedButton
    Left = 481
    Top = 0
    Width = 96
    Height = 22
    Caption = 'Look precisely'
    OnClick = SpeedButton5Click
  end
  object Label1: TLabel
    Left = 10
    Top = 25
    Width = 3
    Height = 13
  end
  object Label2: TLabel
    Left = 106
    Top = 25
    Width = 3
    Height = 13
  end
  object Label3: TLabel
    Left = 225
    Top = 25
    Width = 3
    Height = 13
  end
  object Label4: TLabel
    Left = 330
    Top = 25
    Width = 3
    Height = 13
  end
  object Label5: TLabel
    Left = 444
    Top = 25
    Width = 31
    Height = 13
    Caption = 'Label5'
  end
  object SpeedButton6: TSpeedButton
    Left = 609
    Top = 2
    Width = 72
    Height = 24
    Caption = 'Save img'#39's'
    OnClick = SpeedButton6Click
  end
  object Memo1: TMemo
    Left = 838
    Top = 72
    Width = 363
    Height = 361
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object LabeledEdit1: TLabeledEdit
    Left = 781
    Top = 45
    Width = 97
    Height = 21
    EditLabel.Width = 90
    EditLabel.Height = 13
    EditLabel.Caption = 'bottom threshold::'
    LabelPosition = lpLeft
    TabOrder = 1
    Text = '0'
  end
  object LabeledEdit2: TLabeledEdit
    Left = 782
    Top = 8
    Width = 96
    Height = 21
    EditLabel.Width = 84
    EditLabel.Height = 13
    EditLabel.Caption = 'upper threshold::'
    LabelPosition = lpLeft
    TabOrder = 2
    Text = '100'
    OnChange = LabeledEdit2Change
  end
  object CheckBox1: TCheckBox
    Left = 415
    Top = 2
    Width = 66
    Height = 17
    Caption = 'Gray/RGB'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 512
    Top = 32
    Width = 129
    Height = 17
    Caption = 'input data/frac map'
    TabOrder = 4
    OnClick = CheckBox2Click
  end
  object OpenDialog1: TOpenDialog
    Left = 560
    Top = 16
  end
end
