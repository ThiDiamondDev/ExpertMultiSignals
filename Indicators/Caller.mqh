//+------------------------------------------------------------------+
//|                                                     Variable.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"

#include "MACaller.mqh"


string  VALID_ARRAYS[] = {"ma1", "ma2", "ma3", "ma4"};

enum INDICATORS
  {
   MA1,MA2,MA3,MA4
  };



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Caller
  {
private:
   MACaller          *maCaller;
public:
                     Caller(string _symbolName, ENUM_TIMEFRAMES _timeframe, CIndicators *_indicators);
                    ~Caller(void);
   bool              InitIndicator(int index);
   double            CallIndicator(int indicator,int callIndex);
  };


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Caller::Caller(string _symbolName, ENUM_TIMEFRAMES _timeframe, CIndicators *_indicators)
  {
   maCaller = new MACaller(_symbolName,_timeframe,_indicators);
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool    Caller::InitIndicator(int indicator)
  {
   switch(indicator)
     {
      case  MA1:
         return(maCaller.InitMA1());
      case  MA2:
         return(maCaller.InitMA2());
      case  MA3:
         return(maCaller.InitMA3());
      case  MA4:
         return(maCaller.InitMA4());
     }
   return(false);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsValidIndex(int index, int arraySize)
  {
   return(index >= 0 && index < arraySize);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Caller::CallIndicator(int indicator,int callIndex)
  {
   switch(indicator)
     {
      case  MA1:
         return(maCaller.GetMA1(callIndex));
      case  MA2:
         return(maCaller.GetMA2(callIndex));
      case  MA3:
         return(maCaller.GetMA3(callIndex));
      case  MA4:
         return(maCaller.GetMA4(callIndex));

     }
   return(0);
  }
//+------------------------------------------------------------------+
