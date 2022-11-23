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
   string expression = "array1[1] > array2[5] & 50 > 40";
   ExpressionParser parser(expression);
   
   string solution = parser.GetAllSolvedExpressions();
   parser.PrintAllSolvedExpressions();
  }
//+------------------------------------------------------------------+
