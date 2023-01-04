//+------------------------------------------------------------------+
//|                                                         MACD.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "MACD"

input int MACDFastEMA = 12; // Fast EMA period
input int MACDSlowEMA = 26; // Slow EMA period
input int MACDSMA     =  9; // MACD SMA period
input ENUM_APPLIED_PRICE   MACDPrice  = PRICE_CLOSE; // Applied price

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MACD : public CallableIndicator
  {
protected:
   CiMACD             macd;

public:
                     MACD() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) {return macd.Main(index);}
   virtual void*     GetIndicator() { return GetPointer(macd);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MACD::InitIndicator()
  {
   if(!macd.Create(Symbol(), Period(),MACDFastEMA,MACDSlowEMA,MACDSMA,MACDPrice))
     {
      printf(__FUNCTION__ + ": error initializing MACD");
      return (false);
     }
   return true;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MACDSignal : public MACD
  {
public:
   virtual double    GetData(int index) {return macd.Signal(index);}
  };
//+------------------------------------------------------------------+
