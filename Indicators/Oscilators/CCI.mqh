//+------------------------------------------------------------------+
//|                                                          CCI.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Oscilators.mqh>
#include "../CallableIndicator.mqh"

input group "CCI"

input int CCIPeriod = 14;                          // Period
input ENUM_APPLIED_PRICE CCIPrice = PRICE_TYPICAL; // Applied price

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CCI : public CallableIndicator
  {
protected:
   CiCCI             cci;

public:
                     CCI() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index);
   virtual void*     GetIndicator() { return GetPointer(cci);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CCI::InitIndicator()
  {
   if(!cci.Create(Symbol(), Period(),CCIPeriod, CCIPrice))
     {
      printf(__FUNCTION__ + ": error initializing CCI");
      return (false);
     }
   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CCI::GetData(int index)
  {
   return cci.Main(index);
  }
//+------------------------------------------------------------------+
