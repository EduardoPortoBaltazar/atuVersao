unit FAtuVersao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, Vcl.Buttons,
  System.Notification;

type
  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  internet.Download;

{$R *.dfm}

var D: TDownload;

procedure TForm1.FormCreate(Sender: TObject);
begin
  d := TDownload.Create;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  d.DownloadFile('https://firebasestorage.googleapis.com/v0/b/curriculo-eduardo-porto.appspot.com/o/AtuVersao.exe?alt=media&token=2d362a5a-4497-4b4a-968d-d37fd6faf049',
                 'AtuVersaoNew.exe');

end;

end.
