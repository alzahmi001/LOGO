
// +----------------------------------------------------------------------------------------+ //
// |    .-._______                           FAIQHILYA                        _______.-.    | //
// |---( )_)______)                 Knowledge of the ancients                (______(_( )---| //
// |  (    ()___)                              \¦/                             (___()    )  | //
// |       ()__)                              (o o)                             (__()       | //
// |--(___()_)__________________________oOOo___(_)___oOOo_________________________(_()___)--| //
// |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|____|_____| //
// |                                                                                   2017 | //
// |----------------------------------------------------------------------------------------| //
// |                 File:     BDFH CANDLE                                              | //
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
//+-------------------------------------------------------------------------------------------+
//| Indicator Global Inputs                                                                   |                                                        
//+-------------------------------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 8
     
#property indicator_color1  Gray     
#property indicator_color2  Gray     
#property indicator_color3  C'163,163,163'      
#property indicator_color4  C'100,100,100'
#property indicator_color5  C'017,136,255' 
#property indicator_color6  C'173,051,255'
#property indicator_color7  C'031,192,071'  
#property indicator_color8  C'224,001,006' 

//Global External Inputs 
extern bool   Indicator_On                    = true;

//Global Buffers and Variables
bool          Deinitialized;    
double        Bar1[],Candle1[],Bar2[],Candle2[],bodyHigh,bodyLow,	   
              RisingBull[],RisingBear[],ClimaxBull[],ClimaxBear[],
              av,Range,Value2,HiValue2,tempv2,high,low,open,close;              
int           Chart_Scale,Bar_Width,va,i,j,n,shift1,shift2,counted_bars,limit; 
datetime      time1; 
  
 
//+-------------------------------------------------------------------------------------------+
//| Custom indicator initialization function                                                  |
//+-------------------------------------------------------------------------------------------+
int init()
  {
  Deinitialized = false; 
  
  //Determine the current chart scale (chart scale number should be 0-5)
  Chart_Scale = ChartScaleGet();

  //Set bar widths                   
        if(Chart_Scale == 0) {Bar_Width = 1;}
  else {if(Chart_Scale == 1) {Bar_Width = 2;}      
  else {if(Chart_Scale == 2) {Bar_Width = 2;}
  else {if(Chart_Scale == 3) {Bar_Width = 3;}
  else {if(Chart_Scale == 4) {Bar_Width = 6;}
  else {Bar_Width = 13;} }}}}

  //PVA: Normal bodies and wicks         
  SetIndexBuffer(0,Bar1);
  SetIndexStyle(0,DRAW_HISTOGRAM, 0, 1, indicator_color1);   
  SetIndexBuffer(1,Bar2);  
  SetIndexStyle(1,DRAW_HISTOGRAM, 0, 1, indicator_color2);   			
  SetIndexBuffer(2,Candle1);
  SetIndexStyle(2,DRAW_HISTOGRAM, 0, Bar_Width, indicator_color3);  
  SetIndexBuffer(3,Candle2);  
  SetIndexStyle(3,DRAW_HISTOGRAM, 0, Bar_Width, indicator_color4);    
  //PVA: Rising volume bodies
  SetIndexBuffer(4, RisingBull);
  SetIndexStyle(4, DRAW_HISTOGRAM, 0, Bar_Width, indicator_color5);
  SetIndexBuffer(5, RisingBear);                           
  SetIndexStyle(5, DRAW_HISTOGRAM, 0, Bar_Width, indicator_color6);       
  //PVA: Climax volume bodies    
  SetIndexBuffer(6, ClimaxBull);
  SetIndexStyle(6, DRAW_HISTOGRAM, 0, Bar_Width, indicator_color7); 
  SetIndexBuffer(7, ClimaxBear);        
  SetIndexStyle(7, DRAW_HISTOGRAM, 0, Bar_Width, indicator_color8);                            
                
  //Indicator ShortName   
  IndicatorShortName("SonicR PVA Candles");  
          	       	 		
  return(0);
  }
   
