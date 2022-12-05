//+------------------------------------------------------------------+
//|                                           CallableIndicator.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"


interface CallableIndicator
  {
public:
         
   virtual bool              InitIndicator();
   virtual double            GetData(int index); 
  };