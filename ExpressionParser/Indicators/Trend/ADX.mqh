//+------------------------------------------------------------------+
//|                                                          ADX.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"

input group "ADX"
input int ADXPeriod = 8; // Period
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ADX : public CallableIndicator
  {
protected:
   CiADX             adx;

public:
                     ADX() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) { return adx.Main(index);};
   virtual void*     GetIndicator() { return GetPointer(adx);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ADX::InitIndicator()
  {
   if(!adx.Create(Symbol(), Period(), ADXPeriod))
     {
      printf(__FUNCTION__ + ": error initializing adx");
      return (false);
     }

   return (true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ADXMain : public ADX
  {
public:
   virtual double    GetData(int index) override
     {
      return adx.Main(index);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ADXPlus : public ADX
  {
public:
   virtual double    GetData(int index) override
     {
      return adx.Plus(index);
     };
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ADXMinus : public ADX
  {
public:
   virtual double    GetData(int index) override
     {
      return adx.Minus(index);
     };
  };

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
