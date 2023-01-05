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
   CArrayString      calledIndicators;
   CIndicators       indicatorsArray;
   bool              InitIndicator(string indicatorName);

public:

                     Caller(): IndicatorsMap() {};
   bool              AddCalledIndicator(string indicatorName);
   bool              InitIndicators(CIndicators *indicators);
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Caller::InitIndicator(string indicatorName)
  {
   CallableIndicator *indicator;
   TryGetValue(indicatorName,indicator);

   if(indicator && indicator.InitIndicator())
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
   if(ContainsKey(indicatorName))
     {
      if(calledIndicators.SearchLinear(indicatorName) == -1)
         return calledIndicators.Add(indicatorName);
      return true;
     }
   return false;
  }
//+------------------------------------------------------------------+
