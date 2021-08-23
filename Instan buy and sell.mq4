//+-------------------------------------------------------------------+
//|                                                         EA BBMA   |
//|                                               miqbal020@gmail.com |
//|                                     https://Miqbal20.blogspot.com |
//+-------------------------------------------------------------------+

#property copyright "Miqbal20.blogspot.com"
#property link      "miqbal020@gmail.com"

//Inisialisasi
extern string  Nama_EA                 = "Instan Buy and Sell";
extern int     Magic                   = 2020;
extern int TP = 50;
extern int SL = 25;
extern double  Lots = 0.1;
int res,ras,rus, tiket;
double slb,tpb,sls,tps,pt, asi, bi,bal, tar,up,lo,ylot,dlot,opb,ops,  x;
datetime LastActiontime;
int ticet,sigz, sigc,dap, signal;

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   if(Digits==3 || Digits==5) pt=10*Point;   else   pt=Point;
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----

//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
  label();
//Kondisi Buy dan Sell
       if(LastActiontime!=Time[0]){
         if(signal==1) {
            Alert("Order Buy : " + Symbol());
            Print("Order Buy :  : " + Symbol());      
         }
         if( signal==2) {
            Alert("Order Sell : " + Symbol());
            Print("Order Sell : " + Symbol());
            SendNotification(Symbol()+" : Alert Sell");
         }
      LastActiontime=Time[0];}

   return(0);
  }
//+------------------------------------------------------------------+

//Fungsi Label 
void label()
{
   Comment("\n ",
   "\n ",
   "\n ------------------------------------------------",
   "\n :: ",Nama_EA,
   "\n ------------------------------------------------",
   "\n :: Spread : ", MarketInfo(Symbol(), MODE_SPREAD),
   "\n :: Leverage : 1 : ", AccountLeverage(),
   "\n :: Jam Server : ", Hour(), ":", Minute(), 
   "\n ------------------------------------------------",
   "\n :: Balanced : ", NormalizeDouble(AccountEquity(),4),
   "\n :: Floating : ",NormalizeDouble(AccountProfit(), 4), 
   "\n ------------------------------------------------",
   "\n :: Created by: Miqbal20",
   "\n ------------------------------------------------");
}

//Fungsi Tombol
void OnChartEvent(const int id, const long &lparam,const double &dparam,const string &sparam) {
 
 //Tombol Buy
 ObjectCreate(0,"Buy",OBJ_BUTTON,0,0,0);
 ObjectSetInteger(0,"Buy",OBJPROP_XDISTANCE,130);
 ObjectSetInteger(0,"Buy",OBJPROP_YDISTANCE,240);
 ObjectSetInteger(0,"Buy",OBJPROP_XSIZE,90);
 ObjectSetInteger(0,"Buy",OBJPROP_YSIZE,40);
 ObjectSetInteger(0,"Buy",OBJPROP_CORNER,3);
 ObjectSetString(0,"Buy",OBJPROP_TEXT,"BUY"); 
 
 //Tombol Sell
 ObjectCreate(0,"Sell",OBJ_BUTTON,0,0,0);
 ObjectSetInteger(0,"Sell",OBJPROP_XDISTANCE,130);
 ObjectSetInteger(0,"Sell",OBJPROP_YDISTANCE,195);
 ObjectSetInteger(0,"Sell",OBJPROP_XSIZE,90);
 ObjectSetInteger(0,"Sell",OBJPROP_YSIZE,40);
 ObjectSetInteger(0,"Sell",OBJPROP_CORNER,3);
 ObjectSetString(0,"Sell",OBJPROP_TEXT,"SELL"); 
 
 //Tombol Close All Order
 ObjectCreate(0,"CloseAll",OBJ_BUTTON,0,0,0);
 ObjectSetInteger(0,"CloseAll",OBJPROP_XDISTANCE,130);
 ObjectSetInteger(0,"CloseAll",OBJPROP_YDISTANCE,150);
 ObjectSetInteger(0,"CloseAll",OBJPROP_XSIZE,90);
 ObjectSetInteger(0,"CloseAll",OBJPROP_YSIZE,40);
 ObjectSetInteger(0,"CloseAll",OBJPROP_CORNER,3);
 ObjectSetString(0,"CloseAll",OBJPROP_TEXT,"CLOSE"); 
 
   if(SL==0)slb=0;else slb=Ask-SL*pt;
   if(SL==0)sls=0;else sls=Bid+SL*pt;
   if(TP==0)tpb=0;else tpb=Ask+TP*pt;
   if(TP==0)tps=0;else tps=Bid-TP*pt;
   
   if(id==CHARTEVENT_OBJECT_CLICK){
      if(sparam=="CloseAll"){
	      closeall(0);    
         closeall(1);    
	   } 
      if(sparam=="Buy"){
         if(OrderSend(Symbol(),OP_BUY,Lots,Ask,3,slb, tpb,Nama_EA,Magic,0,Blue))Print("Buy"); 
	   }  
      if(sparam=="Sell"){
	    if(OrderSend(Symbol(),OP_SELL,Lots,Bid,3,sls, tps,Nama_EA,Magic,0,Red))Print("Sell");
	   }   
   }
}
void closeall()
{
 for (int i = OrdersTotal() - 1; i >= 0; i--) {
  if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES))continue;
  if (OrderSymbol() != Symbol() || OrderMagicNumber()!=Magic ) continue;
  if (OrderType() > 1) rus=OrderDelete(OrderTicket());
   else {
    if (OrderType() == 0) rus=OrderClose(OrderTicket(), OrderLots(), Bid, 3, Blue);
    else rus=OrderClose(OrderTicket(), OrderLots(), Ask, 3, Red);
  }
 }
}

void closeall(int m)
{
 for (int i = OrdersTotal() - 1; i >= 0; i--) {
  if(!OrderSelect(i, SELECT_BY_POS, MODE_TRADES))continue;
  if (OrderSymbol() != Symbol() || OrderMagicNumber()!=Magic || m!= OrderType()) continue;
  if (OrderType() > 1) tiket=OrderDelete(OrderTicket());
   else {
    if (OrderType() == 0) tiket=OrderClose(OrderTicket(), OrderLots(), Bid, 3, Blue);
    else tiket=OrderClose(OrderTicket(), OrderLots(), Ask, 3, Red);
  }
 }
}
