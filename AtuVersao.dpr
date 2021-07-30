program AtuVersao;

uses
  Vcl.Forms,
  FAtuVersao in 'Source\FAtuVersao.pas' {Form1},
  internet.Download in 'Ctrl\internet.Download.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
