//+------------------------------------------------------------------+
//|                                                         Tema.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"


input group                "Triple Exponential Moving Average"

input int                  TemaPeriod       =  14;             // Period
input int                  TemaShift        =  0;             // Shift
input ENUM_APPLIED_PRICE   TemaAppliedPrice =  PRICE_CLOSE;   // AppliedPrice


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Tema : public CallableIndicator
  {
private:
   CiTEMA              tema;


public:
  
   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(tema);};
  };

//+------------------------------------------------------------------+
//| Create MA indicators                                             |
//+------------------------------------------------------------------+
bool Tema::InitIndicator()
  {
// initialize object
   if(!tema.Create(Symbol(), Period(), TemaPeriod, TemaShift,TemaAppliedPrice))
     {
      printf(__FUNCTION__ + ": error initializing Tema");
      return(false);
     }

   return(true);
  }
//+------------------------------------------------------------------+
double Tema::GetData(int index)
  {
   return tema.Main(index);
  };