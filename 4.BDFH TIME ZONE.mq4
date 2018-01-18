
// +----------------------------------------------------------------------------------------+ //
// |    .-._______                           FAIQHILYA                        _______.-.    | //
// |---( )_)______)                 Knowledge of the ancients                (______(_( )---| //
// |  (    ()___)                              \¦/                             (___()    )  | //
// |       ()__)                              (o o)                             (__()       | //
// |--(___()_)__________________________oOOo___(_)___oOOo_________________________(_()___)--| //
// |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|____|_____| //
// |                                                                                   2017 | //
// |----------------------------------------------------------------------------------------| //
// |                 File:     BDFH TIME ZONE                                             | //
// | Programming language:     MQL4                                                         | //
// | Development platform:     MetaTrader 4                                                 | //
// |          End product:     TARGET 2019                                                  | //
// |              Product:     26 NOPEMBER 2017                                             | //
// |                                                               [BILLION DOLLAR PROJECT] | //
// +----------------------------------------------------------------------------------------+ //
#property copyright " ©2018 JANUARI"
#property link      "hilyaalzahmita@gmail.com"
/*--------------------------------------------------------------------------------------------
                                                                    Traderathome, 16-01-2018
---------------------------------------------------------------------------------------------*/
#property strict
/*---------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------
Suggested Settings:          White Chart              Black Chart

Panel Section-
Panel_Background_Color       C'238,238,242            C'025,025,025'
Symbol_And_TF_Color          Black                    C'208,208,208'
Spread_Color                 C'080,080,080'           C'120,120,120'
Swaps_Color                  C'080,080,080'           C'120,120,120'
Range_Color                  C'080,080,080'           C'120,120,120'
Candle_Time_Color            C'080,080,080'           C'120,120,120'
Bid_UP_Color                 C'026,132,039'           C'046,188,046'
Bid_DN_Color                 Crimson                  C'234,000,000'
Bid_Last_Digit_Normal        C'140,140,140'           C'100,100,100'
Bid_Last_Digit_Small         C'040,040,040'           C'160,160,160'
Logo                         C'046,055,169'           C'095,103,211'

Ask-Bid Line Section-
Ask_Ray_Color                DarkSlateGray            C'100,100,100'
Bid_Ray_Color                DarkSlateGray            C'100,100,100'
Bid_Dot_Up_Color             C'000,198,060'           Lime
Bid_Dot_Dn_Color             C'240,032,084'           Red
Bid_Dot_Mono_Color           Black                    White

Horizontal Line Labels Section-
Line_Labels_Color            MidnightBlue             DarkGray

Levels Section-
Whole_Number_Color           C'187,187,247'           C'028,051,089'
Half_Number_Color            C'152,220,164'           C'000,070,000'
Quarter_Number_Color         C'219,210,176'           C'064,049,028'

Fibos Section-
H_Fibo_Color                 C'078,091,186'           C'091,104,191'
M_Fibo_Color                 Black;                   C'113,111,125'
L_Fibo_Color                 C'200,079,079'           C'208,078,070'

Pivots Section-
DPV1_Back_Color              C'255,255,128'           CLR_NONE
DPV2_Top_Color               Black                    C'209,080,203'
R_Pivot_Color                C'064,064,255'           C'071,102,207'
S_Pivot_Color                C'255,053,017'           C'202,034,004'
MidPivot_Color               SaddleBrown              C'106,106,000'

Range Lines Section-
RDH_Color                    C'134,149,251'           C'107,107,220'
RDL_Color                    C'241,126,120'           C'214,072,065'
RWH_Color                    C'134,149,251'           C'091,091,217'
RWL_Color                    C'241,126,120'           C'208,060,055'

Separators Section-
Separators_Color             BlueViolet               C'085,085,085'

vLines Section-
vLines_Color                 Silver                   C'074,074,074'
vLabels_Color                MidnightBlue             Olive

Clock Section-
Clock_MktClosed              C'080,080,080'           C'120,120,120'
Location_MktClosed           C'080,080,080'           C'120,120,120'
Clock_MktOpen                C'133,084,035'           C'186,138,090'
Location_MktOpen             C'000,149,034'           C'046,186,046'
---------------------------------------------------------------------------------------------*/


//+-------------------------------------------------------------------------------------------+
//| Indicator Global Inputs                                                                   |
//+-------------------------------------------------------------------------------------------+
#property indicator_chart_window

#include <stdlib.mqh>
//See function documentation at http://msdn.microsoft.com/en-us/library/ms725473(VS.85).aspx
#import "kernel32.dll"
void GetLocalTime(int& LocalTimeArray[]);
void GetSystemTime(int& systemTimeArray[]);
int  GetTimeZoneInformation(int& LocalTZInfoArray[]);
bool SystemTimeToTzSpecificLocalTime(int& targetTZinfoArray[],
     int& systemTimeArray[], int& targetTimeArray[]);
#import

//Global External Inputs-----------------------------------------------------------------------
extern bool   Indicator_On                         = true;
extern string Preface____________                  = "Find & enter Clock Proxy Server Tz Location.";
extern bool   Clock_Normal_vs_Find_Server          = true;
extern string Clock_Proxy_Server_Tz_Location       = "Helsinki";
extern string Preface_____________                 = "Read User Notes.  Contact your broker to confirm.";
extern string _                                    = "";
extern string Part_1                               = "Indicator Master Controls:";
extern bool   Show_Access_Panel                    = true;
extern bool   __Show_Logo_in_Panel                 = true;
extern bool   __Show_Clock_in_Panel                = true;
extern bool   Ask_Line_On                          = true;
extern int    __Ask_Max_TF                         = 15;
extern bool   Bid_Line_On                          = true;
extern bool   Levels_On                            = false;
extern bool   __Show_Half_Levels                   = false;
extern bool   __Show_Quarter_Levels                = false;
extern int    __Levels_Whole_Max_TF                = 1440;
extern int    __Levels_Half_Max_TF                 = 1440;
extern int    __Levels_Quarter_Max_TF              = 30;
extern int    __Incr_Decr_Levels_Density           = 0;
extern bool   Natural_Fibos                        = false;
extern bool   __Use_Tz_Filter                      = false;
extern int    __Fibos_Max_TF                       = 60;
extern bool   Pivots_Day_vs_Fibonacci              = true;
extern bool   __Pivots_PVT_On                      = false;
extern bool   __Pivots_SR_On                       = false;
extern bool   ____Pivots_Mid_Included              = true;
extern int    __Show_Levels_Thru_2345              = 5;
extern int    __PVT_Max_TF                         = 60;
extern bool   __PivotsTz_On                        = true;
extern bool   ____Use_Preferred_Offset             = true;
extern int    ____Alternative_GMT_Offset           = 0;
extern bool   Range_Day_On                         = false;
extern int    __Day_Max_TF                         = 1440;
extern bool   Range_Week_On                        = false;
extern int    __Week_Max_TF                        = 10080;
extern bool   Separators_On                        = false;
extern int    __Prior_Days_To_Show                 = 5;
extern int    __Separators_Max_TF                  = 60;
extern bool   vLines_On                            = false;
extern int    __Current_Session_Max_TF             = 60;
extern int    __Prior_Sessions_Max_TF              = 60;
extern int    __Prior_Sessions_To_Show             = 0;
extern bool   __Prior_Ao_with_Current_Session_only = false;
extern bool   __Ao_in_All_Sessions                 = true;
extern bool   __Fo_in_All_Sessions                 = true;
extern string TF_Choices                           = "1-5-15-30-60-240-1440-10080-43200";

extern string __                                   = "";
extern string Part_2                               = "Panel Settings:";
extern bool   Show_Forex_Fractional_Pip            = true;
extern int    __Shift_Fractional_Pip               = 0;
extern int    Days_In_Range_Day_Avg                = 15;
extern int    Weeks_In_Week_ATR                    = 13;
extern color  Panel_Background_Color               = C'25,25,25';
extern color  Panel_Background_Color1              = C'5,5,5';
extern color  Symbol_And_TF_Color                  = C'255,255,255';
extern color  Spread_Color                         = Gold;
extern color  Range_Color                          = C'120,120,120';
extern color  Swaps_Color                          = C'120,120,120';
extern color  Candle_Time_Color                    = Silver;
extern color  Bid_UP_Color                         = C'046,188,046';
extern color  Bid_DN_Color                         = C'234,000,000';
extern color  Bid_Last_Digit_Normal                = C'100,100,100';
extern color  Bid_Last_Digit_Small                 = C'160,160,160';
extern color  Logo                                 = C'255,255,255';

extern string ___                                  = "";
extern string Part_3                               = "Ask-Bid Line Settings:";
extern color  Ask_Ray_Color                        = C'100,100,100';
extern int    Ask_Ray_LineStyle_01234              = 0;
extern int    Ask_Ray_Thickness                    = 1;
extern color  Bid_Ray_Color                        = C'100,100,100';
extern int    Bid_Ray_LineStyle_01234              = 0;
extern int    Bid_Ray_Thickness                    = 1;
extern bool   Subordinate_Ask_Bid_Lines            = true;
extern color  Ask_Dot_Color                        = Gainsboro;
extern int    Ask_Dot_Size                         = 6;
extern color  Ask_Dot_Cntr_Color                   = C'100,100,100';
extern int    Ask_Dot_Cntr_Size                    = 4;
extern color  Bid_Dot_Up_Color                     = Lime;
extern color  Bid_Dot_Dn_Color                     = Red;
extern color  Bid_Dot_Mono_Color                   = White;
extern bool   Use_Bid_Dot_Mono_Color               = false;
extern int    Bid_Dot_Size                         = 6;

extern string ____                                 = "";
extern string Part_4                               = "Horizontal Lines Position Settings:";
extern string note_4_0                             = "Choose line display number.";
extern string note_4_1                             = "1 = Fullscreen";
extern string note_4_2                             = "2 = Session";
extern int    Levels_Display_Number                = 1;
extern int    Pivots_Display_Number                = 2;
extern int    Ranges_Display_Number                = 2;
extern bool   Subordinate_Lines                    = true;

extern string _____                                = "";
extern string Part_5                               = "Horizontal Lines Labels Settings:";
extern bool   Pivot_PVT_Label_On                   = true;
extern bool   Pivot_SRM_Labels_On                  = true;
extern bool   Range_Labels_On                      = true;
extern color  Labels_Color                         = DarkGray;
extern bool   Subordinate_Labels                   = true;

extern string ______                               = "";
extern string Part_6                               = "Levels Settings:";
extern color  Level_Whole_Color                    = C'028,051,089';
extern int    Level_Whole_Style_01234              = 0;
extern int    Level_Whole_Width_12345              = 1;
extern color  Level_Half_Color                     = C'000,070,000';
extern int    Level_Half_Style_01234               = 0;
extern int    Level_Half_Width_12345               = 1;
extern color  Level_Quarter_Color                  = C'064,049,028';
extern int    Level_Quarter_Style_01234            = 0;
extern int    Level_Quarter_Width_12345            = 1;

extern string _______                              = "";
extern string Part_7                               = "Fibos Settings:";
extern color  H_Fibo_Color                         = C'091,104,191';
extern color  M_Fibo_Color                         = C'113,111,125';
extern color  L_Fibo_Color                         = C'208,078,070';
extern int    F_Style_01234                        = 0;
extern int    F_Width_12345                        = 1;
extern bool   Subordinate_Fibos                    = false;

extern string ________                             = "";
extern string Part_8                               = "Pivots Settings:";
extern color  PVT1_Back_Color                      = CLR_NONE;
extern int    PVT1_Style_01234                     = 0;
extern int    PVT1_Width_12345                     = 1;
extern color  PVT2_Top_Color                       = C'209,080,203';
extern int    PVT2_Style_01234                     = 2;
extern int    PVT2_Width_12345                     = 1;
extern color  R_Pivot_Color                        = C'071,102,207';
extern int    R_Style_01234                        = 2;
extern int    R_Width_12345                        = 1;
extern color  S_Pivot_Color                        = C'202,034,004';
extern int    S_Style_01234                        = 2;
extern int    S_Width_12345                        = 1;
extern color  MidPivots_Color                      = C'106,106,000';
extern int    mP_Style_01234                       = 2;
extern int    mP_Width_12345                       = 1;

extern string _________                            = "";
extern string Part_9                               = "Range Day Settings:";
extern color  RDH_Color                            = C'107,107,220';
extern color  RDL_Color                            = C'214,072,065';
extern int    RD_Style_01234                       = 0;
extern int    RD_Width_12345                       = 2;

extern string __________                           = "";
extern string Part_10                              = "Range Week Settings:";
extern color  RWH_Color                            = C'091,091,217';
extern color  RWL_Color                            = C'208,060,055';
extern int    RW_Style_01234                       = 0;
extern int    RW_Width_12345                       = 3;

extern string ___________                          = "";
extern string Part_11                              = "Separators Settings:";
extern color  Separators_Color                     = C'085,085,085';
extern int    Separators_Style_01234               = 2;
extern int    Separators_Width_12345               = 1;
extern bool   Separators_Thru_SubWindows           = true;

extern string ____________                         = "";
extern string Part_12                              = "vLines & Labels Settings:";
extern color  vLines_Color                         = C'074,074,074';
extern int    vLines_Style_01234                   = 2;
extern int    vLines_Width_12345                   = 1;
extern bool   vLines_Thru_SubWindows               = false;
extern bool   Sbow_vLabels                         = true;
extern color  vLabels_Color                        = Olive;

extern string _____________                        = "";
extern string Part_13                              = "Clock Settings:";
extern color  Clock_MktClosed                      = C'120,120,120';
extern color  Location_MktClosed                   = C'120,120,120';
extern color  Clock_MktOpen                        = C'186,138,090';
extern color  Location_MktOpen                     = C'046,186,046';
extern bool   Show_AMPM_Time                       = false;
extern string Note_12_1                            = "Choosing Locations to Display:";
extern string Note_12_2                            = "Select 7 maximum from list,";
extern string Note_12_3                            = "0 = display off.";
extern string Note_12_4                            = "1 = Display on.";
extern int    Broker                               = 0;
extern int    Local                                = 0; 
extern int    Auckland                             = 0;
extern int    Sydney                               = 1;
extern int    Tokyo                                = 1;
extern int    HongKong                             = 1;
extern int    Jakarta                              = 0;
extern int    India                                = 0;
extern int    Dubai                                = 0;
extern int    Moscow                               = 0;
extern int    Israel                               = 0;
extern int    Helsinki                             = 1;
extern int    Frankfurt                            = 1;
extern int 	  London                               = 1;
extern int    GMT                                  = 0;
extern int    Brazil                               = 0;
extern int    NewYork                              = 1;
extern int    Central                              = 0;
extern int    Mexico                               = 0;
extern int    Mountain                             = 0;
extern int    Pacific                              = 0;

//Buffers, Constants and Variables-------------------------------------------------------------
bool          Deinitialized;

//Deinit
int           obj_total,k;
string        name;

//Panel & Bid Line
color         Static_Price_Color, Static_Bid_Color, Bid_Dot_Color, Static_Bid_Dot_Color,
              Dot_Up_Color, Dot_Dn_Color;
double        Poin, Poin2,New_Price,Old_Price,level,Spread,ARg,RangeAchieved,
              dRange,wRange,dRG,wRG,pipValue,tic,size;
datetime      T1,T2;
int           Chart_Scale,modifier,Color,Factor,G1,G2,h,i,l,m,s,t,LP,LS;
string        item01 = "z[CP Panel] Box 1";
string        item02 = "y[CP Panel] Box 2";
string        item03 = "z[CP Text] ID&TF";
string        item04 = "z[CP Text] Spread";
string        item05 = "z[CP Text] Spread2";
string        item06 = "z[CP Text] Pip";
string        item07 = "z[CP Text] Pip2";
string        item08 = "z[CP Text] Range";
string        item09 = "z[CP Text] Range2";
string        item10 = "z[CP Text] Swap";
string        item11 = "z[CP Text] Swap2";
string        item12 = "z[CP Text] Price1";
string        item13 = "z[CP Text] Price2";
string        item14 = "z[CP Text] Logo1 S";
string        item15 = "z[CP Text] Logo1 o";
string        item16 = "z[CP Text] Logo1 n";
string        item17 = "z[CP Text] Logo1 i";
string        item18 = "z[CP Text] Logo1 c";
string        item19 = "z[CP Text] Logo1 R";
string        item20 = "d[CP Bid] Bid Line";
string        item21 = "e[CP Bid] Bid Dot";
string        item22 = "d[CP Ask] Ask Line";
string        item23 = "d[CP Ask] Ask Dot";
string        item24 = "e[CP Ask] Ask Dot Cntr";
string        ID,Price,C,tab,tab1,timeleft,Tic;

//Levels
color         linecolor;
double        linelevel, linestyle, linewidth, BL;
int           j,Line1_Color, Line2_Color, Line3_Color;
int           u1=00, u2=50, u3=25, u4=75;
int           v1, ssp, ssp1, NumberOfRanges;
string        linename;

//Fibos
bool          fib;
double        H10,H9,H8,H7,H6,H5,H4,H3,H2,H1,M1,M2,M3,M4,M5,FH,FL,FD,
              L1,L2,L3,L4,L5,L6,L7,L8,L9,L10;

//Pivots
datetime      pvtDT;
double        p,q,r1,r2,r3,r4,r5,s1,s2,s3,s4,s5;
double        today_high,today_low,today_open,today_close;
double        yesterday_high, yesterday_low, yesterday_open, yesterday_close;
int           Pdisplay,idxfirstbaryesterday,idxlastbaryesterday,idxfirstbartoday,idxbar,
              tzdiff,tzdiffsec,barsperday,dayofweektoday,dayofweektofind,Pivots_GMT_Offset;
//int            dtf1,dtf2,Hbarshift,Lbarshift;              
string        prefix;

//Range Day
datetime      d1,d2;
double        low,high,dRangeHigh,dRangeLow,HiToday,LoToday;
int           ii,iii,x,xx,r,dtf,Hbarshift,Lbarshift,rdc,rwc,Rdisplay,RDshift,idxbar2;

//Range Week
datetime      w1,w2;
double        week_open, HiWeek, LoWeek;
double        wRangeAvg, wRangeHigh, wRangeLow;
int           wtf, wHbarshift, wLbarshift, RWdisplay, RWshift;

//Horizontal Lines Placement
datetime      startline, stopline,T,T4;
int           a,b,c,R2;
string        line;

//Horizontal Labels Placement
datetime      startlabel;
string        label, spc;
string        FontStyle = "Verdana";
int           FontSize  = 7;

