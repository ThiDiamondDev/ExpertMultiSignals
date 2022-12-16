//+------------------------------------------------------------------+
//|                                                        Alligator.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\BillWilliams.mqh>
#include "../CallableIndicator.mqh"

input group                "Alligator"

input int        LipsPeriod = 5;
input int        TeethPeriod = 8;
input int        JawsPeriod = 13;

input int        LipsShift = 0;
input int        TeethShift = 0;
input int        JawsShift = 0;

input ENUM_MA_METHOD      AlligatorMethod;  // MA method
input ENUM_APPLIED_PRICE  AlligatorPrice;  // MA method

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Alligator : public CallableIndicator
  {
protected:
   CiAlligator              alligator;

public:

   virtual bool              InitIndicator();

   virtual void*             GetIndicator() { return GetPointer(alligator);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Alligator::InitIndicator()
  {
// initialize object
   if(!alligator.Create(Symbol(), Period(),
                        JawsPeriod,JawsShift,TeethPeriod,TeethShift,LipsPeriod,
                        LipsShift,AlligatorMethod,AlligatorPrice))
     {
      printf(__FUNCTION__ + ": error initializing Alligator");
      return(false);
     }

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class AlligatorJaws: public Alligator
  {
public:
   virtual double              GetData(int index) override
     {
      return alligator.Jaw(index);
     };
  };


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class AlligatorLips: public Alligator
  {
public:
   virtual double              GetData(int index) override
     {
      return alligator.Lips(index);
     };
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class AlligatorTeeth: public Alligator
  {
public:
   virtual double              GetData(int index) override
     {
      return alligator.Teeth(index);
     };
  };
//+------------------------------------------------------------------+
