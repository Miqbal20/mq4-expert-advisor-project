//+------------------------------------------------------------------+
//|                                                BBEMA Averaging   |
//|                                              miqbal020@gmail.com |
//|                                     http://miqbal20.blogspot.com |
//+------------------------------------------------------------------+

#property copyright "miqbal20.blogspot.com"
#property link      "miqbal020@gmail.com"
#property version   "1.00"
#property strict

extern string  Nama_EA                 = "BBEMA Averaging";
extern int     Mulai_Jam               = 3;
extern int     Akhir_Jam               = 20;
extern double  TP_in_money             = 25;
extern double  Lots                    = 0.2;
extern int     Jarak_order             = 15;
extern int     Max_order               = 10;
extern double  DiMarti                 = 2;
extern int     Magic                   = 20;
int     TP                      = 0;
int     SL                      = 0;
double asi, bi,slb,tpb,sls,tps,pt,bal, tar,up,lo,ylot,dlot,opb,ops; 

int tiket,ticet,sigz, sigc,signal,dap;
static datetime wt,wk;
//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
    bal= AccountEquity();
    if(Digits==3 || Digits==5) pt=10*Point;   else   pt=Point;
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{  

//----
   
label();

//----
    double ma = iMA(Symbol(), 0, 13 , 0, MODE_EMA, PRICE_CLOSE, 1 ) ;

    double BBUpNow = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_UPPER,0);
    double BBLowNow = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_LOWER,0);  
    double BBUp = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_UPPER,1);
    double BBLow = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_LOWER,1);  
    double BBUp_2 = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_UPPER,2);
    double BBLow_2 = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_LOWER,2);   
    double BBUp_3 = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_UPPER,3);
    double BBLow_3 = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_LOWER,3);  
    double BBUp_4 = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_UPPER,4);
    double BBLow_4 = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_LOWER,4); 
    double BBUp_5 = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_UPPER,5);
    double BBLow_5 = iBands(Symbol(),0,20,2,0,PRICE_CLOSE,MODE_LOWER,5); 
    
    double closeNow = iClose(Symbol(),0,0);
    double close = iClose(Symbol(),0,1);
    double close2 = iClose(Symbol(),0,2);
    double close3 = iClose(Symbol(),0,3);
    double close4 = iClose(Symbol(),0,4);
    double close5 = iClose(Symbol(),0,5);
    
    double openNow = iOpen(Symbol(),0,0);
    double open = iOpen(Symbol(),0,1);
    double open2 = iOpen(Symbol(),0,2);
    double open3 = iOpen(Symbol(),0,3);
    double open4 = iOpen(Symbol(),0,4);
    double open5 = iOpen(Symbol(),0,5);
    
    double highNow = iHigh(Symbol(),0,0);
    double high = iHigh(Symbol(),0,1);
    double high2 = iHigh(Symbol(),0,2);
    double high3 = iHigh(Symbol(),0,3);
    double high4 = iHigh(Symbol(),0,4);
    double high5 = iHigh(Symbol(),0,5);
    
    double lowNow = iLow(Symbol(),0,0);
    double low = iLow(Symbol(),0,1);
    double low2 = iLow(Symbol(),0,2);
    double low3 = iLow(Symbol(),0,3);
    double low4 = iLow(Symbol(),0,4);
    double low5 = iLow(Symbol(),0,5);
    
    if((high<ma) && (low<BBLow) && (low2<BBLow_2) && (low3<BBLow_3) && (low4<BBLow_4) && (low5<BBLow_5)){     
        signal=2; 
    }
        
    if((low>ma) && (high>BBUp) && (high2>BBUp_2) && (high3>BBUp_3) && (high4>BBUp_4)  && (high5>BBUp_5)){
      signal = 1;
    } 
   
if(Jam_trade()==1){
   if(SL==0)slb=0;else slb=Ask-SL*pt;
   if(SL==0)sls=0;else sls=Bid+SL*pt;
   if(TP==0)tpb=0;else tpb=Ask+TP*pt;
   if(TP==0)tps=0;else tps=Bid-TP*pt;
   

  if(jumlahorder(0)==0 && wt!=Time[0] && jumlahorder(1)==0 && signal==2) {if(OrderSend(Symbol(),OP_BUY,NR(Lots),Ask,3,slb, tpb,Nama_EA,Magic,0,Blue))Print("Buy");  wt=Time[0];}
  if(jumlahorder(0)==0 && wt!=Time[0] && jumlahorder(1)==0 && signal==1) {if(OrderSend(Symbol(),OP_SELL,NR(Lots),Bid,3,sls, tps,Nama_EA,Magic,0,Red))Print("Sell"); wk=Time[0];}
 }
