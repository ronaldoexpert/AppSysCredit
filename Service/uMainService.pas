unit uMainService;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Android.Service,
  AndroidApi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Os,
  Androidapi.JNI.App,System.Threading,
  System.Notification,
  System.DateUtils;

type
  TDM = class(TAndroidService)
    NotificationCenter1: TNotificationCenter;
    function AndroidServiceStartCommand(const Sender: TObject;
      const Intent: JIntent; Flags, StartId: Integer): Integer;
  private
    { Private declarations }
    vNotificou : integer;
  public
    { Public declarations }
    T:ITask;
    procedure LaunchNotification(name,title,body:string);
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

function TDM.AndroidServiceStartCommand(const Sender: TObject;
  const Intent: JIntent; Flags, StartId: Integer): Integer;
var
  vData : Word;
begin
  vData :=  DayOf(Date);
  Result := TJService.JavaClass.START_STICKY;
  if (vNotificou = 0) and (vData = 08) then
  begin
    vNotificou = 1;
    T := TTask.Run (procedure
    begin
      While true do
      begin
        sleep(5000);
        LaunchNotification('Boleto','AppSysCredit','O cart�o vira hoje. J� pode solicitar o seu boleto!');
        exit;
      end;
    end);
  end
  else if vData <> 08 then       
    vNotificou = 0;
end;

procedure TDM.LaunchNotification(name, title, body: string);
var
  MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  try
    MyNotification.Name := name;
    MyNotification.Title := title;
    MyNotification.AlertBody := body;
    MyNotification.FireDate := IncSecond(Now, 1);
    MyNotification.EnableSound := True;
    NotificationCenter1.ScheduleNotification(MyNotification);
    vNotificou := 1;
  finally
    MyNotification.Free;
  end;
end;

end.
