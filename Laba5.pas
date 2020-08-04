unit Laba5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.MPlayer;

type
  TAnimation = class(TForm)
    TimerRunner: TTimer;
    MediaPlayer1: TMediaPlayer;

    procedure TimerRunnerTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Animation: TAnimation;

implementation

uses Drawing;   // подключение модуля с процедурами рисования

const
    n=60;
    kf = round(n / 5);

var x, y, i, j,h, a, b, z,m,koef1, koef2,q,l: integer;
      k,koef3: real;

{$R *.dfm}

procedure TAnimation.FormActivate(Sender: TObject);
begin
  canvas.Pen.Width := 4;
  x:=50;  // координата х начального положения
  y:=100; // координата у начального положения
  k:=1;   // начальное значение кооэффициента масштабирования
  i:=1;   // начальное значение переменной, отвечающей за смену движения
  j:=1;
  a:=50;
  b:=300;
  z:=1;
  q:=1;
  koef1:=580;
  koef2:=170;
  h:=1;
  koef3:=1.25;
  TimerRunner.Interval:=80;
  DrawImage(canvas);
end;

procedure TAnimation.FormCreate(Sender: TObject); // при создании формы
begin
MediaPlayer1.FileName := 'GymnasticSong.mp3';   // присвоение нового значения
Mediaplayer1.Open;             // сканирование значения FileName  и запуск
Mediaplayer1.Play;             // использует старые данные FileName и запускает т.е. как обычное нажатие кнопки btPlay
end;

  procedure TAnimation.FormResize(Sender: TObject); // При изменении размеров окна, перерисовываем Background по новым размерам
begin
  DrawImage(canvas);
end;

