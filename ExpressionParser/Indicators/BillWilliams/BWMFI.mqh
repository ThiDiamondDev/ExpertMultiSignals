//+------------------------------------------------------------------+
//|                                                        BWMFI.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\BillWilliams.mqh>
#include "../CallableIndicator.mqh"

input group                "Bill Williams Market Facilitation Index"

input ENUM_APPLIED_VOLUME     BWMFIVolume;  // Volume
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class BWMFI : public CallableIndicator
  {
private:
   CiBWMFI              bwmfi;

public:

   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(bwmfi);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool BWMFI::InitIndicator()
  {
// initialize object
   if(!bwmfi.Create(Symbol(), Period(),BWMFIVolume))
     {
      printf(__FUNCTION__ + ": error initializing BWMFI");
      return(false);
     }

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double BWMFI::GetData(int index)
  {
   return bwmfi.Main(index);
  };
//+------------------------------------------------------------------+
