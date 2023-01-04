//+------------------------------------------------------------------+
//|                                                     Fractals.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\BillWilliams.mqh>
#include "../CallableIndicator.mqh"

//input group                "Awesome Oscillator"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Fractals : public CallableIndicator
  {
protected:
   CiFractals              fractals;
public:
   virtual bool              InitIndicator();
   virtual void*             GetIndicator() { return GetPointer(fractals);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Fractals::InitIndicator()
  {
// initialize object
   if(!fractals.Create(Symbol(), Period()))
     {
      printf(__FUNCTION__ + ": error initializing Fractals");
      return(false);
     }

   return(true);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class FractalsUpper: public Fractals
  {
public:
   virtual double              GetData(int index) override
     {
      return fractals.Upper(index);
     };

  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class FractalsLower: public Fractals
  {
public:
   virtual double              GetData(int index) override
     {
      return fractals.Lower(index);
     };

  };