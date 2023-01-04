//+------------------------------------------------------------------+
//|                                                    ADXWilder.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"

input group "ADX Wilder"
input int ADXWilderPeriod = 8; // Period
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ADXWilder : public CallableIndicator
  {
protected:
   CiADXWilder             adx;

public:
                     ADXWilder() {};
   virtual bool      InitIndicator();
   virtual double    GetData(int index) { return adx.Main(index);};
   virtual void*     GetIndicator() { return GetPointer(adx);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ADXWilder::InitIndicator()
  {
   if(!adx.Create(Symbol(), Period(), ADXWilderPeriod))
     {
      printf(__FUNCTION__ + ": error initializing adx");
      return (false);
     }

   return (true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ADXWilderMain : public ADXWilder
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
class ADXWilderPlus : public ADXWilder
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
class ADXWilderMinus : public ADXWilder
  {
public:
   virtual double    GetData(int index) override
     {
      return adx.Minus(index);
     };
  };

//+------------------------------------------------------------------+
