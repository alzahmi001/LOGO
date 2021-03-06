
// +----------------------------------------------------------------------------------------+ //
// |    .-._______                           FAIQHILYA                        _______.-.    | //
// |---( )_)______)                 Knowledge of the ancients                (______(_( )---| //
// |  (    ()___)                              \¦/                             (___()    )  | //
// |       ()__)                              (o o)                             (__()       | //
// |--(___()_)__________________________oOOo___(_)___oOOo_________________________(_()___)--| //
// |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|____|_____| //
// |                                                                                   2017 | //
// |----------------------------------------------------------------------------------------| //
// |                 File:     BDFH BOX PAIR 1                                              | //
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

#property copyright " ©2017 NOPEMBER"
#property link      "TARGET 2019"
#property indicator_chart_window

int      NormalSpread;
color    warna;
string   text,simbol;
double   PrevBid, PrevAsk;
extern string XAUUSD    ="GOLD"; // Pair0 = GBPUSD
extern string Pair6    = "NZDUSD"; // Pair1 = EURUSD
extern string Pair7    = "AUDUSD"; // Pair2 = USDJPY
extern string Pair8    = "USDCAD"; // Pair3 = USDCHF

int init()
{
   IndicatorShortName("TrixEMAboard");
   NormalSpread = (Ask-Bid)/Point;
   return(0);
}

int deinit()
{
   ObjectsDeleteAll();
   return(0);
}

