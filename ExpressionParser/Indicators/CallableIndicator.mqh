//+------------------------------------------------------------------+
//|                                           CallableIndicator.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"
#include <Indicators/Indicators.mqh>


interface CallableIndicator
  {
public:

   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator();
  };
//+------------------------------------------------------------------+
