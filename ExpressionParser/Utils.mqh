//+------------------------------------------------------------------+
//|                                                        Utils.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsNumeric(string value)
  {
   for(int i=0; i<StringLen(value); i++)
     {
      int currentChar = StringGetCharacter(value, i);
      if(currentChar < '0' || currentChar > '9')
         return(false);
     }
   return(true);
  }

template<typename T> int ArrayContains(T value, const T& array[])
  {
   int index=ArraySize(array);
   while(--index >= 0)
      if(array[index] == value)
         break;
   return index;
  }

//+------------------------------------------------------------------+
