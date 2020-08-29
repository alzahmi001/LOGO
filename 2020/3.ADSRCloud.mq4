//+-------------------------------------------------------------------+
//|                                               F41Q_Day_candle.mq4 |
//|                                   Copyright © 2015, Faiq Alzahmi  |
//|                                           hilyaalzahmita@gmail.com|
//+-------------------------------------------------------------------+
#property copyright "Copyright © 2015, Faiq Alzahmi"
#property link      "faiqalzahmi@ymail.com"

#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1 C'0,97,0'  //  C'0,33,0'
#property indicator_color2 C'128,28,40'
#property indicator_color3 MediumAquamarine
#property indicator_color4 MediumVioletRed
#property indicator_width1 4  //width1
#property indicator_width2 4
#property indicator_width3 2
#property indicator_width4 2
//

extern int       MA1Period=25;
extern int       MA1Method=MODE_LWMA;
extern int       MA1Price =PRICE_MEDIAN;
extern int       MA2Period=75;
extern int       MA2Method=MODE_LWMA;
extern int       MA2Shift=1;
extern int       MA2Price =PRICE_WEIGHTED;
extern bool   AlertOn = false,
              EmailOn = false,
              AlertOnClosedCandle = false;
extern bool    ShowArrows = false;
extern int     ArrowWidth = 2;
extern color   ArrowsUpColor = C'0,199,0',
               ArrowsDnColor = C'199,0,0';
extern int    Corner = 3;               

//
//
//
//
//

double buffer1[];
double buffer2[];
double buffer3[];
double buffer4[];
int Trend=0,SignalCandle=0;
datetime LastAlert=0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

int init()
{
   SetIndexBuffer(0,buffer3); SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexBuffer(1,buffer4); SetIndexStyle(1,DRAW_HISTOGRAM);
   SetIndexBuffer(2,buffer1);
   SetIndexBuffer(3,buffer2);
   if (AlertOnClosedCandle) SignalCandle=1;
   return(0);
}
int deinit() {
   Comment("");
   if (ShowArrows) {
      for (int i=ObjectsTotal()-1;i>=0;i--) {
         if (StringFind(ObjectName(i),"MARibbon")>-1) ObjectDelete(ObjectName(i));
         }
      }
   ObjectDelete("Trade");
   return(0);
} 

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

int start()
{
   int counted_bars=IndicatorCounted();
   int limit,i;
   
   if(counted_bars<0) return(-1);
   if(counted_bars>0) counted_bars--;
           limit=Bars-counted_bars;

   //
   //
   //
   //
   //

   for(i=limit; i>=0; i--)
   {
      buffer1[i] = iMA(NULL,0,MA1Period,0,MA1Method,MA1Price,i);
      buffer2[i] = iMA(NULL,0,MA2Period,1,MA2Method,MA2Price,i);
      buffer3[i] = buffer1[i];
      buffer4[i] = buffer2[i];
      if (buffer1[i+SignalCandle]>buffer2[i+SignalCandle] && buffer1[i+1+SignalCandle]<=buffer2[i+1+SignalCandle] && Trend<1) {
         Trend=1;
	      if (ShowArrows) DrawArrow(i+SignalCandle,buffer2[i+SignalCandle],ArrowsUpColor,217,false);
	      }
      else if (buffer1[i+SignalCandle]<buffer2[i+SignalCandle] && buffer1[i+1+SignalCandle]>=buffer2[i+1+SignalCandle] && Trend>-1) {
      	Trend=-1;
      	if (ShowArrows) DrawArrow(i+SignalCandle,buffer2[i+SignalCandle],ArrowsDnColor,218,true);
         }
   }
   if (buffer1[SignalCandle]>buffer2[SignalCandle] && buffer1[SignalCandle+1]<=buffer2[SignalCandle+1] && LastAlert!=Time[0]) {
      LastAlert=Time[0];
      if (AlertOn) Alert("MA Ribbon Buy Alert! - "+Symbol()+"["+Period()+"m]");
      if (EmailOn) SendMail("MA Ribbon Buy Alert!","Buy alert on "+Symbol()+"["+Period()+"m]");
      }
   else if (buffer1[SignalCandle]<buffer2[SignalCandle] && buffer1[SignalCandle+1]>=buffer2[SignalCandle+1] && LastAlert!=Time[0]) {
      LastAlert=Time[0];
      if (AlertOn) Alert("MA Ribbon Sell Alert! - "+Symbol()+"["+Period()+"m]");
      if (EmailOn) SendMail("MA Ribbon Sell Alert!","Sell alert on "+Symbol()+"["+Period()+"m]");
      }
   string OPstr;
   color OPclr;
   if (Trend>0) {
      OPstr = "BUY";
      OPclr = C'0,255,0';
      }
   else if (Trend<0) {
      OPstr = "SELL";
      OPclr = C'255,0,0';
      }
   else {
      OPstr = "NO Trade";
      OPclr = White;
      }
   ObjectCreate("Trade", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("Trade", OPstr, 11, "Arial Bold", OPclr);
   ObjectSet("Trade", OBJPROP_CORNER, Corner);
   ObjectSet("Trade", OBJPROP_XDISTANCE, 1111);
   ObjectSet("Trade", OBJPROP_YDISTANCE, 7119);
   return(0);
}
void DrawArrow(int i, double ma, color theColor,int theCode,bool up) {
   string name = "MARibbon:"+Time[i];
   double gap  = 3.0*iATR(NULL,0,10,i)/4.0;   
   ObjectCreate(name,OBJ_ARROW,0,Time[i],0);
      ObjectSet(name,OBJPROP_ARROWCODE,theCode);
      ObjectSet(name,OBJPROP_COLOR,theColor);
      ObjectSet(name,OBJPROP_WIDTH,ArrowWidth);
      if (up)
            ObjectSet(name,OBJPROP_PRICE1,ma+gap);
      else  ObjectSet(name,OBJPROP_PRICE1,ma-gap);
   return;
}

