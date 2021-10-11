program Alarm;

uses
  Forms,
  NP in 'NP.pas' {MainForm},
  AP in 'AP.pas' {AboutForm},
  LP in 'LP.pas' {LicForm},
  OP in 'OP.pas' {SetForm},
  SSP in 'SSP.pas' {ScreenForm},
  AFP in 'AFP.pas' {AttrForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Hell of the Ring';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TLicForm, LicForm);
  Application.CreateForm(TSetForm, SetForm);
  Application.CreateForm(TScreenForm, ScreenForm);
  Application.CreateForm(TAttrForm, AttrForm);
  Application.Run;
end.
