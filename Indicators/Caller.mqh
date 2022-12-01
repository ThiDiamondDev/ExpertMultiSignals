//+------------------------------------------------------------------+
//|                                                     Variable.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"

#include "MovingAverages.mqh"


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
   MovingAverages          movingAverages;
public:
                     Caller();
                    ~Caller(void){};
   bool              InitIndicator(int index);
   double            CallIndicator(int indicator,int callIndex);
  };


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Caller::Caller()
  {
   movingAverages = new MovingAverages();
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool    Caller::InitIndicator(int indicator)
  {
   switch(indicator)
     {
      case  MA1:
         return(movingAverages.InitMA1());
      case  MA2:
         return(movingAverages.InitMA2());
      case  MA3:
         return(movingAverages.InitMA3());
      case  MA4:
         return(movingAverages.InitMA4());
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
         return(movingAverages.GetMA1(callIndex));
      case  MA2:
         return(movingAverages.GetMA2(callIndex));
      case  MA3:
         return(movingAverages.GetMA3(callIndex));
      case  MA4:
         return(movingAverages.GetMA4(callIndex));

     }
   return(0);
  }
//+------------------------------------------------------------------+
