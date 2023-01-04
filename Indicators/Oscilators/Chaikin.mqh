//+------------------------------------------------------------------+
//|                                                   Chaikin.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "Chaikin"

input ENUM_APPLIED_VOLUME ChaikinVolume = VOLUME_TICK; // Applied volume
input int ChaikinFastMA = 3;             // Fast MA period
input int ChaikinSlowMA = 10;            // Slow MA period
input ENUM_MA_METHOD ChaikinMethod = MODE_EMA; // Averaging method

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Chaikin : public CallableIndicator
  {
protected:
   CiChaikin             chaikin;

public:
                     Chaikin() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index);
   virtual void*     GetIndicator() { return GetPointer(chaikin);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Chaikin::InitIndicator()
  {
   if(!chaikin.Create(Symbol(), Period(),ChaikinFastMA, ChaikinSlowMA,ChaikinMethod,ChaikinVolume))
     {
      printf(__FUNCTION__ + ": error initializing Chaikin");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Chaikin::GetData(int index)
  {
   return chaikin.Main(index);
  }
//+------------------------------------------------------------------+
