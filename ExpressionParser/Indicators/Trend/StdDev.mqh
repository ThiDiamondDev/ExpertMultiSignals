//+------------------------------------------------------------------+
//|                                                       StdDev.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"

input group                "Standard Deviation"

input int                  StdDevPeriod       =  8;             // Period
input int                  StdDevShift        =  0;             // Shift
input ENUM_MA_METHOD       StdDevMethod       =  MODE_SMA;      // Method
input ENUM_APPLIED_PRICE   StdDevAppliedPrice =  PRICE_CLOSE;   // AppliedPrice

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class StdDev : public CallableIndicator
  {
private:
   CiStdDev              stdDev;
public:
   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(stdDev);};
  };

//+------------------------------------------------------------------+
//| Create MA indicators                                             |
//+------------------------------------------------------------------+
bool StdDev::InitIndicator()
  {
// initialize object
   if(!stdDev.Create(Symbol(), Period(), StdDevPeriod,StdDevShift,StdDevMethod, StdDevAppliedPrice))
     {
      printf(__FUNCTION__ + ": error initializing Standard Deviation");
      return(false);
     }

   return(true);
  }
//+------------------------------------------------------------------+
double StdDev::GetData(int index)
  {
   return stdDev.Main(index);
  };
//+------------------------------------------------------------------+
