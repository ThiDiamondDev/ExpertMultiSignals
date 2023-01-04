//+------------------------------------------------------------------+
//|                                                     Variable.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link "https://github.com/ThiDiamondDev"
#property version "1.00"
#include <Arrays/ArrayString.mqh>
#include "IndicatorsMap.mqh"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Caller: public IndicatorsMap
  {
private:
   CArrayString      calledIndicatorsName;
   CIndicators       indicatorsArray;
   bool              InitIndicator(CallableIndicator * indicator);

public:
   CArrayObj         calledIndicators;

                     Caller(): IndicatorsMap() {};
   bool              AddCalledIndicator(string indicatorName);
   bool              InitIndicators(CIndicators *indicators);
   CallableIndicator* GetCalledIndicator(int index)
     {
      return ((CallableIndicator*)calledIndicators.At(index));

     };
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Caller::InitIndicator(CallableIndicator *indicator)
  {
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
bool Caller::AddCalledIndicator(string indicatorName)
  {
   CallableIndicator *indicator;

   if(TryGetValue(indicatorName,indicator))
     {
      if(calledIndicatorsName.SearchLinear(indicatorName) == -1)
         if(!calledIndicatorsName.Add(indicatorName))
            return false;

      return calledIndicators.Add(indicator);
     }

   return false;
  }
//+------------------------------------------------------------------+
