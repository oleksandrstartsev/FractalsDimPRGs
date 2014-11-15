unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Image1: TImage;
    ScrollBar1: TScrollBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ScrollBar2: TScrollBar;
    ScrollBar3: TScrollBar;
    Panel1: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form3.Hide;

end;

procedure TForm3.ScrollBar1Change(Sender: TObject);
begin
Form3.Image1.Width:=round(Form3.Image1.Picture.Width*Form3.ScrollBar1.Position/100);
Form3.Image1.Height:=round(Form3.Image1.Picture.Height*Form3.ScrollBar1.Position/100);
if Form3.Image1.Width>700 then
 Form3.Width:=round(Form3.Image1.Picture.Width*Form3.ScrollBar1.Position/100)+100;
 if Form3.Image1.Width>460 then
Form3.Height:=round(Form3.Image1.Picture.Height*Form3.ScrollBar1.Position/100)+100;
Form3.Label1.Caption:='Scale= '+InttoStr(Form3.ScrollBar1.Position)+'%';
end;

procedure TForm3.ScrollBar2Change(Sender: TObject);
begin
 Form3.Image1.Left:=24-round(Form3.Image1.Picture.Width*Form3.ScrollBar2.Position/100);

Form3.Label2.Caption:='Left= '+InttoStr(-Form3.ScrollBar2.Position)+'px';
end;

procedure TForm3.ScrollBar3Change(Sender: TObject);
begin
   Form3.Image1.Top:=40-round(Form3.Image1.Picture.Height*Form3.ScrollBar3.Position/100);

Form3.Label3.Caption:='Top= '+InttoStr(-Form3.ScrollBar3.Position)+'px';
end;

end.