//+-------------------------------------------------------------------------------------------+
//| Custom indicator deinitialization function                                                |
//+-------------------------------------------------------------------------------------------+    
int deinit()
  {
  return(0);
  }
   
//+-------------------------------------------------------------------------------------------+
//| Custom indicator iteration function                                                       |
//+-------------------------------------------------------------------------------------------+
int start()
  {
  //If Indicator is "Off" deinitialize only once, not every tick 
  if (!Indicator_On) 
    {
    if (!Deinitialized) {deinit(); Deinitialized = true;}
    return(0);
    }
    
  //Confirm range of chart bars for calculations   
  //check for possible errors
  counted_bars = IndicatorCounted();
  if(counted_bars < 0)  return(-1);     
  //last counted bar will be recounted
  if(counted_bars > 0) counted_bars--;    
  limit = Bars - counted_bars;
  
  //Begin the loop of calculations for the range of chart bars. 
  for(i = limit - 1; i >= 0; i--)       
    {              
    //First, calculate OHLC etc., to construct standard candle     
	 shift1  = iBarShift(NULL,NULL,Time[i]);
	 time1   = iTime    (NULL,NULL,shift1);
	 shift2  = iBarShift(NULL,NULL,time1);
	 high    = iHigh(NULL,NULL,shift1);
    low     = iLow(NULL,NULL,shift1);
	 open    = iOpen(NULL,NULL,shift1);
	 close   = iClose(NULL,NULL,shift1);
	 bodyHigh= MathMax(open,close);
	 bodyLow = MathMin(open,close);
			 
	 if(close>open)
		{
	   Bar1[shift2] = high;		Candle1[shift2] = bodyHigh;
	   Bar2[shift2] = low;		Candle2[shift2] = bodyLow;
		}
	 else if(close<open)
		{
	 	Bar1[shift2] = low;		Candle1[shift2] = bodyLow;
		Bar2[shift2] = high;		Candle2[shift2] = bodyHigh;
		}
	 else //(close==open)
	   {	
		Bar1[shift2] = low;		Candle1[shift2] = close;
		Bar2[shift2] = high;		Candle2[shift2] = open-0.000001;
      }
           
    //Compute Average Volume and Volume Rising Above Average  
    //Clear buffers
    RisingBull[i] = 0;
    RisingBear[i] = 0;
    ClimaxBull[i] = 0;
    ClimaxBear[i] = 0;
    Value2        = 0;  
    HiValue2      = 0; 
    tempv2        = 0;
    av            = 0;
    va            = 0;      
                 
    //Rising Volume   
    for(j = i+1; j <= i+10; j++) {av = av + Volume[j];}   
    av = av / 10;
    if (Volume[i] >= av * 1.5) {va= 2;} 
                                   
    //Climax Volume                      
    Range = (High[i]-Low[i]);
    Value2 = Volume[i]*Range;                 
    for(n = i+1; n <= i+10; n++)
      {
      tempv2 = Volume[n]*((High[n]-Low[n])); 
      if (tempv2 >= HiValue2) {HiValue2 = tempv2;}    
      } 
    if((Value2 >= HiValue2) || (Volume[i] >= av * 2)) {va= 1;}                    
             
    //Apply Correct Color to Candle
    if (va==1)
      {
      ClimaxBull[i]=iClose(NULL,NULL,i);
      ClimaxBear[i]=iOpen(NULL,NULL,i);
      if(iClose(NULL,NULL,i) == iOpen(NULL,NULL,i)) {ClimaxBear[i]=iOpen(NULL,NULL,i)+0.000001;}
      }
    else if (va==2)
      {
      RisingBull[i]=iClose(NULL,NULL,i);
      RisingBear[i]=iOpen(NULL,NULL,i);
      if(iClose(NULL,NULL,i) == iOpen(NULL,NULL,i)) {RisingBear[i]=iOpen(NULL,NULL,i)+0.000001;}  
      }
    }    
                         
  return(0);
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
//|Custom indicator end                                                                       |
//+-------------------------------------------------------------------------------------------+    
         