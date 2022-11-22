//+------------------------------------------------------------------+
//|                                                  testeScript.mq5 |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"

#include"ExpressionParser.mqh";
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   ExpressionParser parser("15 > 25 & 10 == 11"); 
   string solution = parser.GetAllSolvedExpressions();
   parser.PrintAllSolvedExpressions();
  }
//+------------------------------------------------------------------+
