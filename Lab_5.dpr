program Lab_5;

uses
  Vcl.Forms,
  Laba5 in 'Laba5.pas' {Animation},
  Drawing in 'Drawing.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAnimation, Animation);
  Application.Run;
end.
