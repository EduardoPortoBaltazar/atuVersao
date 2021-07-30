unit internet.Download;

interface

uses
  Vcl.Forms,
  ShellAPI, Winapi.Windows,
  System.Notification,
  System.Classes,
  system.SysUtils,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent;

type TDownload = class

  procedure DownloadFile (sURL, sFILE: string);

  constructor Create;
  destructor Destroy; override;

  private
  NotificationCenter: TNotificationCenter;
  procedure Notificacao(Name, Title, Body: string);

  procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
  ANotification: TNotification);

end;

implementation

uses
  Vcl.Dialogs;

{ TDownload }

constructor TDownload.Create;
begin
  NotificationCenter := TNotificationCenter.Create(nil);
  NotificationCenter.OnReceiveLocalNotification := NotificationCenter1ReceiveLocalNotification;
end;

destructor TDownload.Destroy;
begin
  NotificationCenter.Free;
  inherited;
end;

procedure TDownload.DownloadFile(sURL, sFILE: string);
var
  NetHTTPClient: TNetHTTPClient;
  FileDownload: TFileStream;
begin
  NetHTTPClient := TNetHTTPClient.Create(nil);
  FileDownload := TFileStream.Create(GetCurrentDir + '/' + sFILE, fmCreate);

  TThread.CreateAnonymousThread(
  procedure ()
  begin
    try
     NetHTTPClient.Get(sURL, FileDownload);
    finally
      FileDownload.Free;
      NetHTTPClient.Free;
    end;

     TThread.Synchronize(TThread.CurrentThread,
     procedure()
     begin
      Notificacao('update', 'Atualizacao Disponivel ', 'Clique aqui para Atualizar Agora');
     end
     );
  end
  ).start;
end;
procedure TDownload.Notificacao(Name, Title, Body: string);
var
  Notificacao :TNotification;
begin
  if NotificationCenter.Supported then
  begin
    Notificacao := NotificationCenter.CreateNotification;
    Notificacao.Name      := Name;
    Notificacao.Title     := Title;
    Notificacao.AlertBody := Body;

    Notificacao.FireDate := Now;
    NotificationCenter.PresentNotification(Notificacao);
  end;
end;



procedure TDownload.NotificationCenter1ReceiveLocalNotification(Sender: TObject;
  ANotification: TNotification);
begin
  if ANotification.Name = 'update' then
  begin
    RenameFile(GetCurrentDir + '/AtuVersao.exe', GetCurrentDir + '/AtuVersaoOld.exe');
    RenameFile(GetCurrentDir + '/AtuVersaoNew.exe', GetCurrentDir + '/AtuVersao.exe');

    ShellExecute(0, nil, PChar(GetCurrentDir + '/AtuVersao.exe'), '',nil, SW_SHOWNORMAL);
    Application.Terminate;
  end;
end;

end.
