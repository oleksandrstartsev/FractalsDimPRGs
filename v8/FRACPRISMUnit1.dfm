object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'FRAC3D PRISM'
  ClientHeight = 544
  ClientWidth = 739
  Color = clGray
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 153
    Height = 537
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 5
      Top = 8
      Width = 145
      Height = 22
      Hint = 'Choose you method and press'
      Caption = 'Calculate with sliding1'
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 0
      Top = 281
      Width = 145
      Height = 22
      Hint = 
        'Import the IR-data .IS2 file and transform into  .txt with a spe' +
        'cial structure format '
      Caption = 'Import and transform'
      OnClick = SpeedButton2Click
    end
    object ClearButton: TSpeedButton
      Left = 88
      Top = 494
      Width = 50
      Height = 34
      Caption = 'Clear'
      OnClick = ClearButtonClick
    end
    object SpeedButton3: TSpeedButton
      Left = 5
      Top = 494
      Width = 45
      Height = 34
      Caption = 'Font -'
      OnClick = SpeedButton3Click
    end
    object SpeedButton4: TSpeedButton
      Left = 43
      Top = 494
      Width = 48
      Height = 34
      Caption = 'Font+'
      OnClick = SpeedButton4Click
    end
    object SpeedButton5: TSpeedButton
      Left = 0
      Top = 253
      Width = 145
      Height = 22
      Hint = 'test Clarke'#39's "86 on a sample file: image .txt'
      Caption = 'test Clarke'#39's as "85'
      OnClick = SpeedButton5Click
    end
    object SpeedButton6: TSpeedButton
      Left = 13
      Top = 36
      Width = 58
      Height = 22
      Hint = 'save calculated fractal matrix into file'
      Caption = 'Save FM'
      OnClick = SpeedButton6Click
    end
    object SpeedButton7: TSpeedButton
      Left = 77
      Top = 36
      Width = 49
      Height = 22
      Hint = 'show calculated fractal matrix on screen'
      Caption = 'Show FM'
      OnClick = SpeedButton7Click
    end
    object Label1: TLabel
      Left = 13
      Top = 367
      Width = 26
      Height = 13
      Caption = 'steps'
    end
    object Label2: TLabel
      Left = 3
      Top = 318
      Width = 47
      Height = 13
      Caption = 'NUMROW'
    end
    object Label3: TLabel
      Left = 2
      Top = 337
      Width = 42
      Height = 13
      Caption = 'NUMCOL'
    end
    object CheckBox1: TCheckBox
      Left = 13
      Top = 441
      Width = 108
      Height = 17
      Caption = 'Show data saving'
      TabOrder = 0
    end
    object LabeledEdit3: TLabeledEdit
      Left = 127
      Top = 286
      Width = 81
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'br'
      Enabled = False
      LabelPosition = lpLeft
      TabOrder = 1
      Text = '1'
      Visible = False
    end
    object LabeledEdit5: TLabeledEdit
      Left = 127
      Top = 213
      Width = 81
      Height = 21
      EditLabel.Width = 11
      EditLabel.Height = 13
      EditLabel.Caption = 'bc'
      Enabled = False
      LabelPosition = lpLeft
      TabOrder = 2
      Text = '1'
      Visible = False
    end
    object LabeledEdit6: TLabeledEdit
      Left = 127
      Top = 240
      Width = 81
      Height = 21
      EditLabel.Width = 11
      EditLabel.Height = 13
      EditLabel.Caption = 'ec'
      Enabled = False
      LabelPosition = lpLeft
      TabOrder = 3
      Text = '17'
      Visible = False
    end
    object Swich1: TCheckBox
      Left = 13
      Top = 457
      Width = 97
      Height = 17
      Caption = 'Swich #1'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object ShowInput: TCheckBox
      Left = 13
      Top = 471
      Width = 97
      Height = 17
      Caption = 'Show Input'
      TabOrder = 5
    end
    object LabeledEdit7: TSpinEdit
      Left = 45
      Top = 365
      Width = 65
      Height = 22
      MaxValue = 21
      MinValue = 3
      TabOrder = 6
      Value = 3
    end
    object LabeledEdit4: TLabeledEdit
      Left = 127
      Top = 313
      Width = 81
      Height = 21
      EditLabel.Width = 10
      EditLabel.Height = 13
      EditLabel.Caption = 'er'
      Enabled = False
      LabelPosition = lpLeft
      TabOrder = 7
      Text = '17'
      Visible = False
    end
    object LabeledEdit1: TSpinEdit
      Left = 56
      Top = 309
      Width = 65
      Height = 22
      MaxValue = 5000
      MinValue = 7
      TabOrder = 8
      Value = 17
    end
    object LabeledEdit2: TSpinEdit
      Left = 56
      Top = 337
      Width = 65
      Height = 22
      MaxValue = 5000
      MinValue = 7
      TabOrder = 9
      Value = 17
    end
    object RadioGroup1: TRadioGroup
      Left = 0
      Top = 64
      Width = 145
      Height = 183
      Caption = 'Clarke methods'
      TabOrder = 10
    end
    object RadioButton1: TRadioButton
      Left = 13
      Top = 76
      Width = 113
      Height = 17
      Hint = 'step-squared slope'
      Caption = 'classic Clarke'#39's "86'
      Checked = True
      TabOrder = 11
      TabStop = True
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 13
      Top = 91
      Width = 113
      Height = 17
      Hint = 'not step-squared slope'
      Caption = 'Qiu Lam modification'
      TabOrder = 12
      OnClick = RadioButton2Click
    end
    object RadioButton3: TRadioButton
      Left = 3
      Top = 114
      Width = 103
      Height = 32
      Hint = 
        '8-px method by Sun, 2004, You should check correct slope in the ' +
        'checkedBox below'
      Caption = 'Eight Px method'
      TabOrder = 13
      OnClick = RadioButton3Click
    end
    object CheckBox2: TCheckBox
      Left = 27
      Top = 221
      Width = 111
      Height = 17
      Hint = 'step-square slope'
      Caption = 'step-squared slope'
      TabOrder = 14
    end
    object RadioButton4: TRadioButton
      Left = 3
      Top = 137
      Width = 103
      Height = 17
      Hint = 
        'Max-diff method by Sun, 2004, You should check correct slope in ' +
        'the checkedBox below'
      Caption = 'Max-difference'
      TabOrder = 15
      OnClick = RadioButton1Click
    end
    object RadioButton5: TRadioButton
      Left = 2
      Top = 152
      Width = 113
      Height = 17
      Hint = 
        'mean-diff method by Sun, 2004, You should check correct slope in' +
        ' the checkedBox below'
      Caption = 'Mean-difference'
      TabOrder = 16
      OnClick = RadioButton1Click
    end
    object RadioButton6: TRadioButton
      Left = 2
      Top = 175
      Width = 136
      Height = 17
      Caption = 'arithmetic-step method'
      TabOrder = 17
      OnClick = RadioButton6Click
    end
    object RadioButton7: TRadioButton
      Left = 2
      Top = 198
      Width = 136
      Height = 17
      Caption = 'divisor-step'
      TabOrder = 18
      OnClick = RadioButton6Click
    end
  end
  object Memo1: TMemo
    Left = 199
    Top = 16
    Width = 449
    Height = 472
    Color = clInfoText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 373
    Width = 161
    Height = 58
    TabOrder = 2
    Visible = False
    object LabeledEdit8: TLabeledEdit
      Left = 103
      Top = 9
      Width = 43
      Height = 21
      Color = clYellow
      EditLabel.Width = 85
      EditLabel.Height = 13
      EditLabel.Caption = 'window size<<'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clDefault
      EditLabel.Font.Height = -11
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Orientation = -1
      EditLabel.Font.Style = [fsBold, fsItalic]
      EditLabel.ParentFont = False
      LabelPosition = lpLeft
      TabOrder = 0
      Text = '5'
    end
    object CheckBox3: TCheckBox
      Left = 8
      Top = 36
      Width = 153
      Height = 17
      Caption = 'coverage ratio normalization'
      TabOrder = 1
    end
  end
end
