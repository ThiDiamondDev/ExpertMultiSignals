//+------------------------------------------------------------------+
//|                                                     Variable.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"



string  VALID_ARRAYS[] = {"array1", "array2", "array3", "array4"};

enum ARRAYS
  {
   ARRAY1,ARRAY2,ARRAY3,ARRAY4
  };



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IsValidIndex(int index, int arraySize)
  {
   return(index >= 0 && index < arraySize);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CallArrayValue(int nameIndex,int callIndex)
  {
   switch(nameIndex)
     {
      case  ARRAY1:
         return(GetArray1(callIndex));
      case  ARRAY2:
         return(GetArray2(callIndex));
      case  ARRAY3:
         return(GetArray3(callIndex));
      case  ARRAY4:
         return(GetArray4(callIndex));

      default:
         break;
     }
   return(0);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetArray1(int index)
  {
   double array[] = {0,1,2,3,4,5};
   if(IsValidIndex(index,ArraySize(array)))
      return(array[index]);
   return(0);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetArray2(int index)
  {
   double array[] = {0,2,4,6,8,10};
   if(IsValidIndex(index,ArraySize(array)))
      return(array[index]);
   return(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetArray3(int index)
  {
   double array[] = {0,3,5,7,9,12};
   if(IsValidIndex(index,ArraySize(array)))
      return(array[index]);
   return(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetArray4(int index)
  {
   double array[] = {1,1,1,1,1,1};
   if(IsValidIndex(index,ArraySize(array)))
      return(array[index]);
   return(0);
  }

//+------------------------------------------------------------------+
