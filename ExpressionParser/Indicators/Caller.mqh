//+------------------------------------------------------------------+
//|                                                     Variable.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link "https://github.com/ThiDiamondDev"
#property version "1.00"
#include <Generic/HashMap.mqh>
#include <Arrays/ArrayString.mqh>
#include "Trend/MovingAverages.mqh"
#include "Trend/ADX.mqh"
#include "Trend/ADXWilder.mqh"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Caller
  {
private:
   CHashMap<string, CallableIndicator *> indicatorsMap;
   CArrayString      calledIndicators;
   CIndicators       indicatorsArray;
   bool              InitIndicator(string indicatorName);

public:
                     Caller();
                    ~Caller(void) {};
   double            CallIndicator(string indicatorName, int callIndex);
   bool              IsValidIndicator(string indicatorName);
   void              AddCalledIndicator(string indicatorName);
   bool              InitIndicators(CIndicators *indicators);
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Caller::Caller()
  {
   indicatorsMap.Add("ma1", new MA1());
   indicatorsMap.Add("ma2", new MA2());
   indicatorsMap.Add("ma3", new MA3());
   indicatorsMap.Add("ma4", new MA4());
   
   indicatorsMap.Add("adx_main", new ADXMain());
   indicatorsMap.Add("adx_plus", new ADXPlus());
   indicatorsMap.Add("adx_minus",new ADXMinus());
  
   indicatorsMap.Add("adx_wilder_main", new ADXWilderMain());
   indicatorsMap.Add("adx_wilder_plus", new ADXWilderPlus());
   indicatorsMap.Add("adx_wilder_minus",new ADXWilderMinus());
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Caller::InitIndicator(string indicatorName)
  {
   CallableIndicator *indicator = NULL;
   if(indicatorsMap.TryGetValue(indicatorName, indicator))
      if(indicator.InitIndicator())
         return indicatorsArray.Add(indicator.GetIndicator());

   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Caller::InitIndicators(CIndicators *indicators)
  {
   for(int index = 0; index < calledIndicators.Total(); index++)
      if(!InitIndicator(calledIndicators.At(index)))
         return false;

   return indicators.AssignArray(GetPointer(indicatorsArray));
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Caller::AddCalledIndicator(string indicatorName)
  {
   if(calledIndicators.SearchLinear(indicatorName) == -1 && IsValidIndicator(indicatorName))
      calledIndicators.Add(indicatorName);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Caller::IsValidIndicator(string indicatorName)
  {
   return (indicatorsMap.ContainsKey(indicatorName));
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Caller::CallIndicator(string indicatorName, int callIndex)
  {
   CallableIndicator *indicator = NULL;
   if(indicatorsMap.TryGetValue(indicatorName, indicator))
      return (indicator.GetData(callIndex));

   return (0);
  }
//+------------------------------------------------------------------+
