//+------------------------------------------------------------------+
//|                                           CallableIndicator.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"
#include <Indicators/Indicators.mqh>


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CallableIndicator: public CObject
  {
public:

   virtual bool              InitIndicator() {return false;};
   virtual double            GetData(int index) {return 0;};
   virtual void*             GetIndicator() {return NULL;};
  };
//+------------------------------------------------------------------+
