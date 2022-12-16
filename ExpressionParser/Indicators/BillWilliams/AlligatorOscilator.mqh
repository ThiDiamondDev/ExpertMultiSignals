//+------------------------------------------------------------------+
//|                                                    Alligator.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\BillWilliams.mqh>
#include "../CallableIndicator.mqh"

input group                "Alligator Oscilator"

input int        OLipsPeriod = 5;
input int        OTeethPeriod = 8;
input int        OJawsPeriod = 13;

input int        OLipsShift = 0;
input int        OTeethShift = 0;
input int        OJawsShift = 0;

input ENUM_MA_METHOD      OAlligatorMethod;  // MA method
input ENUM_APPLIED_PRICE  OAlligatorPrice;  // MA method

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class AlligatorOscilator : public CallableIndicator
  {
protected:
   CiGator                gator;

public:

   virtual bool              InitIndicator();
   virtual double            GetData(int index){return 0;};
   virtual void*             GetIndicator() { return GetPointer(gator);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool AlligatorOscilator::InitIndicator()
  {
// initialize object
   if(!gator.Create(Symbol(), Period(),
                        OJawsPeriod,OJawsShift,OTeethPeriod,OTeethShift,OLipsPeriod,
                        OLipsShift,OAlligatorMethod,OAlligatorPrice))
     {
      printf(__FUNCTION__ + ": error initializing Alligator");
      return(false);
     }

   return(true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class GatorUpper: public AlligatorOscilator
  {
public:
   virtual double              GetData(int index) override
     {
      return gator.Upper(index);
     };
  };


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class GatorLower: public AlligatorOscilator
  {
public:
   virtual double              GetData(int index) override
     {
      return gator.Lower(index);
     };
  };
//+------------------------------------------------------------------+