//vLines & Labels
datetime      T3, tme2, time4;
int           bps, MF, shift;
string        vLabels_Asian_Open       = "      Ao ";
string        vLabels_Berlin_Open      = "     F  ";
string        vLabels_London_Open      = "      Lo";
string        vLabels_NewYork_Open     = "     Ny";
string        vLabels_London_Close     = "      Lc ";
string        Label_Day_Separator      = "day";
string        vFontStyle               = "Verdana";
int           vFontSize                = 7;

//Get GMT Offsets in Support of PivotsTz and Market vLines
int           GMT_Ref_Time, Sydney_GMT_Offset, Berlin_GMT_Offset, London_GMT_Offset,
              NYC_GMT_Offset, GMT_At_Lo, GMT_At_NYo, GMT_At_Lc, GMT_At_Ao, GMT_At_Fo,
              Broker_GMT_Offset;

//Import Time Zone Data in Support of Clock, PivotsTz and Market vLines
bool          BKR_UTC_Match, FLAG_static_broker, Displaying_Pivots;
datetime      Local_Time,BrokerDT,AucklandDT,SydneyDT,TokyoDT,ChinaDT,JakartaDT,IndiaDT,
              DubaiDT,MoscowDT,IsraelDT,HelsinkiDT,BerlinDT,LondonDT,UTC,BrazilDT,NewYorkDT,
              CentralDT,MexicoDT,MountainDT,PacificDT,StaticBrokerDT;
int           ClockFontSize, TimezoneFontSize, LineSpacing, z, time, place, offset,top;
int           AucklandTZInfoArray[43],SydneyTZInfoArray[43],TokyoTZInfoArray[43],
              ChinaTZInfoArray[43],JakartaTZInfoArray[43],IndiaTZInfoArray[43],
              DubaiTZInfoArray[43],MoscowTZInfoArray[43],IsraelTZInfoArray[43],
              HelsinkiTZInfoArray[43],BerlinTZInfoArray[43],LondonTZInfoArray[43],
              BrazilTZInfoArray[43],NewYorkTZInfoArray[43],CentralTZInfoArray[43],
              MexicoTZInfoArray[43],MountainTZInfoArray[43],PacificTZInfoArray[43],
              LocalTZInfoArray[43];
int           LocalTimeArray[4],systemTimeArray[4],AucklandTimeArray[4],SydneyTimeArray[4],
              TokyoTimeArray[4],ChinaTimeArray[4],JakartaTimeArray[4],IndiaTimeArray[4],
              DubaiTimeArray[4],MoscowTimeArray[4],IsraelTimeArray[4],HelsinkiTimeArray[4],
              BerlinTimeArray[4],LondonTimeArray[4],BrazilTimeArray[4],NewYorkTimeArray[4],
              CentralTimeArray[4],MexicoTimeArray[4],MountainTimeArray[4],PacificTimeArray[4];
string        Locals,Brokers,Aucklands,Sydneys,Tokyos,Chinas,Jakartas,Indias,Dubais,
              Moscows,Israels,Helsinkis,Berlins,Londons,UTCs,Brazils,NewYorks,Centrals,
              Mexicos,Mountains,Pacifics;
string        Brokerp, Localp, Aucklandp, Sydneyp, Tokyop, Chinap, Jakartap,
              Indiap, Dubaip, Moscowp, Israelp, Helsinkip, Berlinp, Londonp, UTCp,
              Brazilp, NYp, Centralp, Mexicop, Mountainp, Pacificp, FontName;
string        timeStr,LocalTimeS,sMonth,sDay,sHour,sMin,sSec;
int           hour,nYear,nMonth,nDay,nHour,nMin,nSec,nMilliSec;

//Clock - Normal hrs 8-17 (9 hrs), Sydney 8-17 (9 hrs) and Tokyo 9-18 (9 hrs)
int           SydneyLocalOpenHour,SydneyLocalCloseHour;
int           LocalOpenHour        =  8;
int           LocalCloseHour       = 17;
int           TokyoLocalOpenHour   =  9;
int           TokyoLocalCloseHour  = 18;

//+-------------------------------------------------------------------------------------------+
//| Indicator De-initialization                                                               |
//+-------------------------------------------------------------------------------------------+
int deinit()
  {
  obj_total= ObjectsTotal();
  for(k= obj_total; k>=0; k--)
    {
    name= ObjectName(k);
    if(StringSubstr(name,0,3)=="[CP" || StringSubstr(name,1,3)=="[CP") {ObjectDelete(name);}
    }
  //Comment("");
  return(0);
  }

//+-------------------------------------------------------------------------------------------+
//| Indicator Initialization                                                                  |
//+-------------------------------------------------------------------------------------------+
int init()
  {
  //With the first DLL call below, the program will exit (and stop) automatically after one alert.
  if(!IsDllsAllowed() )
    {
    Alert(Symbol()," ",Period(),", Access Panel: Allow DLL Imports"); return(false);
    }

  //Be sure broker server equivalent time is properly input
  if((Clock_Proxy_Server_Tz_Location!="Auckland") && (Clock_Proxy_Server_Tz_Location!="Sydney") &&
     (Clock_Proxy_Server_Tz_Location!="Tokyo") && (Clock_Proxy_Server_Tz_Location!="HongKong") &&
     (Clock_Proxy_Server_Tz_Location!="Jakarta") && (Clock_Proxy_Server_Tz_Location!="India") &&
     (Clock_Proxy_Server_Tz_Location!="Dubai") && (Clock_Proxy_Server_Tz_Location!="Moscow") &&
     (Clock_Proxy_Server_Tz_Location!="Israel") && (Clock_Proxy_Server_Tz_Location!="Helsinki") &&
     (Clock_Proxy_Server_Tz_Location!="Frankfurt") && (Clock_Proxy_Server_Tz_Location!="London") &&
     (Clock_Proxy_Server_Tz_Location!="GMT") && (Clock_Proxy_Server_Tz_Location!="Brazil") &&
     (Clock_Proxy_Server_Tz_Location!="NewYork") && (Clock_Proxy_Server_Tz_Location!="Central") &&
     (Clock_Proxy_Server_Tz_Location!="Mexico") && (Clock_Proxy_Server_Tz_Location!="Mountain") &&
     (Clock_Proxy_Server_Tz_Location!="Pacific"))
    {
    Alert(Symbol()," ",Period(),", Access: Preface valid input req'd"); return(false);
    } 

  //Determine the current chart scale (chart scale number should be 0-5)
  Chart_Scale = ChartScaleGet();
 
  //Reset to Signal State of Non-deinitialization
  Deinitialized = false;

  //Panel - determine display of Market Price
  if(Digits == 5 || Digits == 3) {Factor = 10;}
  else {Factor = 1;} //cater for 5 digits

  //Panel, Bid/Ask Lines, Levels and Ranges - Set Poin values
  Poin2 = Point;
  Poin = Point*10;
  if(__Incr_Decr_Levels_Density>0) {Poin=Poin*(1+__Incr_Decr_Levels_Density);}
  if(__Incr_Decr_Levels_Density<0) {Poin=Poin/MathPow(2,MathAbs(__Incr_Decr_Levels_Density));}

  //Levels - set ranges for chart TFs
        if(Period() == 1) {NumberOfRanges = 4;}
  else {if(Period() == 5) {NumberOfRanges = 7;}
  else {if(Period() == 15) {NumberOfRanges = 15;}
  else {if(Period() == 30) {NumberOfRanges = 15;}
  else {if(Period() == 60) {NumberOfRanges = 20;}
  else {if(Period() == 240) {NumberOfRanges = 30;}
  else {if(Period() == 1440) {NumberOfRanges = 60;}
  else {if(Period() == 10080) {NumberOfRanges = 70;}
  else {if(Period() == 43200) {NumberOfRanges = 60;} }}}}}}}}

  //Import Time Zone Data  required for Clock, PivotsTZ and vLines
  GetTimeZoneInfo(AucklandTZInfoArray, SydneyTZInfoArray, TokyoTZInfoArray,
    ChinaTZInfoArray, JakartaTZInfoArray, IndiaTZInfoArray, DubaiTZInfoArray,
    MoscowTZInfoArray, IsraelTZInfoArray, HelsinkiTZInfoArray, BerlinTZInfoArray,
    LondonTZInfoArray, BrazilTZInfoArray, NewYorkTZInfoArray, CentralTZInfoArray,
    MexicoTZInfoArray, MountainTZInfoArray, PacificTZInfoArray);

  return(0);
  }

