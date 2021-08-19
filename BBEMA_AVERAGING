//+------------------------------------------------------------------+
//|                                                BBEMA AVERAGING   |
//|                                               miqbal020@gmail.com|
//|                                     http://miqbal20.blogspot.com |
//+------------------------------------------------------------------+

#property copyright "miqbal20.blogspot.com"
#property link      "miqbal20.blogspot.com"
#property version   "1.00"
#property strict

extern string  Nama_EA                 = "BBEMA AVERAGING";
extern string  Target_Equety_          = "Harus lebih besar dari Equety+";
extern double  Target_Equety           = 10000000;
extern bool    Tp_in_Money             = false;
extern double  TP_in_money             = 20;
extern double  Lots                    = 1;
extern int     Jarak_order             = 40;
extern int     Jarak_ave               = 40;
extern int     Max_order               = 6;
extern double  DiMarti                 = 1.1;
extern int     Magic                   = 20;

int     TP                      = 0;
int     SL                      = 0;
bool    Trade_buy               = true;
bool    Trade_sell              = true;
string  Sesi_Pertama            = "Sesi Pertama";
int     Mulai_Jam               = 2;
int     Akhir_Jam               = 6;
string  Sesi_Kedua              = "Sesi Kedua";
int     Mulai_Jam2              = 9;
int     Akhir_Jam2              = 12;
string  Sesi_Ketiga             = "Sesi Ketiga";
int     Mulai_Jam3              = 15;
int     Akhir_Jam3              = 19;
   
double asi, bi,slb,tpb,sls,tps,pt,bal, tar,up,lo,ylot,dlot,opb,ops,openSell, openBuy;    
int tiket,ticet,sigz, sigc,signal,signal_ave,dap,daily;
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
if(Target_Equety<AccountEquity()) {
    closeall(0);
    closeall(1);
    tar=1;
    Alert("Cek Target_Equetynya salah ");
 }
if(Tp_in_Money && TP_in_money<= AccountProfit()){ 
    closeall(0);
    signal = 0;
    closeall(1);
    signal_ave = 0;
   }

//AWAL INISIALISASI
    double ma = iMA(Symbol(), 0, 28 , 0, MODE_SMA, PRICE_CLOSE, 1 ) ;
    double ema = iMA(Symbol(), 0, 100 , 0, MODE_EMA, PRICE_CLOSE, 1 ) ;

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
    
    double closeNow = iClose(Symbol(),0,0);
    double close = iClose(Symbol(),0,1);
    double close2 = iClose(Symbol(),0,2);
    double close3 = iClose(Symbol(),0,3);
    double close4 = iClose(Symbol(),0,4);
    
    double openNow = iOpen(Symbol(),0,0);
    double open = iOpen(Symbol(),0,1);
    double open2 = iOpen(Symbol(),0,2);
    double open3 = iOpen(Symbol(),0,3);
    double open4 = iOpen(Symbol(),0,4);
    
    double highNow = iHigh(Symbol(),0,0);
    double high = iHigh(Symbol(),0,1);
    double high2 = iHigh(Symbol(),0,2);
    double high3 = iHigh(Symbol(),0,3);
    double high4 = iHigh(Symbol(),0,4);
    
    double lowNow = iLow(Symbol(),0,0);
    double low = iLow(Symbol(),0,1);
    double low2 = iLow(Symbol(),0,2);
    double low3 = iLow(Symbol(),0,3);
    double low4 = iLow(Symbol(),0,4);

//AKHIR INISIALISASI

//AWAL RULE OPEN
  
    if(Hour() == 0)signal=0; daily =0; signal_ave = 0;
    
    if((high<ma) && (high<ema) && (low<BBLow) && (low2<BBLow_2)  && (low3<BBLow_3)  && (low4<BBLow_4)){     
      signal=2; 
    }
        
    if((low>ma) && (low>ema) && (high>BBUp) && (high2>BBUp_2) && (high3>BBUp_3) && (high4>BBUp_4)){
      signal = 1;
    }     
    if((high<ma) && (high<ema) && (low<BBLow) && (low2<BBLow_2) ){     
       signal_ave=2; 
    }
        
    if((low>ma) && (low>ema) && (high>BBUp) && (high2>BBUp_2) ){
      signal_ave = 1;
    } 

//AKHIR RULE OPEN