int start()
{
    int i ;
    
        // ==================================================================================== //
        //                           F I R S T     C O L O U M B                                //
        // ==================================================================================== //

        // Left Title
        // ==========
         
        ObjectCreate("SymbolTxt", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("SymbolTxt","ONE SHOOT ONE KILL",12, "Arial Bold", C'95,103,211');
        
        ObjectSet("SymbolTxt", OBJPROP_XDISTANCE, 297);
        ObjectSet("SymbolTxt", OBJPROP_YDISTANCE, 0);
		  ObjectSet("SymbolTxt", OBJPROP_ANGLE, 0);

        ObjectCreate("kotak11",  OBJ_LABEL,0, 0, 0);
        ObjectSetText("kotak11","gg",15, "webdings", C'25,25,25');
        ObjectSet("kotak11", OBJPROP_XDISTANCE, 795);
        ObjectSet("kotak11", OBJPROP_YDISTANCE, 187);
        
        ObjectCreate("kotak12",  OBJ_LABEL,0, 0, 0);
        ObjectSetText("kotak12","ggg",15, "webdings", C'21,21,21');
        ObjectSet("kotak12", OBJPROP_XDISTANCE, 840);
        ObjectSet("kotak12", OBJPROP_YDISTANCE, 187);
        
        ObjectCreate("au",  OBJ_LABEL,0, 0, 0);
        ObjectSetText("au","ggg",15, "webdings", C'11,11,11');
        ObjectSet("au", OBJPROP_XDISTANCE, 885);
        ObjectSet("au", OBJPROP_YDISTANCE, 187);
		 
		  ObjectCreate("kotak14",  OBJ_LABEL,0, 0, 0);
        ObjectSetText("kotak14","ggg",14, "webdings", C'16,16,16');
        ObjectSet("kotak14", OBJPROP_XDISTANCE, 925);
        ObjectSet("kotak14", OBJPROP_YDISTANCE, 187);
		  
		  ObjectCreate("line11", OBJ_LABEL, 0, 0, 0);
		  ObjectSetText("line11","_____________________",12, "Arial Bold", C'8,8,8');
        ObjectSet("line11", OBJPROP_XDISTANCE, 778);
        ObjectSet("line11", OBJPROP_YDISTANCE, 190);
		  ObjectSet("line11", OBJPROP_ANGLE, 90);
		  
		  ObjectCreate("line12", OBJ_LABEL,0, 0, 0);
        ObjectSetText("line12","__",12, "Arial Bold", C'64,64,64');
        ObjectSet("line12", OBJPROP_XDISTANCE, 822);
        ObjectSet("line12", OBJPROP_YDISTANCE, 211);
		  ObjectSet("line12", OBJPROP_ANGLE, 90);
		  
		  ObjectCreate("line13", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("line13","__",12, "Arial Bold", C'68,68,68');
        ObjectSet("line13", OBJPROP_XDISTANCE, 867);
        ObjectSet("line13", OBJPROP_YDISTANCE, 211);
		  ObjectSet("line13", OBJPROP_ANGLE, 90);
		  
		  ObjectCreate("line14", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("line14","__",12, "Arial Bold", C'64,64,64');
        ObjectSet("line14", OBJPROP_XDISTANCE, 912);
        ObjectSet("line14", OBJPROP_YDISTANCE, 211);
		  ObjectSet("line14", OBJPROP_ANGLE, 90);
	
        // ==================================================================================== //
        //                           S E C O N D   C O L O U M B                                //
        // ==================================================================================== //
 
         ////////////// TREND 3 VS 20 SMA XAUUSD  //////////////
//M15 TREND GOLD       
        double faiq, hilya;
        faiq     = iMA(XAUUSD,PERIOD_M15,3,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(XAUUSD,PERIOD_M15,20,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("GOLDT", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("GOLDT", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("GOLDT", OBJPROP_XDISTANCE, 795);
        ObjectSet    ("GOLDT", OBJPROP_YDISTANCE, 189);
//M15 MARKET GOLD       
        faiq     = iMA(XAUUSD,PERIOD_M15,20,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(XAUUSD,PERIOD_M15,100,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("GOLDM", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("GOLDM", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("GOLDM", OBJPROP_XDISTANCE, 810);
        ObjectSet    ("GOLDM", OBJPROP_YDISTANCE, 189);
//M15 GLOBAL GOLD       
        faiq     = iMA(XAUUSD,PERIOD_M15,100,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(XAUUSD,PERIOD_M15,200,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("GOLDG", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("GOLDG", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("GOLDG", OBJPROP_XDISTANCE, 825);
        ObjectSet    ("GOLDG", OBJPROP_YDISTANCE, 189);
      
        ////////////// TREND 3 VS 20 SMA NZDUSD //////////////
//M15 TREND NU       
        faiq     = iMA(Pair6,PERIOD_M15,3,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(Pair6,PERIOD_M15,20,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("NUT", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("NUT", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("NUT", OBJPROP_XDISTANCE, 840);
        ObjectSet    ("NUT", OBJPROP_YDISTANCE, 195);
//M15 MARKET NU       
        faiq     = iMA(Pair6,PERIOD_M15,20,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(Pair6,PERIOD_M15,100,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("NUM", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("NUM", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("NUM", OBJPROP_XDISTANCE, 855);
        ObjectSet    ("NUM", OBJPROP_YDISTANCE, 195);
//M15 GLOBAL NU      
        faiq     = iMA(Pair6,PERIOD_M15,100,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(Pair6,PERIOD_M15,200,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("NUG", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("NUG", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("NUG", OBJPROP_XDISTANCE, 870);
        ObjectSet    ("NUG", OBJPROP_YDISTANCE, 195);
         
        ////////////// TREND 3 VS 20 SMA AUDUSD //////////////
//M15 TREND AU       
        faiq     = iMA(Pair7,PERIOD_M15,3,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(Pair7,PERIOD_M15,20,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("AUT", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("AUT", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("AUT", OBJPROP_XDISTANCE, 885);
        ObjectSet    ("AUT", OBJPROP_YDISTANCE, 190);
//M15 MARKET AU       
        faiq     = iMA(Pair7,PERIOD_M15,20,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(Pair7,PERIOD_M15,100,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("AUM", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("AUM", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("AUM", OBJPROP_XDISTANCE, 900);
        ObjectSet    ("AUM", OBJPROP_YDISTANCE, 190);
//M15 GLOBAL AU      
        faiq     = iMA(Pair7,PERIOD_M15,100,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(Pair7,PERIOD_M15,200,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("AUG", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("AUG", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("AUG", OBJPROP_XDISTANCE, 915);
        ObjectSet    ("AUG", OBJPROP_YDISTANCE, 190);
            
      ////////////// TREND 3 VS 20 SMA USDCAD //////////////
//M15 TREND UCAD       
        faiq     = iMA(Pair8,PERIOD_M15,3,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(Pair8,PERIOD_M15,20,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("UCADT", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("UCADT", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("UCADT", OBJPROP_XDISTANCE, 930);
        ObjectSet    ("UCADT", OBJPROP_YDISTANCE, 195);
//M15 MARKET UCAD       
        faiq     = iMA(Pair8,PERIOD_M15,20,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(Pair8,PERIOD_M15,100,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("UCADM", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("UCADM", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("UCADM", OBJPROP_XDISTANCE, 945);
        ObjectSet    ("UCADM", OBJPROP_YDISTANCE, 195);
//M15 GLOBAL UCAD       
        faiq     = iMA(Pair8,PERIOD_M15,100,0,MODE_SMA,PRICE_CLOSE,0);
        hilya    = iMA(Pair8,PERIOD_M15,200,0,MODE_SMA,PRICE_CLOSE,0);
        if (faiq>=hilya)   { warna = Lime; simbol = "\xE9"; }
        else               { warna = Red;  simbol = "\xE9"; }
        ObjectCreate ("UCADG", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("UCADG", simbol,12, "Wingdings 2", warna);
        ObjectSet    ("UCADG", OBJPROP_XDISTANCE, 960);
        ObjectSet    ("UCADG", OBJPROP_YDISTANCE, 195);
       
       // Account P/L
        // ===========
        
        ObjectCreate("AcctPLTxt", OBJ_LABEL, WindowFind("TrixEMAboard"), 0, 0);
        ObjectSetText("AcctPLTxt","Acct P/L",9, "Arial Bold", CadetBlue);
        ObjectSet("AcctPLTxt", OBJPROP_CORNER, 0);
        ObjectSet("AcctPLTxt", OBJPROP_XDISTANCE, 50);
        ObjectSet("AcctPLTxt", OBJPROP_YDISTANCE, 55);

        double accPL = AccountProfit();
        if (accPL<0) warna = Red; else warna = Lime;
        ObjectCreate("AcctPL", OBJ_LABEL, WindowFind("TrixEMAboard"), 0, 0);
        ObjectSetText("AcctPL",DoubleToStr(accPL,2),9, "Arial Bold", warna);
        ObjectSet("AcctPL", OBJPROP_CORNER, 0);
        ObjectSet("AcctPL", OBJPROP_XDISTANCE, 140);
        ObjectSet("AcctPL", OBJPROP_YDISTANCE, 55);


        // Account Equity
        // ==============
         
        ObjectCreate("AcctEquityTxt", OBJ_LABEL, WindowFind("TrixEMAboard"), 0, 0);
        ObjectSetText("AcctEquityTxt","Acct Equity",9, "Arial Bold", CadetBlue);
        ObjectSet("AcctEquityTxt", OBJPROP_CORNER, 0);
        ObjectSet("AcctEquityTxt", OBJPROP_XDISTANCE, 50);
        ObjectSet("AcctEquityTxt", OBJPROP_YDISTANCE, 70);

        ObjectCreate("AcctEquity", OBJ_LABEL, WindowFind("TrixEMAboard"), 0, 0);
        ObjectSetText("AcctEquity",DoubleToStr(AccountEquity(),2),9, "Arial Bold", White);
        ObjectSet("AcctEquity", OBJPROP_CORNER, 0);
        ObjectSet("AcctEquity", OBJPROP_XDISTANCE, 140);
        ObjectSet("AcctEquity", OBJPROP_YDISTANCE, 70);


        // Account Balance
        // ===============
        
        ObjectCreate("AcctBalTxt", OBJ_LABEL, WindowFind("TrixEMAboard"), 0, 0);
        ObjectSetText("AcctBalTxt","Acct Balance",9, "Arial Bold", CadetBlue);
        ObjectSet("AcctBalTxt", OBJPROP_CORNER, 0);
        ObjectSet("AcctBalTxt", OBJPROP_XDISTANCE, 50);
        ObjectSet("AcctBalTxt", OBJPROP_YDISTANCE, 85);

        ObjectCreate("AcctBal", OBJ_LABEL, WindowFind("TrixEMAboard"), 0, 0);
        ObjectSetText("AcctBal",DoubleToStr(AccountBalance(),2),9, "Arial Bold", White);
        ObjectSet("AcctBal", OBJPROP_CORNER, 0);
        ObjectSet("AcctBal", OBJPROP_XDISTANCE, 140);
        ObjectSet("AcctBal", OBJPROP_YDISTANCE, 85);


        // Account Pair P/L
        // ================

        double PairPL = 0;
        for (i = 0; i <= OrdersTotal(); i++)
        {
            OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
            if (OrderSymbol() == Symbol())
                 PairPL = PairPL + OrderProfit();
        }
        
        ObjectCreate("PairPLTxt", OBJ_LABEL, WindowFind("TrixEMAboard"), 0, 0);
        ObjectSetText("PairPLTxt","Pair P/L",9, "Arial Bold", CadetBlue);
        ObjectSet("PairPLTxt", OBJPROP_CORNER, 0);
        ObjectSet("PairPLTxt", OBJPROP_XDISTANCE, 50);
        ObjectSet("PairPLTxt", OBJPROP_YDISTANCE, 100);

        if (PairPL<0) warna = Red; else warna = Lime;
        ObjectCreate("PairPL", OBJ_LABEL, 0, 0, 0);
        ObjectSetText("PairPL",DoubleToStr(PairPL,2),11, "Arial Bold", warna);
        ObjectSet("PairPL", OBJPROP_CORNER, 0);
        ObjectSet("PairPL", OBJPROP_XDISTANCE, 485);
        ObjectSet("PairPL", OBJPROP_YDISTANCE, 0);
       
       
       
   return(0);
}