procedure TAnimation.TimerRunnerTimer(Sender: TObject);
begin
 DrawImage(canvas);
  case i of
    1: // Положение 1 при беге вправо
      begin
        Body1(x, y, k, Canvas);
        Legs1(x, y, k, canvas);
        Hands1(x, y, k, canvas);
        inc(i);
      end;
    2: // Положение 2 при беге вправо
      begin
        Body1(x, y, k, canvas);
        Legs2(x, y, k, canvas);
        Hands2(x, y, k, canvas);
        inc(i);
      end;
    3: // Положение 3 при беге вправо
      begin
         Body1(x, y, k, canvas);
         Legs3(x, y, k, canvas);
         Hands3(x, y, k, canvas);
         i:=1;
      end;
    4:  // Положение 1 при прыжке перед кувырком
      begin
        Body1(x, y+10, k, canvas);
        Jump_Legs1(x, y+10, k, canvas);
        Jump_Hands1(x, y+10, k, canvas);
        inc(i)
      end;
    5:  // Положение 2 при прыжке перед кувырком
      begin
        Body1(x, y-10, k, canvas);
        Jump_Legs2(x, y-10, k, canvas);
        Jump_Hands2(x, y-10, k, canvas);
        inc(i);
      end;
    6:  // Положение 1 при кувырке
      begin
        x:=x+10;
        Rotate_Body1(x, y+30, k, canvas);
        Rotate_Legs1(x, y+30, k, canvas);
        Rotate_Hands1(x, y+30, k, canvas);
        inc(i);
      end;
    7:  // Положение 2 при кувырке
      begin
        x:=x+10;
        Rotate_Body2(x, y+50, k, canvas);
        Rotate_Legs2(x, y+50, k, canvas);
        Rotate_Hands2(x, y+50, k, canvas);
        inc(i);
      end;
    8:  // Положение 3 при кувырке
      begin
        x:=x+10;
        Rotate_Body3(x, y-50, k, canvas);
        Rotate_Legs3(x, y-50, k, canvas);
        Rotate_Hands3(x, y-50, k, canvas);
        inc(i);
      end;
    9:  // Положение 2 при кувырке
      begin
        x:=x+10;
        Rotate_Body2(x, y+50, k, canvas);
        Rotate_Legs2(x, y+50, k, canvas);
        Rotate_Hands2(x, y+50, k, canvas);
        inc(i);
      end;
    10: // Положение 4 при кувырке
      begin
        x:=x+10;
        Rotate_Body4(x, y-20, k, canvas);
        Rotate_Legs4(x, y-20, k, canvas);
        Rotate_Hands4(x, y-20, k, canvas);
        i:=4;
      end;
    11:  // Положение 1 при беге влево
      begin
        Body1(x, y, k, canvas);
        Back_Legs1(x, y, k, canvas);
        Back_Hands1(x, y, k, canvas);
        inc(i);
      end;
    12:  // Положение 2 при беге влево
      begin
        Body1(x, y, k, canvas);
        Back_Legs2(x, y, k, canvas);
        Back_Hands2(x, y, k, canvas);
        inc(i);
      end;
    13:  // Положение 3 при беге влево
      begin
        Body1(x, y, k, canvas);
        Back_Legs3(x, y, k, canvas);
        Back_Hands3(x, y, k, canvas);
        i:=11;
      end;
    14:  //  положение при прыжке через препятствие
      begin
        x:=x-2;
        Body1(x, y, k, canvas);
        Back_Hands1(x, y, k, canvas);
        LongJump_Legs1(x, y, k, canvas);
        if j<=3 then
          begin
            i:=14;
            inc(j);
          end
        else
          i:=11;
      end;
  end;
  if (x<460) and (y=100) then  // бег вправо
    begin
      x := x + 2;
      if (x=130) or (x=220) or (x=310) then  // кувырки
        i:=4;
      if (x=194) or (x=284) or (x=374) then  // опять бежим
        i:=1;
    end;
    if (x>=460) and (y<200) then  // поворот (бег вправо)
      begin
        k := k+0.0027;   // увеличиваем коэффициент масштабирования
        x:=x+2;
        y:=y+2;
      end;
    if (x<=560) and (y>=200) and (y<300) then   // поворот (бег влево)
      begin
        if y=200 then   // меняем направление бега
          i:=11;
        k:=k+0.0027;    // увеличиваем коэффициент масштабирования
        x:=x-2;
        y:=y+2;
      end;
    if (x<=460) and (y=300) then  // бег влево
      begin
        x:=x-2;
        if (x=400) or (x=250) or (x=100)then  // прыжок через препятствия
          begin
          i:=14;
          j:=0;
          end;
      end;
    if (x=50) and (y=300) then   // возвращаемся в начальное положение
    begin
      x:=50;
      y:=100;
      k:=1;
      i:=1;
      a:=50;
      b:=300;
      z:=1;
      q:=1;
      h:=1;
      koef1:=580;
      koef2:=170;
      koef3:=1.25;
    end;

    // зарядка
  case z of
    1:
      begin
        Man_body(a, b, 1, canvas);
        Ex_1_legs1(a, b, 1, canvas);
        Ex_1_arms1(a, b, k, canvas);
        inc(z);
      end;
    2, 8:
      begin
        Man_body(a, b, k, canvas);
        Ex_1_legs2(a, b, k, canvas);
        Ex_1_arms2(a, b, k, canvas);
        if z = 8 then
        begin
          z := 1;
          inc(q);
        end
        else
        begin
          inc(z);
        end;
      end;
    3, 7:
      begin
        Man_body(a, b, k, canvas);
        Ex_1_legs3(a, b, k, canvas);
        Ex_1_arms3(a, b, k, canvas);
        inc(z);
      end;
    4, 6:
      begin
        Man_body(a, b, k, canvas);
        Ex_1_legs4(a, b, k, canvas);
        Ex_1_arms4(a, b, k, canvas);
        inc(z);
      end;
    5:
      begin
        Man_body(a, b, k, canvas);
        Ex_1_legs5(a, b, k, canvas);
        Ex_1_arms5(a, b, k, canvas);
        inc(z);
      end;
    9:
      begin
        Man_body(a, b, 1, canvas);
        Ex_2_legs1(a, b, 1, canvas);
        Ex_2_arms1(a, b, 1, canvas);
        inc(z);
      end;
    10, 12:
      begin
        Man_body(a, b, 1, canvas);
        Ex_2_legs2(a, b, 1, canvas);
        Ex_2_arms2(a, b, 1, canvas);
        if z = 12 then
        begin
          z := 9;
          inc(q);
        end
        else
        begin
          inc(z);
        end;
      end;
    11:
      begin
        Man_body(a, b, 1, canvas);
        Ex_2_legs3(a, b, 1, canvas);
        Ex_2_arms3(a, b, 1, canvas);
        inc(z);
      end;
    13:
      begin
        Man_body(a, b, k, canvas);
        Ex_3_legs1(a, b, k, canvas);
        Ex_3_arms1(a, b, k, canvas);
        inc(z);
      end;
    14,16:
      begin
        Man_body(a, b, k, canvas);
        Ex_3_legs2(a, b, k, canvas);
        Ex_3_arms2(a, b, k, canvas);
        if z = 16 then
        begin
          z := 13;
          inc(q);
        end
        else
        begin
          inc(z);
        end;;
      end;
    15:
      begin
        man_body(a, b, k, canvas);
        Ex_3_legs3(a, b, k, canvas);
        Ex_3_arms3(a, b, k, canvas);
        inc(z);
      end;
  end;
  if (z = 1) then
  begin
    a := a + kf;
    b := b + kf;
  end;
  if (z = 2) or (z = 3) or (z = 4) or (z = 6) or (z = 7) or (z = 8) then
  begin
    a := 50;
    b := 300;
  end;
  if z = 5 then
  begin
    a := a - kf;
    b := b + kf;
  end;
  if q = 5 then
  begin
    a := 50;
    b := 300;
    z := 13;
    inc(q);
  end;
  if z=9 then
  begin
    a:=50+9*kf;
    b:=300;
  end;
  if (z = 10) then
  begin
    b := b + kf;
  end;
  if z = 11 then
  begin
    b := b + 25;
  end;
  if z = 12 then
  begin
    b := b - 25;
  end;
  if (z = 13) or (z = 14) or (z = 15) or (z=16) then
  begin
    a := a + kf;
  end;
  if q=8 then
  begin
    z:=9;
    inc(q);
  end;

  //танцор;
   case h of
    1:
      begin
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs1(koef1, koef2, koef3, canvas);
        dancer_arms1(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    2:
      begin
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs2(koef1, koef2, koef3, canvas);
        dancer_arms1(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    3:
      begin
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs2(koef1, koef2, koef3, canvas);
        dancer_arms2(koef1, koef2,koef3, canvas);
        inc(h);
      end;
    4:
      begin
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs3(koef1, koef2,koef3, canvas);
        dancer_arms3(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    5:
      begin
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs4(koef1, koef2, koef3, canvas);
        dancer_arms4(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    6:
      begin
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs1(koef1, koef2,koef3, canvas);
        dancer_arms_circule1(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    7:
      begin
        dancer_body(koef1, koef2,koef3, canvas);
        dancer_legs1_left(koef1, koef2, koef3, canvas);
        dancer_arms_circule1_left(koef1, koef2,koef3, canvas);
        inc(h);

      end;
    8:
      begin
        koef1 := koef1 - 100;
        koef2 := koef2 + 90;
        koef3 := koef3 + 0.06;
        dancer_body_circule4_left(koef1, koef2,  koef3, canvas);
        dancer_legs_circule4_left(koef1, koef2,  koef3, canvas);
        dancer_arms_circule4_left(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    9:
      begin
        koef1 := koef1 - 50;
        koef2 := koef2 + 10;
        koef3 := koef3 + 0.07;
        dancer_body_circule3_left(koef1, koef2, koef3, canvas);
        dancer_legs_circule3_left(koef1, koef2, koef3, canvas);
        dancer_arms_circule3_left(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    10:
      begin
        koef1 := koef1 - 30;
        koef3 := koef3 + 0.07;
        dancer_body_circule2_left(koef1, koef2, koef3, canvas);
        dancer_legs_circule2_left(koef1, koef2, koef3, canvas);
        dancer_arms_circule2_left(koef1, koef2,koef3, canvas);
        inc(h);
      end;
    11:
      begin
        koef1 := koef1 - 50;
        koef2 := koef2 - 80;
        koef3 := koef3 + 0.07;
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs1_left(koef1, koef2, koef3, canvas);
        dancer_arms_circule1_left(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    12:
      begin
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs1(koef1, koef2, koef3, canvas);
        dancer_arms_circule1(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    13:
      begin
        koef2 := koef2 + 60;
        koef1 := koef1 + 30;
        dancer_body_circule2(koef1, koef2, koef3, canvas);
        dancer_legs_circule2(koef1, koef2, koef3, canvas);
        dancer_arms_circule2(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    14:
      begin
        koef1 := koef1 + 40;
        koef2 := koef2 + 40;
        dancer_body_circule3(koef1, koef2, koef3, canvas);
        dancer_legs_circule3(koef1, koef2, koef3, canvas);
        dancer_arms_circule3(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    15:
      begin
        koef1 := koef1 + 40;
        koef2 := koef2 - 20;
        dancer_body_circule4(koef1, koef2, koef3, canvas);
        dancer_legs_circule4(koef1, koef2, koef3, canvas);
        dancer_arms_circule4(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    16:
      begin
        dancer_body(koef1 + 70, koef2 - 80, koef3, canvas);
        dancer_legs1(koef1 + 70, koef2 - 80, koef3, canvas);
        dancer_arms_circule1(koef1 + 70, koef2 - 80, koef3, canvas);
        inc(h);
      end;
    17:
      begin
        koef1 := koef1 + 70;
        koef2 := koef2 - 78;
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs1(koef1, koef2,koef3, canvas);
        dancer_arms1(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    18:
      begin
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs2(koef1, koef2,koef3, canvas);
        dancer_arms1(koef1, koef2,koef3, canvas);
        inc(h);
      end;
    19:
      begin
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs2(koef1, koef2, koef3, canvas);
        dancer_arms2(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    20:
      begin
        dancer_body(koef1, koef2, koef3, canvas);
        dancer_legs3(koef1, koef2, koef3, canvas);
        dancer_arms3(koef1, koef2, koef3, canvas);
        inc(h);
      end;
    21:
      begin
        dancer_body(koef1, koef2,koef3, canvas);
        dancer_legs4(koef1, koef2,koef3, canvas);
        dancer_arms4(koef1, koef2, koef3, canvas);
        h:=18;
      end;
  end;
end;
end.
