//+------------------------------------------------------------------+
//|                                                 ParabolicSAR.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#include <Indicators\Trend.mqh>
#include "../CallableIndicator.mqh"


input group                "ParabolicSAR"

input double                ParabolicSARStep       =  0.02;    // Step
input double                ParabolicSARMaximun    =  0.2;     // Maximun

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ParabolicSAR : public CallableIndicator
  {
private:
   CiSAR                     parabolicSAR;

public:
   virtual bool              InitIndicator();
   virtual double            GetData(int index);
   virtual void*             GetIndicator() { return GetPointer(parabolicSAR);};
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ParabolicSAR::InitIndicator()
  {
// initialize object
   if(!parabolicSAR.Create(Symbol(), Period(),ParabolicSARStep,ParabolicSARMaximun))
     {
      printf(__FUNCTION__ + ": error initializing ParabolicSAR");
      return(false);
     }

   return(true);
  }
//+------------------------------------------------------------------+
double ParabolicSAR::GetData(int index)
  {
   return parabolicSAR.Main(index);
  };
//+------------------------------------------------------------------+
