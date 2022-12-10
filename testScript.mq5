//+------------------------------------------------------------------+
//|                                                  testeScript.mq5 |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"

#include"ExpressionParser/ExpressionParser.mqh";
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   Caller *caller = new Caller();
   string expression = "5 > 5";
   ExpressionParser parser(expression, caller);
   
   bool solution = parser.ResolveAllExpressions();
   
  }
//+------------------------------------------------------------------+
