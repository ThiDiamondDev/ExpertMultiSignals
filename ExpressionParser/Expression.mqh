//+------------------------------------------------------------------+
//|                                                   Expression.mqh |
//|                                                       ThiDiamond |
//|                                 https://github.com/ThiDiamondDev |
//+------------------------------------------------------------------+
#property copyright "ThiDiamond"
#property link      "https://github.com/ThiDiamondDev"
#property version   "1.00"
#include  "Term.mqh"
#include  "Indicators/Caller.mqh"
#include  <Object.mqh>


enum Operators
  {

   OPERATOR_EQUAL,            //  ==
   OPERATOR_NOT_EQUAL,        //  !=
   OPERATOR_GREATER,          //  >
   OPERATOR_LESS,             //  <
   OPERATOR_GREATER_OR_EQUAL, //  >=
   OPERATOR_LESS_OR_EQUAL,    //  <=
  };



//+------------------------------------------------------------------+
//| Expression class                                                 |
//+------------------------------------------------------------------+
class Expression: public CObject
  {
private:
   Term              termA, termB;
   string            operatorValue,  error, expressionStr;
   int               operatorIndex;

   void              SetError(string errorMessage) {error = errorMessage;};

public:
   bool              Resolve();
   bool              HasError();

   string            GetSolvedString();
                     Expression(string a,string b, string _operator, int _operatorIndex,Caller *caller):
                     termA(a, caller), termB(b, caller), operatorValue(_operator),
                     operatorIndex(_operatorIndex), error(""),expressionStr(a+_operator+b) {}
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Expression::Resolve(void)
  {
   double valueA = termA.GetValue();
   double valueB = termB.GetValue();
   switch(operatorIndex)
     {
      case OPERATOR_GREATER          :
         return(valueA > valueB);
      case OPERATOR_LESS             :
         return(valueA < valueB);
      case OPERATOR_GREATER_OR_EQUAL :
         return(valueA >= valueB);
      case OPERATOR_LESS_OR_EQUAL    :
         return(valueA <= valueB);
      case OPERATOR_EQUAL            :
         return(valueA == valueB);
      case OPERATOR_NOT_EQUAL        :
         return(valueA != valueB);

      default :
         SetError("Invalid operator index value.");
     }
   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Expression::HasError(void)
  {
   bool hasError = false;
   if(termA.GetError() != "")
     {
      Print(termA.GetError());
      hasError = true;
     }
   if(termB.GetError() != "")
     {
      Print(termB.GetError());
      hasError = true;
     }

   return hasError;
  }
//+------------------------------------------------------------------+
