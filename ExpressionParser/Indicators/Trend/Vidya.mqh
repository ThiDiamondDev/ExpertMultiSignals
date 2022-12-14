//+------------------------------------------------------------------+
//|                                                        Vidya.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"

input group                "Variable Index Dynamic Average"

input int                  VidyaCMO        =  9;                 // CMO Period
input int                  VidyaEMA        =  12;                // EMA Period
input int                  VidyaShift      =  0;                // Shift
input ENUM_APPLIED_PRICE   VidyaAppliedPrice =  PRICE_CLOSE;    // AppliedPrice


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Vidya : public CallableIndicator
  {
private:
   CiVIDyA              vidya;

public:
                    ~Vidya(void) {};
   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(vidya);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Vidya::InitIndicator()
  {
// initialize object
   if(!vidya.Create(Symbol(), Period(),VidyaCMO,VidyaEMA,VidyaShift,VidyaAppliedPrice))
     {
      printf(__FUNCTION__ + ": error initializing Vidya");
      return(false);
     }

   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Vidya::GetData(int index)
  {
   return vidya.Main(index);
  };
//+------------------------------------------------------------------+