//AWAL ORDER
if(Jam_trade() == 1 || Jam_trade2() == 1 || Jam_trade3() == 1){
if(!tar){  
   if(SL==0)slb=0;else slb=Ask-SL*pt;
   if(SL==0)sls=0;else sls=Bid+SL*pt;
   if(TP==0)tpb=0;else tpb=Ask+TP*pt;
   if(TP==0)tps=0;else tps=Bid-TP*pt;
  if(jumlahorder(0)==0 && wt!=Time[0] &&  jumlahorder(1)==0  && Trade_buy  && signal==2 && daily == 0) {if(OrderSend(Symbol(),OP_BUY,NR(Lots),Ask,3,slb, tpb,Nama_EA,Magic,0,Blue))Print("Buy"); daily = 1; openBuy = Ask;wt=Time[0];signal = 0; }
  if(jumlahorder(0)==0 && wt!=Time[0] &&  jumlahorder(1)==0  && Trade_sell && signal==1 && daily == 0) {if(OrderSend(Symbol(),OP_SELL,NR(Lots),Bid,3,sls, tps,Nama_EA,Magic,0,Red))Print("Sell"); daily = 1; openSell = Bid;wt=Time[0];signal = 0;}
 }
   if(openBuy-closeNow > Jarak_ave*pt){
     if(trad()==1 && wt!=Time[0] && jumlahorder(1)==0 && jumlahorder(0)<Max_order  && Trade_buy  && signal_ave==2) {if(OrderSend(Symbol(),OP_BUY,xlot(0),Ask,3,slb, tpb,Nama_EA,Magic,0,Blue))Print("Avearging Buy");daily = 1;openBuy = Ask; wt=Time[0]; }
   }
   if(closeNow-openSell > Jarak_ave*pt){
    if(trad()==2 && wk!=Time[0] && jumlahorder(0)==0 && jumlahorder(1)<Max_order  && Trade_sell && signal_ave==1) {if(OrderSend(Symbol(),OP_SELL,xlot(1),Bid,3,sls, tps,Nama_EA,Magic,0,Red))Print("Avearging Sell"); daily = 1;  openSell = Bid; wk=Time[0];}
   }

//AWAL CLOSE ORDER

   if(AccountProfit()>TP_in_money){
     if(highNow>ma && jumlahorder(0)<=1){
         closeall(0);signal = 0; openBuy = 0; signal_ave = 0;
     }
     if(lowNow<ma && jumlahorder(1)<=1){
         closeall(1); signal = 0; openSell = 0;signal_ave = 0;
     }
   }
   if(AccountProfit()>TP_in_money){
     if(jumlahorder(0)>=2)   {closeall(0);signal = 0; openBuy = 0; signal_ave = 0;}
     if(jumlahorder(1)>=2)   {closeall(1); signal = 0; openSell = 0;signal_ave = 0;}
   }
//AKHIR CLOSE ORDER   

  }
}
//AKHIR ORDER  
//+------------------------------------------------------------------+
//FUNCTION
int Jam_trade()
{
   bool trade = false;
   if(Mulai_Jam > Akhir_Jam){
     if (Hour() >= Mulai_Jam || Hour() < Akhir_Jam) trade = true;
   } else
     if (Hour() >= Mulai_Jam && Hour() < Akhir_Jam) trade = true;

   return (trade);
}

int Jam_trade2()
{
   bool trade = false;
   if(Mulai_Jam2 > Akhir_Jam2){
     if (Hour() >= Mulai_Jam2 || Hour() < Akhir_Jam2) trade = true;
      } else
     if (Hour() >= Mulai_Jam2 && Hour() < Akhir_Jam2) trade = true;

   return (trade);
}

int Jam_trade3()
{
   bool trade = false;
   if(Mulai_Jam3 > Akhir_Jam3){
     if (Hour() >= Mulai_Jam3 || Hour() < Akhir_Jam3) trade = true;
      } else
     if (Hour() >= Mulai_Jam3 && Hour() < Akhir_Jam3) trade = true;

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
    if (OrderType() == 0) tiket=OrderClose(OrderTicket(), OrderLots(), Bid, 3, CLR_NONE);
    else               tiket=OrderClose(OrderTicket(), OrderLots(), Ask, 3, CLR_NONE);
  }
 }
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
      string sesi = "";
      if(Jam_trade()!=1 || Jam_trade2()!=1 || Jam_trade3()!=1)  sesi ="Tidak Ada Sesi";  
      if(Jam_trade()==1)sesi ="Sesi Pertama"; 
      if(Jam_trade2()==1)sesi ="Sesi Kedua";
      if(Jam_trade3()==1)sesi ="Sesi Ketiga";
 Comment("\n ",
   "\n ",
   "\n ------------------------------------------------",
   "\n :: =>BBEMA AVERAGING<=",
   "\n ------------------------------------------------",
   "\n :: Sesi : ", sesi,
   "\n :: Spread : ", MarketInfo(Symbol(), MODE_SPREAD),
   "\n :: Leverage : 1 : ", AccountLeverage(),
   "\n :: Jam Server : ", Hour(), ":", Minute(), 
   "\n :: Balanced : ",NormalizeDouble(AccountBalance(), 5), 
   "\n ------------------------------------------------",
   "\n :: Posisi floting  :", NormalizeDouble(AccountProfit(),4),"  $",
   "\n :: Magic  :",Magic,
   "\n :: Jumlah level  :",jumlahorder(0)+jumlahorder(1),
   "\n ------------------------------------------------",
   "\n :: >>By: Miqbal20<<",
   "\n ------------------------------------------------");
//+------------------------------------------------------------------+
}