if(trad()==1 && wt!=Time[0] && jumlahorder(1)==0 && jumlahorder(0)<Max_order && signal==2) {if(OrderSend(Symbol(),OP_BUY,xlot(0),Ask,3,slb, tpb,Nama_EA,Magic,0,Blue))Print("Averaging Buy"); wt=Time[0]; dap = 0; }
if(trad()==2 && wk!=Time[0] && jumlahorder(0)==0 && jumlahorder(1)<Max_order && signal==1) {if(OrderSend(Symbol(),OP_SELL,xlot(1),Bid,3,sls, tps,Nama_EA,Magic,0,Red))Print("Averaging Sell"); wk=Time[0]; dap = 0; }

if(money()>TP_in_money && jumlahorder(0)<=2){
   if(closeNow>ma){
       closeall(0);
       signal=0;
   }   

   if(closeNow<ma  && jumlahorder(1)<=2){
       closeall(1); 
       signal=0;
     }
   }
  
  if(money()>1){
   if(closeNow>ma && jumlahorder(0)>=3){
       closeall(0);
       signal=0;
   }   

   if(closeNow<ma && jumlahorder(1)>=3){
       closeall(1); 
       signal=0;
     }
   }
 }
//+------------------------------------------------------------------+

int Jam_trade()
{
   bool trade = false;
   if(Mulai_Jam > Akhir_Jam){
     if (Hour() >= Mulai_Jam || Hour() < Akhir_Jam) trade = true;
   } else
     if (Hour() >= Mulai_Jam && Hour() < Akhir_Jam) trade = true;

   return (trade);
}

int jumlahorder( int tipe)
{
int total=0;
for(int i=0; i<OrdersTotal(); i++)
  {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))continue;
      if(OrderSymbol()!=Symbol() || OrderMagicNumber()!=Magic || OrderType()!=tipe) continue;
     total++;
  }

return(total);
}
double NR(double thelot)
{
    double maxlots = MarketInfo(Symbol(), MODE_MAXLOT),
    minilot = MarketInfo(Symbol(), MODE_MINLOT),
    lstep = MarketInfo(Symbol(), MODE_LOTSTEP);
    double lots = lstep * NormalizeDouble(thelot / lstep, 0);
    lots = MathMax(MathMin(maxlots, lots), minilot);
    return (lots);
}

void closeall(int m)
{
 for (int i = OrdersTotal() - 1; i >= 0; i--) {
  if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES))continue;
  if (OrderSymbol() != Symbol() || OrderMagicNumber()!=Magic || m!= OrderType()) continue;
  if (OrderType() > 1) tiket=OrderDelete(OrderTicket());
   else {
    if (OrderType() == 0) tiket=OrderClose(OrderTicket(), OrderLots(), Bid, 3, Blue);
    else               tiket=OrderClose(OrderTicket(), OrderLots(), Ask, 3, Red);
  }
 }
}
double money()
{
 double dp = 0;
 int i;
 for (i = 0; i < OrdersTotal(); i++) {
  if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES))continue;
  if (OrderSymbol() != Symbol()  || OrderMagicNumber()!=Magic) continue;
  dp += OrderProfit();
 }
 return(dp);
}

int trad()
{
 int type;
  for (int i = 0; i < OrdersTotal(); i++) {
   if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) continue;
   if (OrderSymbol() != Symbol() || OrderMagicNumber() != Magic) continue;
     type=OrderType();
   if(type==0)opb = OrderOpenPrice();
   if(type==1)ops = OrderOpenPrice();
  }
   asi = opb - Jarak_order * pt;
   bi = ops + Jarak_order * pt;
   if ( Ask <= asi &&  jumlahorder(0)> 0 ) dap=1; 
   if ( Bid >= bi &&  jumlahorder(1)> 0 ) dap=2; 
 
  return(dap);
}
double xlot(int m)
{
  for (int i = 0; i < OrdersTotal(); i++) {
   if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) continue;
   if (OrderSymbol() != Symbol() || OrderMagicNumber() != Magic ||OrderType()!=m) continue;
     dlot=OrderLots();
     }
if(OrderType()==m)ylot=NR(Lots*MathPow(DiMarti,jumlahorder(m)));
return(ylot);
}
void label()
{
 Comment("\n ",
   "\n ",
   "\n ------------------------------------------------",
   "\n :: ",Nama_EA,
   "\n ------------------------------------------------",
   "\n :: Spread                 : ", MarketInfo(Symbol(), MODE_SPREAD),
   "\n :: Leverage               : 1 : ", AccountLeverage(),
   "\n :: Jam Server             :", Hour(), ":", Minute(),
   "\n ------------------------------------------------",
   "\n :: Equity sekarang        : ", AccountEquity(),"  $",
   "\n ------------------------------------------------",
   "\n :: Posisi floting         :", NormalizeDouble(money(),2),"  $",

   "\n :: Jumlah level           :",jumlahorder(0)+jumlahorder(1),
   "\n ------------------------------------------------");
//+------------------------------------------------------------------+
}