//+-------------------------------------------------------------------------------------------+
//| Indicator Start                                                                           |
//+-------------------------------------------------------------------------------------------+
int start()
  {
  //If Indicator is "Off" deinitialize only once, not every tick-------------------------------
  if(!Indicator_On)
    {
    if (!Deinitialized) {deinit(); Deinitialized = true;}
    return(0);
    }
  else {deinit();}

  //Chart Scale Settings-----------------------------------------------------------------------
  //Set datetimes based on chart scale (for Ask/Bid lines, Pivots & Ranges
            if(Chart_Scale == 0) {T1=Time[0]+(Period()*60*8); T4=Period()*60*100;}
    else {if(Chart_Scale == 1) {T1=Time[0]+(Period()*60*4); T4=Period()*60*50;}
    else {if(Chart_Scale == 2) {T1=Time[0]+(Period()*60*3); T4=Period()*60*25;}
    else {if(Chart_Scale == 3) {T1=Time[0]+(Period()*60*2); T4=Period()*60*13;}
    else {if(Chart_Scale == 4) {T1=Time[0]+(Period()*60*1); T4=Period()*60*8;}
    else {if(Chart_Scale == 5) {T1=Time[0]+(Period()*60*1); T4=Period()*60*5;}  }}}}}

  //Clock, PivotsTZ and vLines-----------------------------------------------------------------
  //Go to subroutine to get TZ info needed for Clock, PivotsTZ and vLines
  if(__Show_Clock_in_Panel || __PivotsTz_On || vLines_On)
    {
    GetSystemTime(systemTimeArray);
    UTC = TimeArrayToTime(systemTimeArray);
    BrokerDT = TimeCurrent();
    SystemTimeToTzSpecificLocalTime(AucklandTZInfoArray, systemTimeArray, AucklandTimeArray);
    AucklandDT = TimeArrayToTime(AucklandTimeArray);
    SystemTimeToTzSpecificLocalTime(SydneyTZInfoArray, systemTimeArray, SydneyTimeArray);
    SydneyDT   = TimeArrayToTime(SydneyTimeArray);
    SystemTimeToTzSpecificLocalTime(TokyoTZInfoArray, systemTimeArray, TokyoTimeArray);
    TokyoDT    = TimeArrayToTime(TokyoTimeArray);
    SystemTimeToTzSpecificLocalTime(ChinaTZInfoArray, systemTimeArray, ChinaTimeArray);
    ChinaDT    = TimeArrayToTime(ChinaTimeArray);
    SystemTimeToTzSpecificLocalTime(JakartaTZInfoArray, systemTimeArray, JakartaTimeArray);
    JakartaDT  = TimeArrayToTime(JakartaTimeArray);
    SystemTimeToTzSpecificLocalTime(IndiaTZInfoArray, systemTimeArray, IndiaTimeArray);
    IndiaDT    = TimeArrayToTime(IndiaTimeArray);
    SystemTimeToTzSpecificLocalTime(DubaiTZInfoArray, systemTimeArray, DubaiTimeArray);
    DubaiDT    = TimeArrayToTime(DubaiTimeArray);
    SystemTimeToTzSpecificLocalTime(MoscowTZInfoArray, systemTimeArray, MoscowTimeArray);
    MoscowDT   = TimeArrayToTime(MoscowTimeArray);
    SystemTimeToTzSpecificLocalTime(IsraelTZInfoArray, systemTimeArray, IsraelTimeArray);
    IsraelDT   = TimeArrayToTime(IsraelTimeArray);
    SystemTimeToTzSpecificLocalTime(HelsinkiTZInfoArray, systemTimeArray, HelsinkiTimeArray);
    HelsinkiDT = TimeArrayToTime(HelsinkiTimeArray);
    SystemTimeToTzSpecificLocalTime(BerlinTZInfoArray, systemTimeArray, BerlinTimeArray);
    BerlinDT   = TimeArrayToTime(BerlinTimeArray);
    SystemTimeToTzSpecificLocalTime(LondonTZInfoArray, systemTimeArray, LondonTimeArray);
    LondonDT   = TimeArrayToTime(LondonTimeArray);
    SystemTimeToTzSpecificLocalTime(BrazilTZInfoArray, systemTimeArray, BrazilTimeArray);
    BrazilDT   = TimeArrayToTime(BrazilTimeArray);
    SystemTimeToTzSpecificLocalTime(NewYorkTZInfoArray, systemTimeArray, NewYorkTimeArray);
    NewYorkDT  = TimeArrayToTime(NewYorkTimeArray);
    SystemTimeToTzSpecificLocalTime(CentralTZInfoArray, systemTimeArray, CentralTimeArray);
    CentralDT  = TimeArrayToTime(CentralTimeArray);
    SystemTimeToTzSpecificLocalTime(MexicoTZInfoArray, systemTimeArray, MexicoTimeArray);
    MexicoDT   = TimeArrayToTime(MexicoTimeArray);
    SystemTimeToTzSpecificLocalTime(MountainTZInfoArray, systemTimeArray, MountainTimeArray);
    MountainDT = TimeArrayToTime(MountainTimeArray);
    SystemTimeToTzSpecificLocalTime(PacificTZInfoArray, systemTimeArray, PacificTimeArray);
    PacificDT  = TimeArrayToTime(PacificTimeArray);
    GetLocalTime(LocalTimeArray);
    Local_Time = TimeArrayToTime(LocalTimeArray);

    //Sydney market local time open changes from 7am to 8am to 9am (NYC making winter DST 
    //change, later followed by Sydney making DST change) and from 9am to 8am to 7am
    //(NYC making summer DST change, later followed by Sydney making DST change.  When both
    //locations have made their DST change the time difference is 14 hours.
    if(int((UTC-NewYorkDT)/3600)==4)
      {
      if(int(SydneyDT/3600 - NewYorkDT/3600) == 14) 
        {
        SydneyLocalOpenHour  =  7;
        SydneyLocalCloseHour = 16;
        }
      else
        {
        SydneyLocalOpenHour  =  8;
        SydneyLocalCloseHour = 17;
        }
      }
     else if(int((UTC-NewYorkDT)/3600)==5)
      {
      if( int(SydneyDT/3600 - NewYorkDT/3600) == 14) 
        {
        SydneyLocalOpenHour  =  9;
        SydneyLocalCloseHour = 18;
        }
      else
        {   
        SydneyLocalOpenHour  =  8;
        SydneyLocalCloseHour = 17;
        }
      } 

    //Assign "Broker_GMT_Offset" if PivotsTz or vLines are "on".
    if((vLines_On && Period()<= __Current_Session_Max_TF) ||
      (__PivotsTz_On && Period()<= __PVT_Max_TF ))
      {
           if(Clock_Proxy_Server_Tz_Location=="Auckland") {BrokerDT= AucklandDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Sydney")   {BrokerDT= SydneyDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Tokyo")    {BrokerDT= TokyoDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="China")    {BrokerDT= ChinaDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Jakarta")  {BrokerDT= JakartaDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="India")    {BrokerDT= IndiaDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Dubai")    {BrokerDT= DubaiDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Moscow")   {BrokerDT= MoscowDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Israel")   {BrokerDT= IsraelDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Helsinki") {BrokerDT= HelsinkiDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Frankfurt"){BrokerDT= BerlinDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="London")   {BrokerDT= LondonDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="GMT")      {BrokerDT= UTC;}
      else{if(Clock_Proxy_Server_Tz_Location=="Brazil")   {BrokerDT= BrazilDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="NewYork")  {BrokerDT= NewYorkDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Central")  {BrokerDT= CentralDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Mexico")   {BrokerDT= MexicoDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Mountain") {BrokerDT= MountainDT;}
      else{if(Clock_Proxy_Server_Tz_Location=="Pacific")  {BrokerDT= PacificDT;}                                                            
        }}}}}}}}}}}}}}}}}}
      Broker_GMT_Offset = int(BrokerDT-UTC)/3600;
      }                             
    } 

  //-------------------------------------------------------------------------------------------   
  //PivotsTZ, Day RangeTZ and vLines:
  //With required time zone data imported, define parameters for PivotsTZ and vLines.
  //Calculate the GMT offsets at Ao, Fo, Lo, Ny and Lc used by vLines.  Calculate the pvtDT
  //used in the Clock when PivotsTZ is on.  Calculate Pivots_GMT_Offset used by PivotsTZ
  //and Day RangeTZ, and which might depend on one of the GMT offsets used by vLines or on
  //the alternate External Input for PivotTZ.
  if(vLines_On  || __PivotsTz_On)
    {
    //Make 8am the "reference time" at GMT for London Open
    GMT_Ref_Time = 8;

    //Find GMT At Ao (Sydney offset from GMT is not constant):
    //Sydney market local time open changes from 7am to 8am to 9am (NYC making winter DST 
    //change to GMT offset of 5 hours, later followed by Sydney making DST change) and 
    //from 9am to 8am to 7am (NYC making summer DST change to GMT offset of 4 hours, later 
    //followed by Sydney making DST change.  When both locations have made their DST change 
    //the time difference is 14 hours.
    Sydney_GMT_Offset = int (SydneyDT/3600 - UTC/3600);
    if(int((UTC-NewYorkDT)/3600)==4)
      {
      if(int(SydneyDT/3600 - NewYorkDT/3600) == 14)
        {
        //Syndey opens 7am local
        GMT_At_Ao = GMT_Ref_Time-Sydney_GMT_Offset-1;
        }
      else
        {
        //Syndey opens 8am local
        GMT_At_Ao = GMT_Ref_Time-Sydney_GMT_Offset;             
        }
      }
    else if(int((UTC-NewYorkDT)/3600)==5)
      {
      if( int(SydneyDT/3600 - NewYorkDT/3600) == 14)
        {
        //Syndey opens 9am local
        GMT_At_Ao = GMT_Ref_Time-Sydney_GMT_Offset+1;
        }
      else
        {
        //Syndey opens 8am local
        GMT_At_Ao = GMT_Ref_Time-Sydney_GMT_Offset;
        }
      }            
    if(GMT_At_Ao+Broker_GMT_Offset<0) {GMT_At_Ao=GMT_At_Ao+24;}

    //Find GMT At Fo (when Berlin is at 8am local)
    Berlin_GMT_Offset = int (BerlinDT/3600 - UTC/3600);
    GMT_At_Fo = GMT_Ref_Time-Berlin_GMT_Offset;
    if(GMT_At_Fo+Broker_GMT_Offset<0) {GMT_At_Fo=GMT_At_Fo+24;}

    //Find GMT At Lo (when London is at 8am local)
    London_GMT_Offset = int (LondonDT/3600 - UTC/3600);
    GMT_At_Lo = GMT_Ref_Time-London_GMT_Offset;
    if(GMT_At_Lo+Broker_GMT_Offset<0) {GMT_At_Lo=GMT_At_Lo+24;}

    //Find GMT At Ny (when New York is at 8am local)
    NYC_GMT_Offset = int(NewYorkDT/3600 - UTC/3600);
    GMT_At_NYo = GMT_Ref_Time-NYC_GMT_Offset;
    if(GMT_At_NYo+Broker_GMT_Offset<0) {GMT_At_NYo=GMT_At_NYo+24;}

    //Find GMT At Lc (nine hours after London Open)
    GMT_At_Lc = GMT_At_Lo + 9;
    if(GMT_At_Lc+Broker_GMT_Offset<0) {GMT_At_Lc=GMT_At_Lc+24;}

    //Only do this part if PivotsTZ or day RangeTZ is on
    if(__PivotsTz_On)
      {
      //For selected pivotTZ time zone, recalculate pvtDT (datetime) for Clock label and
      //the new Pivots_GMT_Offset for use in the PivotsTZ and day RangeTZ coding
      if(____Use_Preferred_Offset)
        {
        pvtDT = UTC + Berlin_GMT_Offset*3600;
        Pivots_GMT_Offset = Berlin_GMT_Offset;
        }
      else
        {
        pvtDT = UTC + ____Alternative_GMT_Offset*3600;
        Pivots_GMT_Offset = ____Alternative_GMT_Offset;
        }
      }
    }
    //Levels-------------------------------------------------------------------------------------
  if(Levels_On && Period()<= __Levels_Whole_Max_TF)
    {
    if(Period()>240 && Levels_Display_Number== 2) {Levels_Display_Number= 3;}
    //define needed variables
    ssp1= int (Bid/Poin);  //bid w/o the decimal
    v1=ssp1%100; //last two significant digits
    BL=v1; //last two significant digits of starting/reference bid line

    //calculate line levels bottom to top
    for(j= int (-100-(100-BL)-(100*NumberOfRanges)); j<= (100-BL)+(100*NumberOfRanges); j++)
      {
      ssp=ssp1+j;
      v1=ssp%100;
      if(v1==u1)
        {
        linelevel = ssp*Poin;
        DrawLines("LVL", Levels_Display_Number, linelevel, Level_Whole_Color,
        Level_Whole_Style_01234, Level_Whole_Width_12345);
        }
      else {if((__Show_Half_Levels && Period()<= __Levels_Half_Max_TF) && (v1==u2))
        {
        linelevel = ssp*Poin;
        DrawLines("LVL", Levels_Display_Number, linelevel, Level_Half_Color,
        Level_Half_Style_01234, Level_Half_Width_12345);
        }
      else {if((__Show_Quarter_Levels && Period()<= __Levels_Quarter_Max_TF) && ((v1==u3) || (v1==u4)))
        {
        linelevel = ssp*Poin;
        DrawLines("LVL", Levels_Display_Number, linelevel, Level_Quarter_Color,
        Level_Quarter_Style_01234, Level_Quarter_Width_12345);
        } }}
      }
    }//End Levels
    
  //Separators---------------------------------------------------------------------------------
  if(Separators_On && Period() <= __Separators_Max_TF)
    {
    //Separators for Today and Tomorrow
    CurrentSeparators("Today", Separators_Color, Separators_Style_01234,
    Separators_Width_12345);

    CurrentSeparators("Tomorrow", Separators_Color, Separators_Style_01234,
    Separators_Width_12345);

    //Separators for prior sessions
    if(__Prior_Days_To_Show > 0)
      {
      //Calculate bars per session
           if (Period()==1) {bps = 1440;}
      else {if (Period()==5) {bps = 288;}
      else {if (Period()==15){bps = 96;}
      else {if (Period()==30){bps = 48;}
      else {if (Period()==60){bps = 24;}
      else {if (Period()==240){bps = 6;} }}}}}
      //Define bar starting prior sessions display
      shift = iBarShift(NULL,NULL,iTime(NULL,PERIOD_D1,0));
      //Execute loop for bars per session X number of prior sessions to show
      for(i= int (shift); i<=(shift+(bps*(__Prior_Days_To_Show))); i++)
        {
        if(TimeHour(Time[i]) == 0 && TimeMinute(Time[i]) == 0)
          {
          PriorSeparators(i, Separators_Color,
          Separators_Style_01234, Separators_Width_12345);
          }
        }
      }
    }//End Separators

  //vLines-------------------------------------------------------------------------------------
  if(vLines_On && Period()<= __Current_Session_Max_TF)
    {
    //Calculate position for vline labels
    level = WindowPriceMax();
    //Calculate bars per session
          if (Period()==1) {bps = 1439;}
    else {if (Period()==5) {bps = 287;}
    else {if (Period()==15){bps = 95;}
    else {if (Period()==30){bps = 47;}
    else {if (Period()==60){bps = 23;} }}}}
    //Define bar starting prior sessions display
    shift = iBarShift(NULL,NULL,iTime(NULL,PERIOD_D1,0));

    //Do vlines for current session------------------------------------------------------------
    if(DayOfWeek()==0)
      {
      //Code for any broker on Sunday is same type code used for prior sessions because we
      //have to recreate previous Friday session vLines since Sunday is just a short session
      //that is a continuation of Friday.  This applies to all vLines except "Ao".
      //Execute loop for bars per session
      for(i= int (shift); i<=(shift+bps); i++)
        {
        h=TimeHour(Time[i]);
        m=TimeMinute(Time[i]);

        //Asian Open vLine (prior session)
        if( __Prior_Ao_with_Current_Session_only) {
        MF = int (MathFloor(GMT_At_Ao));
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Ao != MF) && (h == MF + Broker_GMT_Offset) && (m == 30))
          {
          OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Ao == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          } }}}

        //Berlin Open vLine (current session)
        if(__Fo_in_All_Sessions) {
        MF = int (MathFloor(GMT_At_Fo));
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Fo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30))
          {
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Fo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          } }}}

        //London Open vLine (current session)
        MF = int (MathFloor(GMT_At_Lo));
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Lo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30))
          {
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Lo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          } }}

        //NewYork Open vLine (current session)
        MF = int (MathFloor(GMT_At_NYo));
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_NYo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30))
          {
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_NYo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          } }}

        //London Close vLine (current session)
        MF = int (MathFloor(GMT_At_Lc));
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Lc != MF) && (h == MF + Broker_GMT_Offset) && (m == 30))
          {
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Lc == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          } }}
        }//End prior sessions shift loop

        //Asian Open vLine (current session)
        if(__Ao_in_All_Sessions)
          {
          OpenToday(vLabels_Asian_Open, GMT_At_Ao + Broker_GMT_Offset,
          vLines_Color, vLines_Style_01234, vLines_Width_12345, level);
          }
      }//End Short Sunday loop for broker at GMT

    else //for all brokers Monday thru Friday      
      {
      //Do Ao vline for prior session
      if(__Prior_Ao_with_Current_Session_only &&  __Prior_Sessions_To_Show==0)
        {
        for(i= int (shift+1); i<=(shift+bps+1); i++)
          {
          h=TimeHour(Time[i]);
          m=TimeMinute(Time[i]);

          //Asian Open vLine
          MF = int (MathFloor(GMT_At_Ao));
          if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))
            {
            OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234,
            vLines_Width_12345, level);
            }
          else {if((GMT_At_Ao != MF) && (h == MF + Broker_GMT_Offset) && (m == 30))
            {
            OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234,
            vLines_Width_12345, level);
            }
          else {if((GMT_At_Ao == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
            {
            OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234,
            vLines_Width_12345, level);
            } }}
          }
        }//End single prior Ao vLine

      //Asian Open vLine (current session)
      if(__Ao_in_All_Sessions)
        {
        OpenToday(vLabels_Asian_Open, GMT_At_Ao + Broker_GMT_Offset,
        vLines_Color, vLines_Style_01234, vLines_Width_12345, level);
        }
      //Berlin Open vLine (current session)
      if(__Fo_in_All_Sessions)
        {
        OpenToday(vLabels_Berlin_Open, GMT_At_Fo + Broker_GMT_Offset,
        vLines_Color, vLines_Style_01234, vLines_Width_12345, level);
        }
      //London Open vLine (current session)
      OpenToday(vLabels_London_Open, GMT_At_Lo + Broker_GMT_Offset,
      vLines_Color, vLines_Style_01234, vLines_Width_12345, level);
      //NewYork Open vLine (current session)
      OpenToday(vLabels_NewYork_Open, GMT_At_NYo + Broker_GMT_Offset,
      vLines_Color,vLines_Style_01234, vLines_Width_12345, level);
      //London Close vLine (current session)
      OpenToday(vLabels_London_Close, GMT_At_Lc + Broker_GMT_Offset,
      vLines_Color, vLines_Style_01234, vLines_Width_12345, level);
      }

    //Do vlines for previous sessions----------------------------------------------------------
    if(__Prior_Sessions_To_Show >0 && Period() <= __Prior_Sessions_Max_TF)
      {
      int bps2 = bps +1;
      for(i= int (shift); i<=(shift+(bps2*(__Prior_Sessions_To_Show))); i++)
        {
        h=TimeHour(Time[i]);
        m=TimeMinute(Time[i]);

        //Asian Open vLine
        if(__Ao_in_All_Sessions) {
        MF = int (MathFloor(GMT_At_Ao));
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Ao != MF) && (h == MF + Broker_GMT_Offset) && (m == 30))
          {
          OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Ao == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_Asian_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          } }}}

        //Berlin Open vLine
        if(__Fo_in_All_Sessions) {
        MF = int (MathFloor(GMT_At_Fo));
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Fo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30))
          {
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Fo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_Berlin_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          } }}}

        //London Open vLine
        MF = int (MathFloor(GMT_At_Lo));
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Lo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30))
          {
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Lo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_London_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          } }}

        //NewYork Open vLine
        MF = int (MathFloor(GMT_At_NYo));
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_NYo != MF) && (h == MF + Broker_GMT_Offset) && (m == 30))
          {
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_NYo == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_NewYork_Open, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          } }}

        //London Close vLine
        MF = int (MathFloor(GMT_At_Lc));
        if((Period() > 30) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Lc != MF) && (h == MF + Broker_GMT_Offset) && (m == 30))
          {
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          }
        else {if((GMT_At_Lc == MF) && (h == MF + Broker_GMT_Offset) && (m == 0))
          {
          OpenPrior(i, vLabels_London_Close, vLines_Color, vLines_Style_01234,
          vLines_Width_12345, level);
          } }}
        }//End prior sessions shift loop
      }//End prior sessions routine
    }//End vLines routine

  //Fibo Lines---------------------------------------------------------------------------------
  if((Natural_Fibos) && (Period()<= __Fibos_Max_TF))
    {
    if(__Use_Tz_Filter)
      {
      //Send "tzdiff" (using broker non-Tz shift) to the Tz coding subroutine to
      //get proper "yesterday" H/Ls in the event of partial days, holidays, etc.
      tzdiff = 0;
      TzShift(tzdiff,idxfirstbartoday, idxfirstbaryesterday,idxlastbaryesterday);     
      //Loop through yesterday seeking the high/low prices for yesterday
      yesterday_high= -99999;  // not high enough to remain alltime high
      yesterday_low=  +99999;  // not low enough to remain alltime low
      for(idxbar= idxfirstbaryesterday; idxbar>=idxlastbaryesterday; idxbar--)
        {
        //get yesterday hi/lo prices
        yesterday_high= MathMax(iHigh(NULL, PERIOD_H1, idxbar), yesterday_high);
        yesterday_low= MathMin(iLow(NULL, PERIOD_H1, idxbar), yesterday_low);
        }
      }
    else
      {
      yesterday_high= iHigh(NULL, PERIOD_D1, 1);
      yesterday_low= iLow(NULL, PERIOD_D1, 1);
      }

    prefix= "G";
    FH= yesterday_high;
    FL= yesterday_low;
    FD= FH-FL;

    //Show_High
    H1= FH+ (FD* 0.236);
    H2= FH+ (FD* 0.382);
    H3= FH+ (FD* 0.500);
    H4= FH+ (FD* 0.618);
    H5= FH+ (FD* 0.764);
    H6= FH+ (FD* 1.000);
    H7= FH+ (FD* 1.618);
    H8= FH+ (FD* 2.618);
    H9= FH+ (FD* 4.236);
    DrawLines(prefix+" 24%", 2, H1, H_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 38%", 2, H2, H_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 50%", 2, H3, H_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 62%", 2, H4, H_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 76%", 2, H5, H_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+"   100%", 2, H6, H_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+"   162%", 2, H7, H_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+"   262%", 2, H8, H_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+"   424%", 2, H9, H_Fibo_Color,
    F_Style_01234, F_Width_12345);

    //Show_Main
    M1= FL+ (FD* 0.236);
    M2= FL+ (FD* 0.382);
    M3= FL+ (FD* 0.500);
    M4= FL+ (FD* 0.618);
    M5= FL+ (FD* 0.764);
    DrawLines(prefix+"yHI", 4, FH, M_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 24%", 2, M1, M_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 38%", 2, M2, M_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 50%", 2, M3, M_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 62%", 2, M4, M_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 76%", 2, M5, M_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+"yLO", 4, FL, M_Fibo_Color,
    F_Style_01234, F_Width_12345);

    //Show_Low
    L1= FL- (FD* 0.236);
    L2= FL- (FD* 0.382);
    L3= FL- (FD* 0.500);
    L4= FL- (FD* 0.618);
    L5= FL- (FD* 0.764);
    L6= FL- (FD* 1.000);
    L7= FL- (FD* 1.618);
    L8= FL- (FD* 2.618);
    L9= FL- (FD* 4.236);
    DrawLines(prefix+" 24%", 2, L1, L_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 38%", 2, L2, L_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 50%", 2, L3, L_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 62%", 2, L4, L_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+" 76%", 2, L5, L_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+"   100%", 2, L6, L_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+"   162%", 2, L7, L_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+"   262%", 2, L8, L_Fibo_Color,
    F_Style_01234, F_Width_12345);
    DrawLines(prefix+"   424%", 2, L9, L_Fibo_Color,
    F_Style_01234, F_Width_12345);
    }

  //Daily Pivot Lines--------------------------------------------------------------------------
  if((__Pivots_PVT_On || __Pivots_SR_On) && (Period()<= __PVT_Max_TF))
    {
    //CaveMan's sophisticated Tz shift code finds out which hour bars start "today" and
    //"yesterday" in the time zone selected for the pivots calculations.  The Tz code needs
    //"tzdiff", which is the direction and number of hours offset from "Broker_GMT_Offset",
    //to start the process.  Unless the broker server is permanently at GMT, it will vary in
    //offset to GMT depending if it is the DST or non-DST time of the year.  Getting the
    //proper DST/non-DST "Broker_GMT_Offset" is already handled by other coding. Specifically,
    //the "tzdiff", is used by the Tz shift code to shift away from the broker server hour bar
    //that starts the current day, thus defining the start of the current time zone shifted
    //day.  Then this time zone shifted start of day is used to find the start and end of the
    //previous time zone shifted day, which is the day used for the TzPivots calculations.

    //Define tzdiff
    if(!__PivotsTz_On) {tzdiff = 0;}
    else {tzdiff = int (Broker_GMT_Offset-Pivots_GMT_Offset);}

    //Send Items to the PivotsTz coding subroutine
    TzShift(tzdiff,idxfirstbartoday, idxfirstbaryesterday,idxlastbaryesterday);

    //Loop through yesterday seeking the high/low prices for yesterday
    yesterday_high= -99999;  // not high enough to remain alltime high
    yesterday_low=  +99999;  // not low enough to remain alltime low
    for(idxbar= idxfirstbaryesterday; idxbar>=idxlastbaryesterday; idxbar--)
      {
      // grab first value for open
      if (yesterday_open==0) yesterday_open= iOpen(NULL, PERIOD_H1, idxbar);
      // get yesterday hi/lo prices
      yesterday_high= MathMax(iHigh(NULL, PERIOD_H1, idxbar), yesterday_high);
      yesterday_low= MathMin(iLow(NULL, PERIOD_H1, idxbar), yesterday_low);
      // get yesterday close price
      yesterday_close= iClose(NULL, PERIOD_H1, idxbar);
      }

    q = (yesterday_high - yesterday_low);
    p = (yesterday_high + yesterday_low + yesterday_close) / 3;
    if (!Pivots_Day_vs_Fibonacci) {prefix = "F";}
    else {prefix = "D";} 
        
    //Daily Central Pivot Line
    if(__Pivots_PVT_On)
      {
      if(Period()>240 && Pivots_Display_Number== 2) {Pdisplay = 3;}
      else {Pdisplay= Pivots_Display_Number;}
      //Pivot Line data to subroutine
      DrawLines("PVT1", Pdisplay, p, PVT1_Back_Color,
      PVT1_Style_01234, PVT1_Width_12345);
      DrawLines("PVT2", Pdisplay, p, PVT2_Top_Color,
      PVT2_Style_01234, PVT2_Width_12345);
      }   

    if(__Pivots_SR_On)
      {
      if(!Pivots_Day_vs_Fibonacci)
        {
        r5 = p+ (q * 2.618);
        r4 = p+ (q * 1.618);
  	     r3 = p+q;
        r2 = p+ (q * 0.618);
        r1 = p+ (q * 0.382);
        s1 = p- (q * 0.382);
        s2 = p- (q * 0.618);
  	     s3 = p-q;
        s4 = p- (q * 1.618);
        s5 = p- (q * 2.618);
        }
      else
        {
        r5 = (4*p)+(yesterday_high-(4*yesterday_low));
        r4 = (3*p)+(yesterday_high-(3*yesterday_low));
        r3 = (2*p)+(yesterday_high-(2*yesterday_low));
        r2 = p+(yesterday_high - yesterday_low);  //r2 = p-s1+r1;
        r1 = (2*p)-yesterday_low;
        s1 = (2*p)-yesterday_high;
        s2 = p-(yesterday_high - yesterday_low);  //s2 = p-r1+s1;
        s3 = (2*p)-((2* yesterday_high)-yesterday_low);
        s4 = (3*p)-((3* yesterday_high)-yesterday_low);
        s5 = (4*p)-((4* yesterday_high)-yesterday_low);
        }
      //Daily Support & Resistance Lines
      if(Period()>240 && Pivots_Display_Number== 2) {Pdisplay= 3;}
      else {Pdisplay= Pivots_Display_Number;}
      DrawLines(prefix+"R1", Pdisplay, r1, R_Pivot_Color,
      R_Style_01234, R_Width_12345);
      DrawLines(prefix+"R2", Pdisplay, r2, R_Pivot_Color,
      R_Style_01234, R_Width_12345);
      DrawLines(prefix+"S1", Pdisplay, s1, S_Pivot_Color,
      S_Style_01234, S_Width_12345);
      DrawLines(prefix+"S2", Pdisplay, s2, S_Pivot_Color,
      S_Style_01234, S_Width_12345);
      if(__Show_Levels_Thru_2345 >= 3) {
      DrawLines(prefix+"R3", Pdisplay, r3, R_Pivot_Color,
      R_Style_01234, R_Width_12345);
      DrawLines(prefix+"S3", Pdisplay, s3, S_Pivot_Color,
      S_Style_01234, S_Width_12345); }
      if(__Show_Levels_Thru_2345 >= 4) {
      DrawLines(prefix+"R4", Pdisplay, r4, R_Pivot_Color,
      R_Style_01234, R_Width_12345);
      DrawLines(prefix+"S4", Pdisplay, s4, S_Pivot_Color,
      S_Style_01234, S_Width_12345); }
      if(__Show_Levels_Thru_2345 == 5) {
      DrawLines(prefix+"R5", Pdisplay, r5, R_Pivot_Color,
      R_Style_01234, R_Width_12345);
      DrawLines(prefix+"S5", Pdisplay, s5, S_Pivot_Color,
      S_Style_01234, S_Width_12345); }
      //Mid-Pivots
      if(____Pivots_Mid_Included)
        {       
        DrawLines("MR1", Pdisplay, (p+r1)/2,  MidPivots_Color,
        mP_Style_01234, mP_Width_12345);
        DrawLines("MR2", Pdisplay, (r1+r2)/2, MidPivots_Color,
        mP_Style_01234, mP_Width_12345);
        DrawLines("MS1", Pdisplay, (p+s1)/2,  MidPivots_Color,
        mP_Style_01234, mP_Width_12345);
        DrawLines("MS2", Pdisplay, (s1+s2)/2, MidPivots_Color,
        mP_Style_01234, mP_Width_12345);
        if(__Show_Levels_Thru_2345 >= 3) {
        DrawLines("MR3", Pdisplay, (r2+r3)/2, MidPivots_Color,
        mP_Style_01234, mP_Width_12345);
        DrawLines("MS3", Pdisplay, (s2+s3)/2, MidPivots_Color,
        mP_Style_01234, mP_Width_12345); }
        if(__Show_Levels_Thru_2345 >= 4) {
        DrawLines("MR4", Pdisplay, (r3+r4)/2, MidPivots_Color,
        mP_Style_01234, mP_Width_12345);
        DrawLines("MR4", Pdisplay, (s3+s4)/2, MidPivots_Color,
        mP_Style_01234, mP_Width_12345); }
        if(__Show_Levels_Thru_2345 == 5) {
        DrawLines("MR5", Pdisplay, (r4+r5)/2, MidPivots_Color,
        mP_Style_01234, mP_Width_12345);
        DrawLines("MS5", Pdisplay, (s4+s5)/2, MidPivots_Color,
        mP_Style_01234, mP_Width_12345); }      
        }        
      }   
    }//End Daily Pivots

  //Range Day High/Low lines-------------------------------------------------------------------
  //Define dRange and HiToday/LoToday (includes close price of previous day), which are used
  //both in this section and in Access Panel section below
  Ranges(Days_In_Range_Day_Avg);
  dRange = ARg/Days_In_Range_Day_Avg;
  if(iClose(NULL,1440,1) > iHigh(NULL,1440,0)) {HiToday = iClose(NULL,1440,1);}
  else {HiToday = iHigh(NULL,1440,0);}
  if(iClose(NULL,1440,1) < iLow(NULL,1440,0)) {LoToday = iClose(NULL,1440,1);}
  else {LoToday = iLow (NULL,1440,0);}

  if(Range_Day_On && Period()<= __Day_Max_TF)
    {
    //Calculate level of RDH/RDL lines when current range has not exceeded the average range
    if(HiToday - LoToday <= dRange)
      {
      dRangeHigh = LoToday + dRange;
      dRangeLow  = HiToday - dRange;
      }

    //Calculate position of RDH/RDL lines when current range exceeds average.  If LOD comes
    //first (higher shift#), LOD is RDL and RDH is at the average range above it.  If HOD
    //comes first (higher shift#), HOD is RDH and RDL is the average range below it.
    else //if(HiToday - LoToday > dRange)
      {
      //Define start of day time (d1), start of current TF time (d2),
      //and number of current TF chart bars (dtf) in the time span difference
      d1 = iTime(NULL,PERIOD_D1,0);
      d2 = iTime(NULL,PERIOD_M1,0);
      dtf = int ((d2-d1)/PERIOD_M1/60);

      //The number of current TF chart bars for chart TFs >= Day chart must be "1"
      if(dtf==0) {dtf=1;}

      //Search minute bars for the day for the shift numbers of the two bars that set the
      //H/L prices for the day
      Hbarshift  = iHighest(NULL,PERIOD_M1,MODE_HIGH,dtf,0);
      Lbarshift  = iLowest(NULL,PERIOD_M1,MODE_LOW,dtf,0);
      if(Lbarshift > Hbarshift)
        {
        dRangeLow= LoToday;
        dRangeHigh= LoToday + dRange;
        }
      else
        {
        dRangeHigh= HiToday;
        dRangeLow= HiToday - dRange;
        }
      }

    //Range Lines data to subroutine
    if(Period()>240 && Ranges_Display_Number== 2) {Rdisplay= 3;}
    else {Rdisplay= Ranges_Display_Number;}
    DrawLines("RDH", Rdisplay, dRangeHigh, RDH_Color,
    RD_Style_01234, RD_Width_12345);
    DrawLines("RDL", Rdisplay, dRangeLow,  RDL_Color,
    RD_Style_01234, RD_Width_12345);

    }//End Range Day

  //Range Week High/Low lines-----------------------------------------------------------------
  if(Range_Week_On && Period()<= __Week_Max_TF)
    {
    //Define Week ATR
    ARg = 0;
    for(i=1; i<=Weeks_In_Week_ATR; i++)
      {
      ARg = ARg + iHigh(NULL,10080,i)- iLow(NULL,10080,i);
      }
    wRange =  ARg/Weeks_In_Week_ATR;

    //Define Week bar O/H/L data, which includes the close price of previous week
    if(iClose(NULL,10080,1) != iOpen(NULL,10080,0)) {week_open = iClose(NULL,10080,1);}
    else {week_open = iOpen(NULL,10080,0);}
    if(iClose(NULL,10080,1) > iHigh(NULL,10080,0)) {HiWeek = iClose(NULL,10080,1);}
    else {HiWeek = iHigh(NULL,10080,0);}
    if(iClose(NULL,10080,1) < iLow(NULL,10080,0)) {LoWeek = iClose(NULL,10080,1);}
    else {LoWeek = iLow (NULL,10080,0);}

	 //Calculate position of RWH/RWL lines when current range has not exceeded the average
	 if(HiWeek - LoWeek <= wRange)
      {
      wRangeHigh = LoWeek + wRange;
      wRangeLow  = HiWeek - wRange;
      }

    //Calculate position of RWH/RWL lines when current range exceeds average.  If Low of Week
    //comes first (higher shift#), Low of Week is RWL and RWH is at the average range above it.
    //If High of Week comes first (higher shift#), High of Week is RWH and RWL is the average
    //range below it.
    else //if(HiWeek - LoWeek > wRange)
      {
      //Define start of week (w1), current time (w2) and time span difference (in chart bars)
	   w1 = iTime(NULL,PERIOD_W1,0);
	   w2 = iTime(NULL,PERIOD_M1,0);
      wtf = int ((w2-w1)/(PERIOD_M1*60));

      //Search back the number of minute bars for the shift numbers of the week H/L bars
      wHbarshift = iHighest(NULL,PERIOD_M1,MODE_HIGH,wtf,0);
	   wLbarshift = iLowest(NULL,PERIOD_M1,MODE_LOW,wtf,0);
      if(wLbarshift > wHbarshift)
        {
        wRangeLow= LoWeek;
        wRangeHigh= LoWeek + wRange;
        }
      else
        {
        wRangeHigh = HiWeek;
        wRangeLow = HiWeek - wRange;
        }
      }

    //Range Lines data to subroutine
    if(Period()>240 && Ranges_Display_Number== 2) {Rdisplay= 3;}
    else {Rdisplay= Ranges_Display_Number;}
    DrawLines("RWH", Rdisplay, wRangeHigh, RWH_Color,
    RW_Style_01234, RW_Width_12345);
    DrawLines("RWL", Rdisplay, wRangeLow,  RWL_Color,
    RW_Style_01234, RW_Width_12345);

    }//End Range Week

  //Up/down color selection when bid price changes---------------------------------------------
  //"Price" is the full-digits in all applications, and is the Bid price displayed.
  //"New_Price" is the full-digits minus the last digit for forex application and is the full
  //digits for non-forex applications, and controls when the displayed Bid price changes color.
  if(Use_Bid_Dot_Mono_Color)
    {
    Dot_Up_Color = Bid_Dot_Mono_Color;
    Dot_Dn_Color = Bid_Dot_Mono_Color;
    }
  else
    {
    Dot_Up_Color = Bid_Dot_Up_Color;
    Dot_Dn_Color = Bid_Dot_Dn_Color;
    }
  if(Digits > 2)
    {
    New_Price = MathFloor(Bid/Poin)*Poin;
    }
  else
    {
    New_Price = Bid;
    }
  if(New_Price > Old_Price)
    {
    Color = Bid_UP_Color;
    Static_Price_Color = Bid_UP_Color;
    Bid_Dot_Color = Dot_Up_Color;
    Static_Bid_Dot_Color = Bid_Dot_Color;
    }
  else {if (New_Price < Old_Price)
    {
    Color = Bid_DN_Color;
    Static_Price_Color = Bid_DN_Color;
    Bid_Dot_Color = Dot_Dn_Color;
    Static_Bid_Dot_Color = Bid_Dot_Color;
    }
  else //if (New_Price == Old_Price)
    {
    Color = Static_Price_Color;
    Bid_Dot_Color = Static_Bid_Dot_Color;
    } }
  Old_Price = New_Price;

  //Bid Line-----------------------------------------------------------------------------------                           
  //Set T1 and T2 (T1 is set in start() section)
  if(Period() == 43200) {T1=T1+(Period()*60*1);}
  //Ask line
  if((Ask_Line_On) && (Period() <= __Ask_Max_TF))
    {
    ObjectCreate(item22, OBJ_TREND, 0, T1, Ask, Time[0], Ask);
    ObjectSet(item22, OBJPROP_STYLE, Ask_Ray_LineStyle_01234 );
    ObjectSet(item22, OBJPROP_COLOR, Ask_Ray_Color);
    ObjectSet(item22, OBJPROP_WIDTH, Ask_Ray_Thickness);
    if(Subordinate_Ask_Bid_Lines) {ObjectSet(item22, OBJPROP_BACK, true);}
    ObjectCreate(item23, OBJ_TREND, 0, T1, Ask, T1, Ask);
    ObjectSet(item23, OBJPROP_STYLE, 0);
    ObjectSet(item23, OBJPROP_COLOR, Ask_Dot_Color);
    ObjectSet(item23, OBJPROP_WIDTH, Ask_Dot_Size);
    ObjectCreate(item24, OBJ_TREND, 0, T1, Ask, T1, Ask);
    ObjectSet(item24, OBJPROP_STYLE, 0);
    ObjectSet(item24, OBJPROP_COLOR, Ask_Dot_Cntr_Color);
    ObjectSet(item24, OBJPROP_WIDTH, Ask_Dot_Cntr_Size);
    }
  //Bid line
  if(Bid_Line_On)
    {
    ObjectCreate(item20, OBJ_TREND, 0, T1, Bid, Time[0], Bid);
    ObjectSet(item20, OBJPROP_STYLE, Bid_Ray_LineStyle_01234 );
    ObjectSet(item20, OBJPROP_COLOR, Bid_Ray_Color);
    ObjectSet(item20, OBJPROP_WIDTH, Bid_Ray_Thickness);
    if(Subordinate_Ask_Bid_Lines) {ObjectSet(item20, OBJPROP_BACK, true);}
    ObjectCreate(item21, OBJ_TREND, 0, T1, Bid, T1, Bid);
    ObjectSet(item21, OBJPROP_STYLE, 0);
    ObjectSet(item21, OBJPROP_COLOR, Bid_Dot_Color);
    ObjectSet(item21, OBJPROP_WIDTH, Bid_Dot_Size);
    }
  //End Bid Line

  //Panel--------------------------------------------------------------------------------------
  if(Show_Access_Panel)
    {
    if(__Show_Clock_in_Panel)
      {
      //Background box 2
      if(__Show_Logo_in_Panel)
        {
        if(Show_AMPM_Time) G2= 142; else G2= 124;
        }
      else
        {
        if(Show_AMPM_Time) G2= 109; else G2= 90;
        }
      MakeLabel( item02, G2, 0);
      ObjectSetText(item02, "gg", 64, "Webdings", Panel_Background_Color);
      }

    //Background box 1
    if(__Show_Logo_in_Panel) G1= 0; else {G1= -25;}
    MakeLabel( item01, G1, 0);
    ObjectSetText(item01, "gg", 64, "Webdings", Panel_Background_Color1);

    //Symbol and Time Frame
    MakeLabel( item03, 782,252);
    if(StringSubstr(Symbol(),0,1)!=".") {ID = StringSubstr(Symbol(), 0, 6);}
    else {ID =StringSubstr(Symbol(),1,8);}
    C = ""; if (Period()== 1)     C =C +  "    "+ID+"   M1";
    else {if (Period()== 5)     C =C +  "    "+ID+"   M5";
    else {if (Period()== 15)    C =C +  "    "+ID+"   M15";
    else {if (Period()== 30)    C =C +  "    "+ID+"   M30";
    else {if (Period()== 60)    C =C +  "    "+ID+"   H1";
    else {if (Period()== 240)   C =C +  "    "+ID+"   H4";
    else {if (Period()== 1440)  C =C +  "    "+ID+"   Day";
    else {if (Period()== 10080) C =C +  "   " +ID+"   Week";
    else {if (Period()== 43200) C =C +  "  "  +ID+"   Month"; }}}}}}}}
    ObjectSetText(item03, C,8, "Arial Bold", Symbol_And_TF_Color);

    //Spread
    
   

    //Show Range data
    

    

    //Show Candle Time
   
   

    //Market Price
    if(Digits > 2 && Show_Forex_Fractional_Pip)  {MakeLabel( item12, 771,222);}
    else {MakeLabel( item12, 772,228);}
    MakeLabel( item13, 772,228);
    Price=DoubleToStr(Bid, Digits);
    LP = StringLen(Price);
    if(Digits != 3)
      {
	   tab= "    ";
	   if(LP<8) {tab=tab + " ";}
	   if(LP==5) {tab=tab + "  ";}
	   }
    else
      {
      tab= "     ";
      if(LP==6) {tab=tab + " ";}    	        
      }
    //Show final Price digit as subordinate
    if(Digits > 2 && Show_Forex_Fractional_Pip)
      {
      tab1="";
      if(LP<=5) {for(i=0; i<= __Shift_Fractional_Pip+ 2.4*LP-1; i++) {tab1= tab1 + " ";} }
      else {if(LP==6) {for(i=0; i<= __Shift_Fractional_Pip+ 2.4*LP-1; i++) {tab1= tab1 + " ";} }
      else {if(LP==7) {for(i=0; i<= __Shift_Fractional_Pip+ 2.5*LP-1; i++) {tab1= tab1 + " ";} }
      else {if(LP>=8) {for(i=0; i<= __Shift_Fractional_Pip+ 2.4*LP-1; i++) {tab1= tab1 + " ";} } }}}
      ObjectSetText(item12,tab+tab1+StringSubstr(Price,LP-1,1),10,"Arial Bold",Bid_Last_Digit_Small);
      ObjectSetText(item13,tab+StringSubstr(Price,0,LP-1),14,"Arial Bold",Color);
      }
    //Show all Price digits uniformly
    else if(Digits > 2)
      {
      ObjectSetText(item12,tab+Price,14,"Arial Bold",Bid_Last_Digit_Normal);
      ObjectSetText(item13,tab+StringSubstr(Price,0,LP-1),14,"Arial Bold",Color);
      }
    else //if(Digits == 2)
      {
      ObjectSetText(item12,tab+Price,14,"Arial Bold",Color);
      ObjectSetText(item13,tab+StringSubstr(Price,0,LP-1),14,"Arial Bold",Color);
      }
    
  //Clock--------------------------------------------------------------------------------------
  //Go to subroutine for rest of TZ info needed for Clock 
  if(__Show_Clock_in_Panel) 
    {
    //Go to subroutine to convert time data to string format for use in clock labels
    if(!Clock_Normal_vs_Find_Server)
      {
      BrokerDT = TimeCurrent();
      Broker_GMT_Offset = int((BrokerDT-UTC)/3600);
      }
    Brokers   = TimeToStrings( BrokerDT );
    Aucklands = TimeToStrings( AucklandDT  );
    Sydneys   = TimeToStrings( SydneyDT  );
    Tokyos    = TimeToStrings( TokyoDT  );
    Chinas    = TimeToStrings( ChinaDT  );
    Jakartas  = TimeToStrings( JakartaDT  );
    Indias    = TimeToStrings( IndiaDT  );
    Dubais    = TimeToStrings( DubaiDT  );
    Moscows   = TimeToStrings( MoscowDT  );
    Israels   = TimeToStrings( IsraelDT  );
    Helsinkis = TimeToStrings( HelsinkiDT  );
    Berlins   = TimeToStrings( BerlinDT  );
    Londons   = TimeToStrings( LondonDT  );
    UTCs      = TimeToStrings( UTC );
    Brazils   = TimeToStrings( BrazilDT  );
    NewYorks  = TimeToStrings( NewYorkDT  );
    Centrals  = TimeToStrings( CentralDT  );
    Mexicos   = TimeToStrings( MexicoDT  );
    Mountains = TimeToStrings( MountainDT  );
    Pacifics  = TimeToStrings( PacificDT  );
    Locals    = TimeToStrings( Local_Time  ); 
    if(UTC <= BrokerDT+600 && UTC >= BrokerDT-600) {BKR_UTC_Match = true;}

    //Formating clock labels
    FontName = "Arial";
    ClockFontSize = 7;
    TimezoneFontSize = 7;
    LineSpacing = 11;//12
    top   = 3;   //vertical start text
    offset= 0;   //vertical "LineSpacing" additions to "top" per line of text
    if(__Show_Logo_in_Panel)
      {
      time  = 180; //horizontal inset time (same for 24hr and am/pm times)
      if(Show_AMPM_Time) place= 232; else place= 215;
      }
    else
      {
      time  = 146; //horizontal inset time (same for 24hr and am/pm times)
      if(Show_AMPM_Time) place= 198; else place= 180;
      }

  	 //Begin world timezones, listed IN ORDER!
    if(Broker == 1)
      {
      MakeLabel( "z[CP Time] Brokert", time, top+offset );
      MakeLabel( "z[CP Time] Brokerl", place, top+offset );
     	offset+=LineSpacing;
      }
    if(Auckland == 1)
      {
   	MakeLabel( "z[CP Time] Aucklandt", time, top+offset );
   	MakeLabel( "z[CP Time] Aucklandl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Sydney == 1)
      {
   	MakeLabel( "z[CP Time] Sydneyt", time, top+offset );
   	MakeLabel( "z[CP Time] Sydneyl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Tokyo == 1)
      {
   	MakeLabel( "z[CP Time] Tokyot", time, top+offset );
   	MakeLabel( "z[CP Time] Tokyol", place, top+offset );
   	offset+=LineSpacing;
      }
    if(HongKong == 1)
      {
   	MakeLabel( "z[CP Time] Chinat", time, top+offset );
   	MakeLabel( "z[CP Time] Chinal", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Jakarta == 1)
      {
   	MakeLabel( "z[CP Time] Jakartat", time, top+offset );
   	MakeLabel( "z[CP Time] Jakartal", place, top+offset );
   	offset+=LineSpacing;
      }
    if(India == 1)
      {
   	MakeLabel( "z[CP Time] Indiat", time, top+offset );
   	MakeLabel( "z[CP Time] Indial", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Dubai == 1)
      {
   	MakeLabel( "z[CP Time] Dubait", time, top+offset );
   	MakeLabel( "z[CP Time] Dubail", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Moscow == 1)
      {
   	MakeLabel( "z[CP Time] Moscowt", time, top+offset );
   	MakeLabel( "z[CP Time] Moscowl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Israel == 1)
      {
   	MakeLabel( "z[CP Time] Israelt", time, top+offset );
   	MakeLabel( "z[CP Time] Israell", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Helsinki == 1)
      {                          	       
   	MakeLabel( "z[CP Time] Helsinkit", time, top+offset );
   	MakeLabel( "z[CP Time] Helsinkil", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Frankfurt == 1)
      {
   	MakeLabel( "z[CP Time] Berlint", time, top+offset );
   	MakeLabel( "z[CP Time] Berlinl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(London == 1)
      {
	   MakeLabel( "z[CP Time] Londont", time, top+offset );
   	MakeLabel( "z[CP Time] Londonl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(GMT == 1)
      {
   	MakeLabel( "z[CP Time] utct", time, top+offset );
   	MakeLabel( "z[CP Time] utcl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Brazil == 1)
      {
   	MakeLabel( "z[CP Time] Brazilt", time, top+offset );
   	MakeLabel( "z[CP Time] Brazill", place, top+offset );
   	offset+=LineSpacing;
      }
    if(NewYork == 1)
      {
	   MakeLabel( "z[CP Time] NewYorkt", time, top+offset );
   	MakeLabel( "z[CP Time] NewYorkl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Central == 1)
      {
   	MakeLabel( "z[CP Time] Centralt", time, top+offset );
   	MakeLabel( "z[CP Time] Centrall", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Mexico == 1)
      {
   	MakeLabel( "z[CP Time] Mexicot", time, top+offset );
   	MakeLabel( "z[CP Time] Mexicol", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Mountain == 1)
      {
   	MakeLabel( "z[CP Time] Mountaint", time, top+offset );
   	MakeLabel( "z[CP Time] Mountainl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Pacific == 1)
      {
	   MakeLabel( "z[CP Time] Pacifict", time, top+offset );
   	MakeLabel( "z[CP Time] Pacificl", place, top+offset );
   	offset+=LineSpacing;
      }
    if(Local == 1)
      {
      MakeLabel( "z[CP Time] Localt", time, top+offset );
      MakeLabel( "z[CP Time] Locall", place, top+offset );
      offset+=LineSpacing;
      }

    //Set condition for showing "P" location in Clock labels
    if((__PivotsTz_On) && (__Pivots_PVT_On || __Pivots_SR_On) && (Period()<= __PVT_Max_TF))
      {Displaying_Pivots = true;}

    //Populate Clock Labels
    if(Broker == 1)
      {
      Brokerp= "Broker";
      //Show time zone is same as local
      if(BrokerDT <= Local_Time+600 && BrokerDT >= Local_Time-600)
        {
        Brokerp= Brokerp + "  (L)";
        }
      //Show time zone is same as GMT
      if(BrokerDT == UTC)
        {
        if(StringLen(Brokerp) == 6)
          {
          Brokerp= Brokerp + "  (G)";
          }
        else
          {
          Brokerp= StringSubstr(Brokerp,0,StringLen(Brokerp)-1) + ",G)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (BrokerDT <= pvtDT+600 && BrokerDT >= pvtDT-600))
        {
        if(StringLen(Brokerp) == 6)
          {
          Brokerp= Brokerp + "  (P)";
          }
        else
          {
          Brokerp= StringSubstr(Brokerp,0,StringLen(Brokerp)-1) + ",P)";
          }
        }
	   ObjectSetText( "z[CP Time] Brokert", Brokers, ClockFontSize, FontName, Clock_MktClosed );
      ObjectSetText( "z[CP Time] Brokerl", Brokerp, TimezoneFontSize, FontName, Location_MktClosed );
      }
    if(Auckland == 1)
      {
      Aucklandp= "Auckland";
      //Show if time zone is same as for broker server
      if(AucklandDT <= BrokerDT+600 && AucklandDT >= BrokerDT-600)
        {
        if(StringLen(Aucklandp) == 8)
          {
          Aucklandp= Aucklandp + "  (B)";
          }
        else
          {
          Aucklandp= StringSubstr(Aucklandp,0,StringLen(Aucklandp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(AucklandDT <= Local_Time+600 && AucklandDT >= Local_Time-600)
        {
        if(StringLen(Aucklandp) == 8)
          {
          Aucklandp= Aucklandp + "  (L)";
          }
        else
          {
          Aucklandp= StringSubstr(Aucklandp,0,StringLen(Aucklandp)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (AucklandDT <= pvtDT+600 && AucklandDT >= pvtDT-600))
        {
        if(StringLen(Aucklandp) == 8)
          {
          Aucklandp= Aucklandp + "  (P)";
          }
        else
          {
          Aucklandp= StringSubstr(Aucklandp,0,StringLen(Aucklandp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(AucklandDT) != 0 && TimeDayOfWeek(AucklandDT) != 6
   	  && TimeHour(AucklandDT) >= LocalOpenHour && TimeHour(AucklandDT) < LocalCloseHour)
        {
   	  ObjectSetText( "z[CP Time] Aucklandt", Aucklands, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Aucklandl", Aucklandp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
      else
   	  {
   	  ObjectSetText( "z[CP Time] Aucklandt", Aucklands, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Aucklandl", Aucklandp, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(Sydney == 1)
      {
      Sydneyp= "Sydney";
      //Show if time zone is same as for broker server
      if(SydneyDT <= BrokerDT+600 && SydneyDT >= BrokerDT-600)
        {
        if(StringLen(Sydneyp) == 6)
          {
          Sydneyp= Sydneyp + "  (B)";
          }
        else
          {
          Sydneyp= StringSubstr(Sydneyp,0,StringLen(Sydneyp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(SydneyDT <= Local_Time+600 && SydneyDT >= Local_Time-600)
        {
        if(StringLen(Sydneyp) == 6)
          {
          Sydneyp= Sydneyp + "  (L)";
          }
        else
          {
          Sydneyp= StringSubstr(Sydneyp,0,StringLen(Sydneyp)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (SydneyDT <= pvtDT+600 && SydneyDT >= pvtDT-600))
        {
        if(StringLen(Sydneyp) == 6)
          {
          Sydneyp= Sydneyp + "  (P)";
          }
        else
          {
          Sydneyp= StringSubstr(Sydneyp,0,StringLen(Sydneyp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(SydneyDT) != 0 && TimeDayOfWeek(SydneyDT) != 6
   	  && TimeHour(SydneyDT) >= SydneyLocalOpenHour && TimeHour(SydneyDT) < SydneyLocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Sydneyt", Sydneys, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Sydneyl", Sydneyp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Sydneyt", Sydneys, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Sydneyl", Sydneyp, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(Tokyo == 1)
      {
      Tokyop= "Tokyo";
      //Show if time zone is same as for broker server
      if(TokyoDT <= BrokerDT+600 && TokyoDT >= BrokerDT-600)
        {
        if(StringLen(Tokyop) == 5)
          {
          Tokyop= Tokyop + "  (B)";
          }
        else
          {
          Tokyop= StringSubstr(Tokyop,0,StringLen(Tokyop)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(TokyoDT <= Local_Time+600 && TokyoDT >= Local_Time-600)
        {
        if(StringLen(Tokyop) == 5)
          {
          Tokyop= Tokyop + "  (L)";
          }
        else
          {
          Tokyop= StringSubstr(Tokyop,0,StringLen(Tokyop)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (TokyoDT <= pvtDT+600 && TokyoDT >= pvtDT-600))
        {
        if(StringLen(Tokyop) == 5)
          {
          Tokyop= Tokyop + "  (P)";
          }
        else
          {
          Tokyop= StringSubstr(Tokyop,0,StringLen(Tokyop)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(TokyoDT) != 0 && TimeDayOfWeek(TokyoDT) != 6
   	  && TimeHour(TokyoDT) >= TokyoLocalOpenHour && TimeHour(TokyoDT) < TokyoLocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Tokyot", Tokyos, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Tokyol", Tokyop, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Tokyot", Tokyos, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Tokyol", Tokyop, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(HongKong == 1)
      {
      Chinap= "HongKong";
      //Show if time zone is same as for broker server
      if(ChinaDT <= BrokerDT+600 && ChinaDT >= BrokerDT-600)
        {
        if(StringLen(Chinap) == 8)
          {
          Chinap= Chinap + "  (B)";
          }
        else
          {
          Chinap= StringSubstr(Chinap,0,StringLen(Chinap)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(ChinaDT <= Local_Time+600 && ChinaDT >= Local_Time-600)
        {
        if(StringLen(Chinap) == 8)
          {
          Chinap= Chinap + "  (L)";
          }
        else
          {
          Chinap= StringSubstr(Chinap,0,StringLen(Chinap)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (ChinaDT <= pvtDT+600 && ChinaDT >= pvtDT-600))
        {
        if(StringLen(Chinap) == 8)
          {
          Chinap= Chinap + "  (P)";
          }
        else
          {
          Chinap= StringSubstr(Chinap,0,StringLen(Chinap)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(ChinaDT) != 0 && TimeDayOfWeek(ChinaDT) != 6
   	  && TimeHour(ChinaDT) >= LocalOpenHour && TimeHour(ChinaDT) < LocalCloseHour)
   	  {
    	  ObjectSetText( "z[CP Time] Chinat", Chinas, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Chinal", Chinap, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Chinat", Chinas, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Chinal", Chinap, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Jakarta == 1)
      {
      Jakartap= "Jakarta";
      //Show if time zone is same as for broker server
      if(JakartaDT <= BrokerDT+600 && JakartaDT >= BrokerDT-600)
        {
        if(StringLen(Jakartap) == 7)
          {          
          Jakartap= Jakartap + "  (B)";
          }
        else
          {
          Jakartap= StringSubstr(Jakartap,0,StringLen(Jakartap)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(JakartaDT <= Local_Time+600 && JakartaDT >= Local_Time-600)
        {
        if(StringLen(Jakartap) == 7)
          {
          Jakartap= Jakartap + "  (L)";
          }
        else
          {
          Jakartap= StringSubstr(Jakartap,0,StringLen(Jakartap)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (JakartaDT <= pvtDT+600 && JakartaDT >= pvtDT-600))
        {
        if(StringLen(Jakartap) == 7)
          {
          Jakartap= Jakartap + "  (P)";
          }
        else
          {
          Jakartap= StringSubstr(Jakartap,0,StringLen(Jakartap)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(JakartaDT) != 0 && TimeDayOfWeek(JakartaDT) != 6
   	  && TimeHour(JakartaDT) >= LocalOpenHour && TimeHour(JakartaDT) < LocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Jakartat", Jakartas, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Jakartal", Jakartap, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Jakartat", Jakartas, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Jakartal", Jakartap, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(India == 1)
      {
      Indiap= "India";
      //Show if time zone is same as for broker server
      if(IndiaDT <= BrokerDT+600 && IndiaDT >= BrokerDT-600)
        {
        if(StringLen(Indiap) == 5)
          {
          Indiap= Indiap + "  (B)";
          }
        else
          {
          Indiap= StringSubstr(Indiap,0,StringLen(Indiap)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(IndiaDT <= Local_Time+600 && IndiaDT >= Local_Time-600)
        {
        if(StringLen(Indiap) == 5)
          {
          Indiap= Indiap + "  (L)";
          }
        else
          {
          Indiap= StringSubstr(Indiap,0,StringLen(Indiap)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (IndiaDT <= pvtDT+600 && IndiaDT >= pvtDT-600))
        {
        if(StringLen(Indiap) == 5)
          {
          Indiap= Indiap + "  (P)";
          }
        else
          {
          Indiap= StringSubstr(Indiap,0,StringLen(Indiap)-1) + ",P)";
          }               
        }
   	if(TimeDayOfWeek(IndiaDT) != 0 && TimeDayOfWeek(IndiaDT) != 6
   	  && TimeHour(IndiaDT) >= LocalOpenHour && TimeHour(IndiaDT) < LocalCloseHour)
   	  {
    	  ObjectSetText( "z[CP Time] Indiat", Indias, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Indial", Indiap, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
      else
        {
    	  ObjectSetText( "z[CP Time] Indiat", Indias, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Indial", Indiap, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(Dubai == 1)
      {
      Dubaip= "Dubai";
      //Show if time zone is same as for broker server
      if(DubaiDT <= BrokerDT+600 && DubaiDT >= BrokerDT-600)
        {
        if(StringLen(Dubaip) == 5)
          {
          Dubaip= Dubaip + "  (B)";
          }
        else
          {
          Dubaip= StringSubstr(Dubaip,0,StringLen(Dubaip)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(DubaiDT <= Local_Time+600 && DubaiDT >= Local_Time-600)
        {
        if(StringLen(Dubaip) == 5)
          {
          Dubaip= Dubaip + "  (L)";
          }
        else
          {
          Dubaip= StringSubstr(Dubaip,0,StringLen(Dubaip)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (DubaiDT <= pvtDT+600 && DubaiDT >= pvtDT-600))
        {
        if(StringLen(Dubaip) == 5)
          {
          Dubaip= Dubaip + "  (P)";
          }
        else
          {
          Dubaip= StringSubstr(Dubaip,0,StringLen(Dubaip)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(DubaiDT) != 0 && TimeDayOfWeek(DubaiDT) != 6
   	  && TimeHour(DubaiDT) >= LocalOpenHour && TimeHour(DubaiDT) < LocalCloseHour)
        {
   	  ObjectSetText( "z[CP Time] Dubait", Dubais, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Dubail", Dubaip, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Dubait", Dubais, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Dubail", Dubaip, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(Moscow == 1)
      {
      Moscowp= "Moscow";
      //Show if time zone is same as for broker server
      if(MoscowDT <= BrokerDT+600 && MoscowDT >= BrokerDT-600)
        {
        if(StringLen(Moscowp) == 6)
          {
          Moscowp= Moscowp + "  (B)";
          }
        else
          {
          Moscowp= StringSubstr(Moscowp,0,StringLen(Moscowp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(MoscowDT <= Local_Time+600 && MoscowDT >= Local_Time-600)
        {
        if(StringLen(Moscowp) == 6)
          {
          Moscowp= Moscowp + "  (L)";
          }
        else
          {
          Moscowp= StringSubstr(Moscowp,0,StringLen(Moscowp)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (MoscowDT <= pvtDT+600 && MoscowDT >= pvtDT-600))
        {
        if(StringLen(Moscowp) == 6)
          {
          Moscowp= Moscowp + "  (P)";
          }
        else
          {
          Moscowp= StringSubstr(Moscowp,0,StringLen(Moscowp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(MoscowDT) != 0 && TimeDayOfWeek(MoscowDT) != 6
   	  && TimeHour(MoscowDT) >= LocalOpenHour && TimeHour(MoscowDT) < LocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Moscowt", Moscows, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Moscowl", Moscowp, TimezoneFontSize, FontName, Location_MktOpen );
        }
   	else
   	  {
    	  ObjectSetText( "z[CP Time] Moscowt", Moscows, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Moscowl", Moscowp, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Israel == 1)
      {
      Israelp= "Israel";
      //Show if time zone is same as for broker server
      if(IsraelDT <= BrokerDT+600 && IsraelDT >= BrokerDT-600)
        {
        if(StringLen(Israelp) == 6)
          {
          Israelp= Israelp + "  (B)";
          }
        else
          {
          Israelp= StringSubstr(Israelp,0,StringLen(Israelp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(IsraelDT <= Local_Time+600 && IsraelDT >= Local_Time-600)
        {
        if(StringLen(Israelp) == 6)
          {
          Israelp= Israelp + "  (L)";
          }
        else
          {
          Israelp= StringSubstr(Israelp,0,StringLen(Israelp)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (IsraelDT <= pvtDT+600 && IsraelDT >= pvtDT-600))
        {
        if(StringLen(Israelp) == 6)
          {
          Israelp= Israelp + "  (P)";
          }
        else
          {
          Israelp= StringSubstr(Israelp,0,StringLen(Israelp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(IsraelDT) != 0 && TimeDayOfWeek(IsraelDT) != 6
   	  && TimeHour(IsraelDT) >= LocalOpenHour && TimeHour(IsraelDT) < LocalCloseHour)
        {
   	  ObjectSetText( "z[CP Time] Israelt", Israels, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Israell", Israelp, TimezoneFontSize, FontName, Location_MktOpen );
        }
   	else
        {
  	     ObjectSetText( "z[CP Time] Israelt", Israels, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Israell", Israelp, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Helsinki == 1)
      {
      Helsinkip= "Helsinki";
      //Show if time zone is same as for broker server
      if(HelsinkiDT <= BrokerDT+600 && HelsinkiDT >= BrokerDT-600)
        {
        if(StringLen(Helsinkip) == 8)
          {
          Helsinkip= Helsinkip + "  (B)";
          }
        else
          {
          Helsinkip= StringSubstr(Helsinkip,0,StringLen(Helsinkip)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(HelsinkiDT <= Local_Time+600 && HelsinkiDT >= Local_Time-600)
        {
        if(StringLen(Helsinkip) == 8)
          {
          Helsinkip= Helsinkip + "  (L)";
          }
        else
          {
          Helsinkip= StringSubstr(Helsinkip,0,StringLen(Helsinkip)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (HelsinkiDT <= pvtDT+600 && HelsinkiDT >= pvtDT-600))
        {
        if(StringLen(Helsinkip) == 8)
          {
          Helsinkip= Helsinkip + "  (P)";
          }
        else
          {
          Helsinkip= StringSubstr(Helsinkip,0,StringLen(Helsinkip)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(HelsinkiDT) != 0 && TimeDayOfWeek(HelsinkiDT) != 6
   	  && TimeHour(HelsinkiDT) >= LocalOpenHour && TimeHour(HelsinkiDT) < LocalCloseHour)
        {
   	  ObjectSetText( "z[CP Time] Helsinkit", Helsinkis, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Helsinkil", Helsinkip, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
    	  ObjectSetText( "z[CP Time] Helsinkit", Helsinkis, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Helsinkil", Helsinkip, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Frankfurt == 1)
      {
      Berlinp= "Frankfurt";
      //Show if time zone is same as for broker server
      if(BerlinDT <= BrokerDT+600 && BerlinDT >= BrokerDT-600)
        {
        if(StringLen(Berlinp) == 9)
          {
          Berlinp= Berlinp + "  (B)";
          }
        else
          {
          Berlinp= StringSubstr(Berlinp,0,StringLen(Berlinp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(BerlinDT <= Local_Time+600 && BerlinDT >= Local_Time-600)
        {
        if(StringLen(Berlinp) == 9)
          {
          Berlinp= Berlinp + "  (L)";
          }
        else
          {
          Berlinp= StringSubstr(Berlinp,0,StringLen(Berlinp)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (BerlinDT <= pvtDT+600 && BerlinDT >= pvtDT-600))
        {
        if(StringLen(Berlinp) == 9)
          {
          Berlinp= Berlinp + "  (P)";
          }
        else
          {
          Berlinp= StringSubstr(Berlinp,0,StringLen(Berlinp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(BerlinDT) != 0 && TimeDayOfWeek(BerlinDT) != 6
   	  && TimeHour(BerlinDT) >= LocalOpenHour && TimeHour(BerlinDT) < LocalCloseHour)
        {
   	  ObjectSetText( "z[CP Time] Berlint", Berlins, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Berlinl", Berlinp, TimezoneFontSize, FontName, Location_MktOpen );
        }
   	else
        {
   	  ObjectSetText( "z[CP Time] Berlint", Berlins, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Berlinl", Berlinp, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(London == 1)
      {
      //Test summer display during winter: change values to summer values relationships
      //UTC = LondonDT-3600;
      //BKR_UTC_Match =true;  //means BrokerDT = UTC
      //BKR_UTC_Match =false;  //means BrokerDT != UTC
      Londonp= "London";
      //Show if time zone is same as for broker server
      if(LondonDT <= BrokerDT+600 && LondonDT >= BrokerDT-600)
        {
        if(StringLen(Londonp) == 6)
          {
          Londonp= Londonp + "  (B)";
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(LondonDT <= Local_Time+600 && LondonDT >= Local_Time-600)
        {
        if(StringLen(Londonp) == 6)
          {
          Londonp= Londonp + "  (L)";
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",L)";
          }
        }
      //Show time zone is same as GMT
      if(LondonDT == UTC)
        {
        if(StringLen(Londonp) == 6)
          {
          Londonp= Londonp + "  (G)";
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",G)";
          }
        }
      //Show time zone is B+1 if broker is at GMT
      if((LondonDT != UTC) && (BKR_UTC_Match))
        {
        if(StringLen(Londonp) == 6)
          {
          Londonp= Londonp + "  (B/G+1)";
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",B/G+1)";
          }
        }
      //Show time zone is G+1 if Broker is not at GMT
      if((LondonDT != UTC) && (!BKR_UTC_Match))
        {
        if(StringLen(Londonp) == 6)
          {
          Londonp= Londonp + "  (G+1)";
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",G+1)";
          }
        }
      //Show time zone is same as for pivots
       if(Displaying_Pivots && (LondonDT <= pvtDT+600 && LondonDT >= pvtDT-600))
        {
        if(StringLen(Londonp) == 6)
          {
          Londonp= Londonp + " (P)";
          }
        else
          {
          Londonp= StringSubstr(Londonp,0,StringLen(Londonp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(LondonDT) != 0 && TimeDayOfWeek(LondonDT) != 6
   	  && TimeHour(LondonDT) >= LocalOpenHour && TimeHour(LondonDT) < LocalCloseHour)
   	  {
        ObjectSetText( "z[CP Time] Londont", Londons, ClockFontSize, FontName, Clock_MktOpen );
        ObjectSetText( "z[CP Time] Londonl", Londonp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Londont", Londons, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Londonl", Londonp, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(GMT == 1)
      {
      UTCp= "GMT";
      //Show if time zone is same as for broker server
      if(UTC <= BrokerDT+600 && UTC >= BrokerDT-600)
        {
        if(StringLen(UTCp) == 3)
          {
          UTCp= UTCp + "  (B)";
          }
        else
          {
          UTCp= StringSubstr(UTCp,0,StringLen(UTCp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(UTC <= Local_Time+600 && UTC >= Local_Time-600)
        {
        if(StringLen(UTCp) == 3)
          {
          UTCp= UTCp + "  (L)";
          }
        else
          {
          UTCp= StringSubstr(UTCp,0,StringLen(UTCp)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (UTC <= pvtDT+600 && UTC >= pvtDT-600))
        {
        if(StringLen(UTCp) == 3)
          {
          UTCp= UTCp + "  (P)";
          }
        else
          {
          UTCp= StringSubstr(UTCp,0,StringLen(UTCp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(UTC) != 0 && TimeDayOfWeek(UTC) != 6
   	  && TimeHour(UTC) >= LocalOpenHour && TimeHour(UTC) < LocalCloseHour)
   	  {
        ObjectSetText( "z[CP Time] utct", UTCs, ClockFontSize, FontName, Clock_MktOpen );
        ObjectSetText( "z[CP Time] utcl", UTCp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] utct", UTCs, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] utcl", UTCp, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Brazil == 1)
      {
      Brazilp= "Brazil";
      //Show if time zone is same as for broker server
      if(BrazilDT <= BrokerDT+600 && BrazilDT >= BrokerDT-600)
        {
        if(StringLen(Brazilp) == 6)
          {
          Brazilp= Brazilp + "  (B)";
          }
        else
          {
          Brazilp= StringSubstr(Brazilp,0,StringLen(Brazilp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(BrazilDT <= Local_Time+600 && BrazilDT >= Local_Time-600)
        {
        if(StringLen(Brazilp) == 6)
          {
          Brazilp= Brazilp + "  (L)";
          }
        else
          {
          Brazilp= StringSubstr(Brazilp,0,StringLen(Brazilp)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (BrazilDT <= pvtDT+600 && BrazilDT >= pvtDT-600))
        {
        if(StringLen(Brazilp) == 6)
          {
          Brazilp= Brazilp + "  (P)";
          }
        else
          {
          Brazilp= StringSubstr(Brazilp,0,StringLen(Brazilp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(BrazilDT) != 0 && TimeDayOfWeek(BrazilDT) != 6
   	  && TimeHour(BrazilDT) >= LocalOpenHour && TimeHour(BrazilDT) < LocalCloseHour)
   	  {
    	  ObjectSetText( "z[CP Time] Brazilt", Brazils, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Brazill", Brazilp, TimezoneFontSize, FontName, Location_MktOpen );
        }
   	else
        {
   	  ObjectSetText( "z[CP Time] Brazilt", Brazils, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Brazill", Brazilp, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(NewYork == 1)
      {
      NYp= "NewYork";
      //Show if time zone is same as for broker server
      if(NewYorkDT <= BrokerDT+600 && NewYorkDT >= BrokerDT-600)
        {
        if(StringLen(NYp) == 7)
          {
          NYp= NYp + "  (B)";
          }
        else
          {
          NYp= StringSubstr(NYp,0,StringLen(NYp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(NewYorkDT <= Local_Time+600 && NewYorkDT >= Local_Time-600)
        {
        if(StringLen(NYp) == 7)
          {
          NYp= NYp + "  (L)";
          }
        else
          {
          NYp= StringSubstr(NYp,0,StringLen(NYp)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (NewYorkDT <= pvtDT+600 && NewYorkDT >= pvtDT-600))
        {
        if(StringLen(NYp) == 7)
          {
          NYp= NYp + "  (P)";
          }
        else
          {
          NYp= StringSubstr(NYp,0,StringLen(NYp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(NewYorkDT) != 0 && TimeDayOfWeek(NewYorkDT) != 6
   	  && TimeHour(NewYorkDT) >= LocalOpenHour && TimeHour(NewYorkDT) < LocalCloseHour)
   	  {
        ObjectSetText( "z[CP Time] NewYorkt", NewYorks, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] NewYorkl", NYp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
        ObjectSetText( "z[CP Time] NewYorkt", NewYorks, ClockFontSize, FontName, Clock_MktClosed );
        ObjectSetText( "z[CP Time] NewYorkl", NYp, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(Central == 1)
      {             
      Centralp= "Central";
      //Show if time zone is same as for broker server
      if(CentralDT <= BrokerDT+600 && CentralDT >= BrokerDT-600)
        {
        if(StringLen(Centralp) == 7)
          {
          Centralp= Centralp + "  (B)";
          }
        else
          {
          Centralp= StringSubstr(Centralp,0,StringLen(Centralp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(CentralDT <= Local_Time+600 && CentralDT >= Local_Time-600)
        {
        if(StringLen(Centralp) == 7)
          {
          Centralp= Centralp + "  (L)";
          }
        else
          {
          Centralp= StringSubstr(Centralp,0,StringLen(Centralp)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (CentralDT <= pvtDT+600 && CentralDT >= pvtDT-600))
        {
        if(StringLen(Centralp) == 7)
          {
          Centralp= Centralp + "  (P)";
          }
        else
          {
          Centralp= StringSubstr(Centralp,0,StringLen(Centralp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(CentralDT) != 0 && TimeDayOfWeek(CentralDT) != 6
   	 && TimeHour(CentralDT) >= LocalOpenHour && TimeHour(CentralDT) < LocalCloseHour)
   	  {
  	     ObjectSetText( "z[CP Time] Centralt", Centrals, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Centrall", Centralp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
  	     ObjectSetText( "z[CP Time] Centralt", Centrals, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Centrall", Centralp, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Mexico == 1)
      {
      Mexicop= "Mexico";
      //Show if time zone is same as for broker server
      if(MexicoDT <= BrokerDT+600 && MexicoDT >= BrokerDT-600)
        {
        if(StringLen(Mexicop) == 6)
          {
          Mexicop= Mexicop + "  (B)";
          }
        else
          {
          Mexicop= StringSubstr(Mexicop,0,StringLen(Mexicop)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(MexicoDT <= Local_Time+600 && MexicoDT >= Local_Time-600)
        {
        if(StringLen(Mexicop) == 6)
          {
          Mexicop= Mexicop + "  (L)";
          }
        else
          {
          Mexicop= StringSubstr(Mexicop,0,StringLen(Mexicop)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (MexicoDT <= pvtDT+600 && MexicoDT >= pvtDT-600))
        {
        if(StringLen(Mexicop) == 6)
          {
          Mexicop= Mexicop + "  (P)";
          }
        else
          {
          Mexicop= StringSubstr(Mexicop,0,StringLen(Mexicop)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(MexicoDT) != 0 && TimeDayOfWeek(MexicoDT) != 6
   	  && TimeHour(MexicoDT) >= LocalOpenHour && TimeHour(MexicoDT) < LocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Mexicot", Mexicos, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Mexicol", Mexicop, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Mexicot", Mexicos, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Mexicol", Mexicop, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Mountain == 1)
      {
      Mountainp= "Mountain";
      //Show if time zone is same as for broker server
      if(MountainDT <= BrokerDT+600 && MountainDT >= BrokerDT-600)
        {
        if(StringLen(Mountainp) == 8)
          {
          Mountainp= Mountainp + "  (B)";
          }
        else
          {
          Mountainp= StringSubstr(Mountainp,0,StringLen(Mountainp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(MountainDT <= Local_Time+600 && MountainDT >= Local_Time-600)
        {
        if(StringLen(Mountainp) == 8)
          {
          Mountainp= Mountainp + "  (L)";
          }
        else
          {
          Mountainp= StringSubstr(Mountainp,0,StringLen(Mountainp)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (MountainDT <= pvtDT+600 && MountainDT >= pvtDT-600))
        {
        if(StringLen(Mountainp) == 8)
          {
          Mountainp= Mountainp + "  (P)";
          }
        else
          {
          Mountainp= StringSubstr(Mountainp,0,StringLen(Mountainp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(MountainDT) != 0 && TimeDayOfWeek(MountainDT) != 6
   	  && TimeHour(MountainDT) >= LocalOpenHour && TimeHour(MountainDT) < LocalCloseHour)
        {
  	     ObjectSetText( "z[CP Time] Mountaint", Mountains, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Mountainl", Mountainp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
   	  {
   	  ObjectSetText( "z[CP Time] Mountaint", Mountains, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Mountainl", Mountainp, TimezoneFontSize, FontName, Location_MktClosed );
   	  }
      }
    if(Pacific == 1)
      {
      Pacificp= "Pacific";
      //Show if time zone is same as for broker server
      if(PacificDT <= BrokerDT+600 && PacificDT >= BrokerDT-600)
        {
        if(StringLen(Pacificp) == 7)
          {
          Pacificp= Pacificp + "  (B)";
          }
        else
          {
          Pacificp= StringSubstr(Pacificp,0,StringLen(Pacificp)-1) + ",B)";
          }
        }
      //Show if time zone is same as local time
      if(PacificDT <= Local_Time+600 && PacificDT >= Local_Time-600)
        {
        if(StringLen(Pacificp) == 7)
          {
          Pacificp= Pacificp + "  (L)";
          }
        else
          {
          Pacificp= StringSubstr(Pacificp,0,StringLen(Pacificp)-1) + ",L)";
          }
        }
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (PacificDT <= pvtDT+600 && PacificDT >= pvtDT-600))
        {
        if(StringLen(Pacificp) == 7)
          {
          Pacificp= Pacificp + "  (P)";
          }
        else
          {
          Pacificp= StringSubstr(Pacificp,0,StringLen(Pacificp)-1) + ",P)";
          }
        }
   	if(TimeDayOfWeek(PacificDT) != 0 && TimeDayOfWeek(PacificDT) != 6
   	  && TimeHour(PacificDT) >= LocalOpenHour && TimeHour(PacificDT) < LocalCloseHour)
   	  {
   	  ObjectSetText( "z[CP Time] Pacifict", Pacifics, ClockFontSize, FontName, Clock_MktOpen );
   	  ObjectSetText( "z[CP Time] Pacificl", Pacificp, TimezoneFontSize, FontName, Location_MktOpen );
   	  }
   	else
        {
    	  ObjectSetText( "z[CP Time] Pacifict", Pacifics, ClockFontSize, FontName, Clock_MktClosed );
   	  ObjectSetText( "z[CP Time] Pacificl", Pacificp, TimezoneFontSize, FontName, Location_MktClosed );
        }
      }
    if(Local == 1)
      {
      Localp= "Local";
      //Show if time zone is same as for broker server
      if(Local_Time == BrokerDT)
        {
        Localp= "Local  (B)";
        }
      //Show time zone is same as GMT
      if(Local_Time == UTC)
        {
        if(StringLen(Localp) == 5)
          {
          Localp= Localp + "  (G)";
          }
        else
          {
          Localp= StringSubstr(Localp,0,StringLen(Localp)-1) + ",G)";
          }
        }                
      //Show if time zone is same as for pivots
      if(Displaying_Pivots && (Local_Time <= pvtDT+600 && Local_Time >= pvtDT-600))
        {
        if(StringLen(Localp) == 5)
          {
          Localp= Localp + "  (P)";
          }
        else
          {
          Localp= StringSubstr(Localp,0,StringLen(Localp)-1) + ",P)";
          }
        }
      ObjectSetText( "z[CP Time] Localt", Locals, ClockFontSize, FontName,Clock_MktClosed );
      ObjectSetText( "z[CP Time] Locall", Localp, TimezoneFontSize, FontName, Location_MktClosed );
      }
    }//End Clock
  
  //Create Logo
  if(__Show_Logo_in_Panel)
    {
    //Logo letters
    string Lo1= "H";
    string Lo2= " I";
    string Lo3= " L";
    string Lo4= " Y";
    string Lo5= " A";
    int ch= 11;
    int n= 3;
    string tx= "Myriad Web Bold";
    MakeLabel( item15, 149,6+n);
    MakeLabel( item16, 148,19+n);
    MakeLabel( item17, 148,32+n);
    MakeLabel( item18, 148,45+n);
    MakeLabel( item19, 148,58+n);
    ObjectSetText(item15, Lo1, ch, tx,Logo);
    ObjectSetText(item16, Lo2, ch, tx,Logo);
    ObjectSetText(item17, Lo3, ch, tx,Logo);
    ObjectSetText(item18, Lo4, ch, tx,Logo);
    ObjectSetText(item19, Lo5, ch, tx,Logo);
    }//End Logo
    }//End Access Panel

  //End of program computations--------------------------------------------------------------- 
  return(0);
  }

//+-------------------------------------------------------------------------------------------+
//| Indicator Subroutine To Compute Average Ranges                                            |
//+-------------------------------------------------------------------------------------------+
void Ranges (int period)
  {
  int lx = 0;
  int lxx = 0;
  ARg = 0;

  //Add ranges over period.  Count number of Sundays and exclude Sunday ranges.
  for(i=1; i<=period; i++)
    {
    if (TimeDayOfWeek(iTime(NULL,PERIOD_D1,i))!=0) {
    ARg = ARg + iHigh(NULL,PERIOD_D1,i)- iLow(NULL,PERIOD_D1,i);}
    else {lx=lx+1;}
    }

  //For number of Sundays, add additional days of range
  for(ii=i; ii<=i-1+lx; ii++)
    {
    if (TimeDayOfWeek(iTime(NULL,PERIOD_D1,ii))!=0)
      {
      ARg = ARg + iHigh(NULL,PERIOD_D1,ii)- iLow(NULL,PERIOD_D1,ii);
      }
    else {lxx=lxx+1;}
    }

  //If a Sunday reduced added days above, add additional day of range
  for(iii=ii; iii<=ii-1+lxx; iii++)
    {
    ARg = ARg + iHigh(NULL,PERIOD_D1,iii)- iLow(NULL,PERIOD_D1,iii);
    }

  return;
  }

//+-------------------------------------------------------------------------------------------+
//| Subroutine To name and draw Daily Pivot and Range HL lines and line labels                |
//+-------------------------------------------------------------------------------------------+
void DrawLines(string text, int Line_Selection_Number, double Level, color Clr,
  int style, int thickness)
  {
  //Lines======================================================================================
  if(Line_Selection_Number < 1 || Line_Selection_Number > 4) {Line_Selection_Number = 2;}

  //Name lines: lines with "a" make them subordinate to lines with "b" or "c".  Lines with
  //"b" are subordinate to lines with "c".  Lines with "c" always on top.
  if(StringSubstr(text, 0, 2) == "LV") //Levels lines
    {
    line = "a[CP Draw] " + text + " Line " + DoubleToStr(Level,Digits);
    }  
  else if(StringSubstr(text, 0, 1) == "R")//Range lines
    {
    line = "c[CP Draw] " +text + " Line " + DoubleToStr(Level,Digits);
    }
  else //all fibo and pivots lines
    {
    line = "b[CP Draw] " + text + " Line " + DoubleToStr(Level,Digits);
    }

  //Define variables
  a = style; b = thickness; c =1; if (a==0)c=b;
  int Shift;

  //Where to Start lines
  //start chart left
  if(Line_Selection_Number == 1) 
    {
    startline = WindowFirstVisibleBar();
    }
  //start at day separator
  else if(Line_Selection_Number == 2 || Line_Selection_Number == 3)
    {
    Shift = 0; if(DayOfWeek()==0) {Shift = 1;}
    startline = iTime(NULL, PERIOD_D1, Shift);    
    }
  else if(Line_Selection_Number == 4)
    {
    if(__Use_Tz_Filter) {startline= iTime(NULL, PERIOD_H1,idxfirstbaryesterday);}
    else {startline = iTime(NULL, PERIOD_D1, 1);}
    }

  //Where to Stop Lines
  //stop at chart right border
  if(Line_Selection_Number == 1)
    {stopline = iTime(NULL,PERIOD_D1,0)+18748800; R2 = true;}
  //stop at end of current session
  else {if (Line_Selection_Number == 2 || Line_Selection_Number == 4)
    {stopline = iTime(NULL,PERIOD_D1,0)+86400; R2 = false;}
  //stop some TFs right of current bar based on chart scale
  else if (Line_Selection_Number == 3)
    {stopline = startline+ T4; R2 = false;}}

  //Draw lines
  ObjectCreate(line, OBJ_TREND, 0, startline, Level, stopline, Level);
  ObjectSet(line, OBJPROP_STYLE, a);
  ObjectSet(line, OBJPROP_COLOR, Clr);
  ObjectSet(line, OBJPROP_WIDTH, c);
  fib = false; if(StringSubstr(text,0,1) == "G")
    {
    fib = true;
    if(Subordinate_Fibos) ObjectSet(line,OBJPROP_BACK,true);
    else ObjectSet(line, OBJPROP_BACK, false);
    }
  else
    {
    if((Subordinate_Lines) || (StringSubstr(text,0,2)=="LV"))ObjectSet(line,OBJPROP_BACK,true);
    else ObjectSet(line, OBJPROP_BACK, false);
    }
  ObjectSet(line, OBJPROP_RAY, R2);

  //Labels=====================================================================================
  //Exit if label not to be shown
  if (StringSubstr(text, 0, 2) == "LV") {return;}
  else {if ((!Pivot_PVT_Label_On) && (StringSubstr(text, 0, 2) == "PV")) {return;}
  else {if ((!Pivot_SRM_Labels_On) && ((StringSubstr(text, 1, 1) == "R") ||
       (StringSubstr(text, 1, 1) == "S") || (StringSubstr(text, 0, 1) == "M"))) {return;}
  else {if ((!Range_Labels_On) && ((StringSubstr(text, 0, 2) == "RD")
       || (StringSubstr(text, 0, 2) == "RW"))) {return;}
  else
    {
    //Name label
    if(StringSubstr(text, 0, 2) == "LV") //Levels lines
      {
      label = "a[CP Draw] " + text + " Label " + DoubleToStr(Level,Digits);
      }
    else if(StringSubstr(text, 0, 1) == "R")//Range lines
      {
      label = "c[CP Draw] " +text + " Label " + DoubleToStr(Level,Digits);
      }
    else //all pivots lines
      {
      label = "b[CP Draw] " + text + " Label " + DoubleToStr(Level,Digits);
      }
      
    //Fibos: Remove first character in prefix
    if(StringSubstr(text, 0, 1) == "G")
      {
      text = StringSubstr(text, 1);
      }
      
    //Main Pivot: Remove trailing number in prefix
    if(StringSubstr(text, 0, 1) == "P")
      {
      text = StringSubstr(text, 0, 3);   
      }

    //Pivot Labels: adjust for inclusion of "type" tags
    if((StringSubstr(text, 0, 1) == "D") || (StringSubstr(text, 0, 1) == "F") ||
      (StringSubstr(text, 0, 1) == "M") || (StringSubstr(text, 0, 1) == "P"))
      {
      //Do this if PivotsTZ are displayed
      if(__PivotsTz_On)
        {
        //Append "Preferred Pivots" tag
        if(____Use_Preferred_Offset || ____Alternative_GMT_Offset == Berlin_GMT_Offset)
          {
          text = "   " + text + "^";
          }
        //Append less than "Preferred Pivots" tag
        else if(____Alternative_GMT_Offset < Berlin_GMT_Offset) {text = "  " + text + "<";}
        //Append greater than "Preferred Pivots" tag
        else if(____Alternative_GMT_Offset > Berlin_GMT_Offset) {text = "  " + text + ">";}
        }
      //Otherwise Broker pivots are displayed and append no tag
      else {text = "   " + text + "  ";}
      }

    //Day Range labels
    else if(StringSubstr(text, 0, 2) == "RD")
      {
      if(__PivotsTz_On)
        {
        text = "   " + text + "  ";
        }
      else
        {
        text = "  " + text + " ";
        }
      }

    //Week Range labels
    else if(StringSubstr(text, 0, 2) == "RW")
      {
      if(__PivotsTz_On)
        {
        text = "   " + text + "  ";
        }
      else
        {
        text = "  " + text + " ";
        }
      }

    //Where to put labels
    if (Line_Selection_Number == 1)
      {
      //start at mid-chart
      spc = ""; //00
      startlabel = Time[WindowFirstVisibleBar()/2];
      }
    else {if (Line_Selection_Number == 2)
      {
      Shift = 0; if(DayOfWeek()==0) {Shift = 1;}
      if(Time[WindowFirstVisibleBar()] < iTime(NULL, PERIOD_D1, 0))
        {
        //start at day separator if it is in chart window
        spc="        "; //08
        startlabel= iTime(NULL, PERIOD_D1, Shift);
        }
      else
        {
        //start at mid-chart
        spc = ""; //00
        startlabel = Time[WindowFirstVisibleBar()/2];
        }
      }
    else {if (Line_Selection_Number == 3)
      {
      //start at current candle
      spc="         "; //09
      startlabel = iTime(NULL, PERIOD_D1, 0);
      } }}

    //Draw labels
    ObjectCreate(label, OBJ_TEXT, 0, startlabel, Level);
    ObjectSetText(label, spc + text, FontSize, FontStyle, Labels_Color);
    if(fib)
      {
      if(Subordinate_Fibos) ObjectSet(label,OBJPROP_BACK,true);
      else ObjectSet(label, OBJPROP_BACK, false);
      }
    else
      {
      if(Subordinate_Labels) ObjectSet(label,OBJPROP_BACK,true);
      else ObjectSet(label, OBJPROP_BACK, false);
      }
    } }}}
  }

//+-------------------------------------------------------------------------------------------+
//| Subroutine to Create Today and Tomorrow Separators                                        |
//+-------------------------------------------------------------------------------------------+
void CurrentSeparators(string text, color Clr, int style, int thickness)
  {
  a = style;
  b = thickness;
  c =1; if (a==0)c=b;
  string dt;
  string vline;

  //Define datetime for start of current session vline separator
  if(text == "Today")
    {
    dt= IntegerToString (TimeYear(iTime(NULL,0,0)))+ "." +
        IntegerToString  (TimeMonth(iTime(NULL,0,0)))+ "." +
        IntegerToString (TimeDay(iTime(NULL,PERIOD_D1,0)))+ "." +
        IntegerToString (0) + ":" + "0";
    T3= StrToTime(dt);
    vline  = "[CP Draw] Current Session Line";
    }

  //Define datetime for end of current session vline separator
  else
    {
    dt= IntegerToString (TimeYear(iTime(NULL,0,0)))+ "." +
        IntegerToString (TimeMonth(iTime(NULL,0,0)))+ "." +
        IntegerToString (TimeDay(iTime(NULL,PERIOD_D1,0)))+ "." +
        IntegerToString (24) + ":" + "60";
    T3 = StrToTime(dt)+60;
    vline  = "[CP Draw] Tomorrow Session Line";
    }

  //Draw vLines
  if(!Separators_Thru_SubWindows) {ObjectCreate(vline, OBJ_TREND, 0, T3, 0, T3, 100);}
  else {ObjectCreate(vline, OBJ_VLINE, 0, T3, 0);}
  ObjectSet(vline, OBJPROP_STYLE, a);
  ObjectSet(vline, OBJPROP_WIDTH, c);
  ObjectSet(vline, OBJPROP_COLOR, Clr);
  ObjectSet(vline, OBJPROP_BACK, true);
  }

//+-------------------------------------------------------------------------------------------+
//| Subroutine to Create Prior Sessions Separators                                            |
//+-------------------------------------------------------------------------------------------+
void PriorSeparators(int si, color Clr, int style, int thickness)
  {
  a = style;
  b = thickness;
  c =1; if (a==0)c=b;
  string vline;

  vline  = "[CP Draw] Prior Session Line " + IntegerToString (si-1);

  //Draw Separator
  if(!Separators_Thru_SubWindows)
    {ObjectCreate(vline, OBJ_TREND, 0, Time[i], 0, Time[i], 100);}
  else {ObjectCreate(vline, OBJ_VLINE, 0, Time[i], 0);}
  ObjectSet(vline, OBJPROP_STYLE, a);
  ObjectSet(vline, OBJPROP_WIDTH, c);
  ObjectSet(vline, OBJPROP_COLOR, Clr);
  ObjectSet(vline, OBJPROP_BACK, true);
  }

//+-------------------------------------------------------------------------------------------+
//| Subroutine to Create Market Open Lines And Labels For Current Session                     |
//+-------------------------------------------------------------------------------------------+  
void OpenToday(string text,datetime time1,color Clr,int style,int thickness,double Level)
  {
  a = style;
  b = thickness;
  c =1; if (a==0)c=b;
  string dt;
  string vline;
  string vlabel;

  vline  = "[CP Draw]  " + StringTrimLeft(text) + " Current Session Line";
  vlabel = "[CP Draw]  " + StringTrimLeft(text) + " Current Session Label";
  datetime time2 = time1;
  //if(time2<0) {time2 = time2 + 24;}
  if(time2<0) {time2 = time2 +StrToTime("24");}
  datetime time3 = datetime (MathFloor(time2));
  dt= IntegerToString (TimeYear(iTime(NULL,0,0)))+ "." +
      IntegerToString (TimeMonth(iTime(NULL,0,0)))+ "." +
      IntegerToString (TimeDay(iTime(NULL,PERIOD_D1,0)))+ "." +
      IntegerToString (time3)+":"+"0";
  time4 = StrToTime(dt);
  if(time2 != time3) {time4 = time4 + 1800;}  //add half hour

  //Draw vLines
  if(!vLines_Thru_SubWindows) {ObjectCreate(vline, OBJ_TREND, 0, time4, 0, time4, 100);}
  else {ObjectCreate(vline, OBJ_VLINE, 0, time4, 0);}
  ObjectSet(vline, OBJPROP_STYLE, a);
  ObjectSet(vline, OBJPROP_WIDTH, c);
  ObjectSet(vline, OBJPROP_COLOR, Clr);
  ObjectSet(vline, OBJPROP_BACK, true);

  //Draw labels
  if(Sbow_vLabels)
    {                                         
    ObjectCreate (vlabel, OBJ_TEXT, 0, time4, Level);
    ObjectSetText(vlabel, text, vFontSize, vFontStyle, vLabels_Color);
    ObjectSet(vlabel, OBJPROP_BACK, true);  
    }
  }

//+-------------------------------------------------------------------------------------------+
//| Subroutine to Create Market Open Lines And Labels For Prior Sessions                      |
//+-------------------------------------------------------------------------------------------+
void OpenPrior(int mi, string text, color Clr, int style, int thickness, double Level)
  {
  a = style;
  b = thickness;
  c =1; if (a==0)c=b;

  string vline  = "[CP Draw]  " + StringTrimLeft(text) +
                  " Prior Session Line " + IntegerToString (mi-1);
  string vlabel = "[CP Draw]  " + StringTrimLeft(text) +
                  " Prior Session Label " + IntegerToString (mi-1);

  //Draw vLine
  if(!vLines_Thru_SubWindows) {ObjectCreate(vline, OBJ_TREND, 0, Time[mi], 0, Time[mi], 100);}
  else {ObjectCreate(vline, OBJ_VLINE, 0, Time[mi], 0);}
  ObjectSet(vline, OBJPROP_STYLE, a);
  ObjectSet(vline, OBJPROP_WIDTH, c);
  ObjectSet(vline, OBJPROP_COLOR, Clr);
  ObjectSet(vline, OBJPROP_BACK, true);

  //Draw labels
  if(Sbow_vLabels)
    {                                               
    ObjectCreate (vlabel, OBJ_TEXT, 0, Time[mi], Level);
    ObjectSetText(vlabel, text, vFontSize, vFontStyle, vLabels_Color);
    ObjectSet(vlabel, OBJPROP_BACK, true);
    }
  }

//+-------------------------------------------------------------------------------------------+
//| TzShift sub-routine computes index of first/last bars of yesterday & first bar  of today  |
//+-------------------------------------------------------------------------------------------+
void TzShift(int &ltzdiff,int &lidxfirstbartoday,int &lidxfirstbaryesterday,int &lidxlastbaryesterday)            
  {
  tzdiffsec            = ltzdiff*3600;
  barsperday           = (1440/PERIOD_H1);
  dayofweektoday       = TimeDayOfWeek(iTime(NULL, PERIOD_H1, 0) - tzdiffsec);
  dayofweektofind      = -1;
  datetime timet, timey, timey2;

  //Due to gaps in the data, and shift of time around weekends (due to time zone)
  //it is not as easy as to just look back for a bar with 00:00 time
  lidxfirstbartoday= 0; lidxfirstbaryesterday= 0;  lidxlastbaryesterday= 0;
  switch (dayofweektoday) {
     case 0: dayofweektofind = 5; break; // Sun (Sunday considered as short trading day)
     default: dayofweektofind = dayofweektoday -1; break;}

  //Search backwards for the last occurence of a "today's first bar"
  for(i=1; i<=barsperday + 1; i++){
    timet = iTime(NULL, PERIOD_H1, i) - tzdiffsec;
      if(TimeDayOfWeek(timet) != dayofweektoday) {lidxfirstbartoday = i-1;break;}}
  for(j= 0; j<=2*barsperday + 1; j++) {
    timey = iTime(NULL, PERIOD_H1, i+j) - tzdiffsec;
    if(TimeDayOfWeek(timey) == dayofweektofind) {lidxlastbaryesterday = i+j; break;}}
  for(j= 1; j<=barsperday; j++) {
    timey2 = iTime(NULL, PERIOD_H1, lidxlastbaryesterday+j) - tzdiffsec;
    if(TimeDayOfWeek(timey2) != dayofweektofind)
      {lidxfirstbaryesterday = lidxlastbaryesterday+j-1; break;}}

//Start - Added by CaveMan to cater for missing/partial previous day's data
  //Search for Friday's data range if yesterday is a Sunday
  if(dayofweektofind == 0)
    {
    //Search backwards for the last occurence of a "today's first bar"
    for(i=1; i<=barsperday + 1; i++){
       timet = iTime(NULL, PERIOD_H1, i) - tzdiffsec;
       if(TimeDayOfWeek(timet) != dayofweektoday) {lidxfirstbartoday = i-1;break;}}
    for(j= 0; j<=2*barsperday + 1; j++) {
       timey = iTime(NULL, PERIOD_H1, i+j) - tzdiffsec;
       if(TimeDayOfWeek(timey) == 5) {lidxlastbaryesterday = i+j; break;}}
    for(j= 1; j<=barsperday; j++) {
       timey2 = iTime(NULL, PERIOD_H1, lidxlastbaryesterday+j) - tzdiffsec;
       if(TimeDayOfWeek(timey2) != 5){lidxfirstbaryesterday = lidxlastbaryesterday+j-1;break;}}
    }

  //This section takes care of the Christmas and New Year Day problem where there is a day
  //of partial data on the eve of these holidays followed by an entire day without any data
  //at all. The workaround to handle this on market open after the holiday is to use data
  //from the day before the eve of the holiday right up to the end of the eve of the holiday
  //for pivot computation. E.g. On the 26 December market opens after Christmas. Use full
  //day data of 23rd plus partial data of 24th Dec to compute the pivots. Same applies to
  //New Year Day.
  int YesterdayBarsTotal = lidxfirstbaryesterday - lidxlastbaryesterday;
  if(YesterdayBarsTotal == 0)
    {
    if (dayofweektofind == 0) {dayofweektofind = 4;}
    else if (dayofweektofind == 1) {dayofweektofind = 5;}
    else {dayofweektofind = dayofweektofind - 1;}

    //Repeat this search with the new dayofweektofind information
    for(i=1; i<=barsperday + 1; i++) {
       timet = iTime(NULL, PERIOD_H1, i) - tzdiffsec;
       if(TimeDayOfWeek(timet) != dayofweektoday) {lidxfirstbartoday = i-1;break;}}
    for(j= 0; j<=2*barsperday + 1; j++) {
       timey = iTime(NULL, PERIOD_H1, i+j) - tzdiffsec;
       if(TimeDayOfWeek(timey) == dayofweektofind) {lidxlastbaryesterday = i+j; break;}}
    for(j= 1; j<=3*barsperday; j++) {
       timey2 = iTime(NULL, PERIOD_H1, lidxlastbaryesterday+j) - tzdiffsec;
       if(TimeDayOfWeek(timey2) != dayofweektofind)
         {lidxfirstbaryesterday = lidxlastbaryesterday+j-1;break;}}
    YesterdayBarsTotal = lidxfirstbaryesterday - lidxlastbaryesterday;
    }
  //Standard codes to handle days of partial data (including Fridays and Sundays)
  //If one hour bars < 24, use additional data from one more day back
  if(YesterdayBarsTotal < 23)
    {
    //for Sunday, search Thursday and found Thursday partial data, then search Wednesday.
    if (dayofweektoday == 0 && dayofweektofind == 4) {dayofweektofind = 3;}
    //for Monday, Friday no data then include Thursday and Sunday data.
    else if (dayofweektoday == 1 && dayofweektofind == 4) {dayofweektofind = 4;}
    else if (dayofweektofind == 0 || dayofweektofind == 1) { dayofweektofind = 5;}
    else {dayofweektofind = dayofweektofind - 1;}
    //Search backwards for the last occurence of a "today's first bar"
    for(i=1; i<=barsperday + 1; i++) {
      timet = iTime(NULL, PERIOD_H1, i) - tzdiffsec;
      if(TimeDayOfWeek(timet) != dayofweektoday) {lidxfirstbartoday = i-1;break;}}
    for(j= 0; j<=3*barsperday + 1; j++) { // Need to increase another 24 hours to search
      timey = iTime(NULL, PERIOD_H1, i+j) - tzdiffsec;
      if(TimeDayOfWeek(timey) == dayofweektofind) {lidxlastbaryesterday = i+j; break;}}
    for(j= 1; j<=4*barsperday; j++) {
      timey2 = iTime(NULL, PERIOD_H1, lidxlastbaryesterday+j) - tzdiffsec;
      if(TimeDayOfWeek(timey2) != dayofweektofind)
        {lidxfirstbaryesterday = lidxlastbaryesterday+j-1;break;}}
    //This small section handles a very unique combination of events that coincide during the
    //short opening trading hours of the Sunday following Christmas Day and New Year Day if
    //both of these holidays happen to fall on a Thursday.  This occured on the short Sunday
    //trading hours before Monday kicks in. For those few hours, pivot used on Friday are
    //extended into Sunday. These pivot levels are calculated using full Thursday's data. In
    //this unique situation, Thursday was New Year Day (major public holiday)with no data at
    //all. This will cause TzPivot to malfunction in similar situation in the future. As a
    //workaround, for those short few hours of Sunday, if a similar situation should occur,
    //partial data of Wednesday and Friday will be used for pivot computation.
    YesterdayBarsTotal = lidxfirstbaryesterday - lidxlastbaryesterday;
    if(YesterdayBarsTotal == 0)
      {
      if(dayofweektofind == 1) {dayofweektofind = 5;}
      else{dayofweektofind = dayofweektofind - 1;}
      //Repeat this search with the new dayofweektofind information
      for(i=1; i<=barsperday + 1; i++) {
        timet = iTime(NULL, PERIOD_H1, i) - tzdiffsec;
        if(TimeDayOfWeek(timet) != dayofweektoday) {lidxfirstbartoday = i-1;break;}}
      for(j= 0; j<=2*barsperday + 1; j++) {
        timey = iTime(NULL, PERIOD_H1, i+j) - tzdiffsec;
        if(TimeDayOfWeek(timey) == dayofweektofind) {lidxlastbaryesterday = i+j; break;}}
      for(j= 1; j<=3*barsperday; j++) {
        timey2 = iTime(NULL, PERIOD_H1, lidxlastbaryesterday+j) - tzdiffsec;
        if(TimeDayOfWeek(timey2) != dayofweektofind)
          {lidxfirstbaryesterday = lidxlastbaryesterday+j-1;break;}}
      lidxlastbaryesterday = lidxfirstbartoday + 1;
         }
    //Include partial day's data and combine with previous day's data for pivot computation.
    //Do not include for Sundays as Sunday short trading hours uses Friday's pivots that are
    //computed from full Thursday's data.  This is more for handling of holidays including
    //Christmas and New Year Day.
    if (dayofweektoday != 0) lidxlastbaryesterday = lidxfirstbartoday + 1;
    }
//End - Added by CaveMan to cater for missing/partial previous day's data
  }

//+-------------------------------------------------------------------------------------------+
//| Subroutine to make city and time labels                                                   |
//+-------------------------------------------------------------------------------------------+
void MakeLabel( string n, int xoff, int yoff )
  {
  if(ObjectFind(n) != 0)
    {
    ObjectCreate( n, OBJ_LABEL, 0, 0, 0 );
    ObjectSet( n, OBJPROP_CORNER, 0 );
    ObjectSet( n, OBJPROP_XDISTANCE, xoff );
    ObjectSet( n, OBJPROP_YDISTANCE, yoff );
    ObjectSet( n, OBJPROP_BACK, false );
    }
  else{ObjectMove(n, 0, xoff, yoff);}
  }

//+-------------------------------------------------------------------------------------------+
//| Subroutine to convert time to a string for time labels                                    |
//+-------------------------------------------------------------------------------------------+
string TimeToStrings( datetime when )
   {
   hour = TimeHour( when );
   if ( !Show_AMPM_Time )
      {
      timeStr = (TimeToStr( when, TIME_MINUTES));
      }

   // User wants 12HourTime format with "AM" or "PM".
   // FYI, if >12:00, subtract 12 hours in seconds which is 12*60*60=43200
   else
      {
      if ( hour > 12 || hour == 0) timeStr = TimeToStr( (when - 43200), TIME_MINUTES);
      else timeStr = TimeToStr( when, TIME_MINUTES);
      if ( hour >= 12) timeStr = StringConcatenate(timeStr, " PM");
      else timeStr = StringConcatenate(timeStr, " AM");
      }
   return (timeStr);
   }

//+-------------------------------------------------------------------------------------------+
//| Subroutine to retrieve date and time from time array                                      |
//+-------------------------------------------------------------------------------------------+
datetime TimeArrayToTime(int& lLocalTimeArray[])
  {
  nYear=lLocalTimeArray[0]&0x0000FFFF;
  nMonth=lLocalTimeArray[0]>>16;
  nDay=lLocalTimeArray[1]>>16;
  nHour=lLocalTimeArray[2]&0x0000FFFF;
  nMin=lLocalTimeArray[2]>>16;
  nSec=lLocalTimeArray[3]&0x0000FFFF;
  nMilliSec=lLocalTimeArray[3]>>16;
  LocalTimeS = FormatDateTime(nYear,nMonth,nDay,nHour,nMin,nSec);
  Local_Time = StrToTime( LocalTimeS );
  return(Local_Time);
  }

//+-------------------------------------------------------------------------------------------+
//| Subroutine to format time labels                                                          |
//+-------------------------------------------------------------------------------------------+
string FormatDateTime(int lnYear,int lnMonth,int lnDay,int lnHour,int lnMin,int lnSec)
  {
  sMonth= IntegerToString (100) + IntegerToString (lnMonth);
  sMonth= StringSubstr (sMonth,1);
  sDay= IntegerToString (100) + IntegerToString (lnDay);
  sDay= StringSubstr (sDay,1);
  sHour= IntegerToString (100) + IntegerToString (lnHour);
  sHour= StringSubstr (sHour,1);
  sMin= IntegerToString (100) + IntegerToString (lnMin);
  sMin= StringSubstr (sMin,1);
  sSec= IntegerToString (100) + IntegerToString (lnSec); 
  sSec= StringSubstr (sSec,1);
  return(StringConcatenate (lnYear,".",sMonth,".",sDay," ",sHour,":",sMin,":",sSec));
  }
  
//+-------------------------------------------------------------------------------------------+
//| Subroutine to get time zone information for each city                                     |
//+-------------------------------------------------------------------------------------------+
void GetTimeZoneInfo(int& lAucklandTZInfoArray[], int& lSydneyTZInfoArray[],
   int& lTokyoTZInfoArray[], int& lChinaTZInfoArray[], int& lJakartaTZInfoArray[],
   int& lIndiaTZInfoArray[], int& lDubaiTZInfoArray[], int& lMoscowTZInfoArray[],
   int& lIsraelTZInfoArray[], int& lHelsinkiTZInfoArray[], int& lBerlinTZInfoArray[],
   int& lLondonTZInfoArray[], int& lBrazilTZInfoArray[], int& lNewYorkTZInfoArray[],
   int& lCentralTZInfoArray[], int& lMexicoTZInfoArray[], int& lMountainTZInfoArray[],
   int& lPacificTZInfoArray[])

   {
   lAucklandTZInfoArray[0]  = -720;
   lAucklandTZInfoArray[17] = 262144; //4<<16 == 262144  April
   lAucklandTZInfoArray[18] = 65536;  //1<<16 == 65536   l1st Sunday
   lAucklandTZInfoArray[19] = 3;
   lAucklandTZInfoArray[20] = 0;
   lAucklandTZInfoArray[21] = 0;
   lAucklandTZInfoArray[38] = 589824; //9<<16 == 589824  September
   lAucklandTZInfoArray[39] = 327680; //5<<16 == 327680  5th/Last Sunday
   lAucklandTZInfoArray[40] = 2;
   lAucklandTZInfoArray[41] = 0;
   lAucklandTZInfoArray[42] = -60;

   lSydneyTZInfoArray[0]  = -600;
   lSydneyTZInfoArray[17] = 262144; //4<<16 == 262144  April
   lSydneyTZInfoArray[18] = 65536;  //1<<16 == 65536   1st Sunday
   lSydneyTZInfoArray[19] = 3;
   lSydneyTZInfoArray[20] = 0;
   lSydneyTZInfoArray[21] = 0;
   lSydneyTZInfoArray[38] = 655360; //10<<16 == 655360  October
   lSydneyTZInfoArray[39] = 65536;  //1<<16 == 65536    1st Sunday
   lSydneyTZInfoArray[40] = 2;
   lSydneyTZInfoArray[41] = 0;
   lSydneyTZInfoArray[42] = -60;

   // FYI Tokyo = Seoul
   lTokyoTZInfoArray[0]  = -540;
   lTokyoTZInfoArray[17] = 0;
   lTokyoTZInfoArray[18] = 0;
   lTokyoTZInfoArray[19] = 0;
   lTokyoTZInfoArray[20] = 0;
   lTokyoTZInfoArray[21] = 0;
   lTokyoTZInfoArray[38] = 0;
   lTokyoTZInfoArray[39] = 0;
   lTokyoTZInfoArray[40] = 0;
   lTokyoTZInfoArray[41] = 0;
   lTokyoTZInfoArray[42] = 0;

   // FYI, Beijing = Perth, Singapore, Taipei, Hong Kong
   ArrayCopy(lChinaTZInfoArray, lTokyoTZInfoArray);
   lChinaTZInfoArray[0] = -480;

   // FYI, Jakarta = Bangkok
   ArrayCopy(lJakartaTZInfoArray, lTokyoTZInfoArray);
   lJakartaTZInfoArray[0] = -420;

   ArrayCopy(lIndiaTZInfoArray, lTokyoTZInfoArray);
   lIndiaTZInfoArray[0]   = -330;  // NOTE! Top of the hour is 30 min off most world timezones.

   ArrayCopy(lDubaiTZInfoArray, lTokyoTZInfoArray);
   lDubaiTZInfoArray[0]   = -240;

   lIsraelTZInfoArray[0]  = -120;
   lIsraelTZInfoArray[17] = 589824;  //9<<16 == 589824  September
   lIsraelTZInfoArray[18] = 131072;  //2<<16  = 131072
   lIsraelTZInfoArray[19] = 2;
   lIsraelTZInfoArray[20] = 0;
   lIsraelTZInfoArray[21] = 0;
   lIsraelTZInfoArray[38] = 196608; //3<<16 == 196608  March
   lIsraelTZInfoArray[39] = 327685; //5<<16  = 327680 AND "5" (*IF* Sunday is "0", is "5" Friday??)
   lIsraelTZInfoArray[40] = 2;
   lIsraelTZInfoArray[41] = 0;
   lIsraelTZInfoArray[42] = -60;

   ArrayCopy(lMoscowTZInfoArray, LondonTZInfoArray);
   lMoscowTZInfoArray[0]  = -180;
   lMoscowTZInfoArray[19] = 3;
   lMoscowTZInfoArray[40] = 2;

   // FYI, Helsinki = Athens
   ArrayCopy(lHelsinkiTZInfoArray, LondonTZInfoArray);
   lHelsinkiTZInfoArray[0]  = -120;
   lHelsinkiTZInfoArray[19] = 4;
   lHelsinkiTZInfoArray[40] = 3;

   lLondonTZInfoArray[0]  = 0;
   lLondonTZInfoArray[17] = 655360; //10<<16 == 655360  October
   lLondonTZInfoArray[18] = 327680; //5<<16 == 327680.  5th/Last Sunday.
   lLondonTZInfoArray[19] = 2;
   lLondonTZInfoArray[20] = 0;
   lLondonTZInfoArray[21] = 0;
   lLondonTZInfoArray[38] = 196608; //3<<16 == 196608  March
   lLondonTZInfoArray[39] = 327680; //5<<16 == 327680  5th/Last Sunday
   lLondonTZInfoArray[40] = 1;
   lLondonTZInfoArray[41] = 0;
   lLondonTZInfoArray[42] = -60;

   // FYI, Berlin = Belgrade, Brussels, Paris, Sarajevo
   ArrayCopy(lBerlinTZInfoArray, lLondonTZInfoArray);
   lBerlinTZInfoArray[0] = -60;

   // NOTE! Brazil's ST/DST is likely a hardcoded date which will need updating EVERY YEAR!
   lBrazilTZInfoArray[0]  = 180;
   lBrazilTZInfoArray[17] = 131072;   //2<<16  = 131072
   lBrazilTZInfoArray[18] = 196614;   //3<<16 == 196608 AND 6, so, Saturday?? or Mar 6?
   lBrazilTZInfoArray[19] = 3866647;
   lBrazilTZInfoArray[20] = 65470523;
   lBrazilTZInfoArray[21] = 0;
   lBrazilTZInfoArray[38] = 655360;   //10<<16 == 655360
   lBrazilTZInfoArray[39] = 196614;
   lBrazilTZInfoArray[40] = 3866647;
   lBrazilTZInfoArray[41] = 65470523;
   lBrazilTZInfoArray[42] = -60;

   lNewYorkTZInfoArray[0]  = 300;
   lNewYorkTZInfoArray[17] = 720896; //wYear = 0. wMonth = 11, and 11<<16 == 720896
   lNewYorkTZInfoArray[18] = 65536;  //wDOW = 0 = Sunday. nDay = 1 and 1<<16 == 65536
   lNewYorkTZInfoArray[19] = 2;
   lNewYorkTZInfoArray[20] = 0;
   lNewYorkTZInfoArray[21] = 0;
   lNewYorkTZInfoArray[38] = 196608; //3<<16 == 196608  March
   lNewYorkTZInfoArray[39] = 131072; //2<<16 == 131072  2nd Sunday
   lNewYorkTZInfoArray[40] = 2;
   lNewYorkTZInfoArray[41] = 0;
   lNewYorkTZInfoArray[42] = -60;

   //ArrayCopy(BuenasAriesTZInfoArray, BuenasAriesTZInfoArray);
   //BuenasAriesTZInfoArray[0] = 180;

   ArrayCopy(lCentralTZInfoArray, NewYorkTZInfoArray);
   lCentralTZInfoArray[0] = 360;

   lMexicoTZInfoArray[0]  = 360;
   lMexicoTZInfoArray[17] = 655360; //10<<16 == 655360  October
   lMexicoTZInfoArray[18] = 327680; //5<<16 == 327680  5th/Last Sunday
   lMexicoTZInfoArray[19] = 2;
   lMexicoTZInfoArray[20] = 0;
   lMexicoTZInfoArray[21] = 0;
   lMexicoTZInfoArray[38] = 262144; //4<<16 == 262144  April
   lMexicoTZInfoArray[39] = 65536;  //1<<16 == 65536   l1st Sunday
   lMexicoTZInfoArray[40] = 2;
   lMexicoTZInfoArray[41] = 0;
   lMexicoTZInfoArray[42] = -60;

   ArrayCopy(lMountainTZInfoArray, NewYorkTZInfoArray);
   lMountainTZInfoArray[0] = 420;

   ArrayCopy(lPacificTZInfoArray, NewYorkTZInfoArray);
   lPacificTZInfoArray[0] = 480;
   }

//+-------------------------------------------------------------------------------------------+
//| Subroutine:  Set up to get the chart scale number                                         |
//+-------------------------------------------------------------------------------------------+
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
  {
  Chart_Scale = ChartScaleGet();
  init();
  }

//+-------------------------------------------------------------------------------------------+
//| Subroutine:  Get the chart scale number                                                   |
//+-------------------------------------------------------------------------------------------+
int ChartScaleGet()
  {
  long result = -1;
  ChartGetInteger(0,CHART_SCALE,0,result);
  return((int)result);
  }

//+-------------------------------------------------------------------------------------------+
//| Indicator End                                                                             |
//+-------------------------------------------------------------------------------------------+

