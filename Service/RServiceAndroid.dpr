program RServiceAndroid;

uses
  System.Android.ServiceApplication,
  uMainService in 'uMainService.pas' {DM: TAndroidService};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
