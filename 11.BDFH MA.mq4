
// +----------------------------------------------------------------------------------------+ //
// |    .-._______                           FAIQHILYA                        _______.-.    | //
// |---( )_)______)                 Knowledge of the ancients                (______(_( )---| //
// |  (    ()___)                              \¦/                             (___()    )  | //
// |       ()__)                              (o o)                             (__()       | //
// |--(___()_)__________________________oOOo___(_)___oOOo_________________________(_()___)--| //
// |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|____|_____| //
// |                                                                                   2017 | //
// |----------------------------------------------------------------------------------------| //
// |                 File:     BDFH MA                                           | //
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
#property copyright "Copyright © 2015, Faiq Alzahmi"
#property link      "faiqalzahmi@ymail.com"

#property indicator_chart_window
#property indicator_buffers 5
#property indicator_color1 Aqua
#property indicator_color2 Yellow
#property indicator_color3 Blue
#property indicator_color4 Red
#property indicator_color5 Lime
//----
extern int ma1 = 3;
extern int ma2 = 13;
extern int ma3 = 20;
extern int ma4 = 100;
extern int ma5 = 200;
//----
double ma1_buffer [];
double ma2_buffer [];
double ma3_buffer [];
double ma4_buffer [];
double ma5_buffer [];  
int a_begin;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//----
   SetIndexStyle(0, DRAW_LINE);
   SetIndexBuffer(0, ma1_buffer);
   SetIndexLabel(0, "3 SMA");
//---- 
   SetIndexStyle(1, DRAW_LINE);
   SetIndexBuffer(1, ma2_buffer);
   SetIndexLabel(1, "13 SMA");   
//----
   SetIndexStyle(2, DRAW_LINE,EMPTY,1);
   SetIndexBuffer(2, ma3_buffer);
   SetIndexLabel(2, "20 SMA");
//----   
   SetIndexStyle(3, DRAW_LINE,EMPTY,1);
   SetIndexBuffer(3, ma4_buffer);
   SetIndexLabel(3, "100 SMA");
//----   
   SetIndexStyle(4, DRAW_LINE,EMPTY, 1);
   SetIndexBuffer(4, ma5_buffer);
   SetIndexLabel(4, "200 SMA");
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   int counted_bars = IndicatorCounted();
//----
   if(counted_bars < 0) 
       return(-1);
//----
   if(counted_bars > 0) 
       counted_bars --;
   int pos = Bars - counted_bars;  
//----
   while(pos >= 0) 
     {
       ma1_buffer[pos] = iMA(NULL, 0, ma1, NULL, MODE_SMA, PRICE_CLOSE, pos);
       ma2_buffer[pos] = iMA(NULL, 0, ma2, NULL, MODE_SMA, PRICE_CLOSE, pos);
       ma3_buffer[pos] = iMA(NULL, 0, ma3, NULL, MODE_SMA, PRICE_CLOSE, pos);
       ma4_buffer[pos] = iMA(NULL, 0, ma4, NULL, MODE_SMA, PRICE_CLOSE, pos);
       ma5_buffer[pos] = iMA(NULL, 0, ma5, NULL, MODE_SMA, PRICE_CLOSE, pos);
       pos--;
     }
//----
   return(0);
  }
//+------------------------------------------------------------------+