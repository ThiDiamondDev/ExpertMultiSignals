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
class Caller
  {
private:
   IndicatorsMap     indicatorsMap;
   CArrayString      calledIndicators;
   CIndicators       indicatorsArray;
   bool              InitIndicator(string indicatorName);

public:
                     Caller();
                    ~Caller(void) {};
   bool              IsValidIndicator(string indicatorName);
   void              AddCalledIndicator(string indicatorName);
   bool              InitIndicators(CIndicators *indicators);
   bool              TryGetIndicator(string name, CallableIndicator *&indicator);
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Caller::Caller()
  {
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
bool Caller::TryGetIndicator(string name, CallableIndicator *&indicator)
  {
   return indicatorsMap.TryGetValue(name, indicator);
  }
//+------------------------------------------------------------------+
