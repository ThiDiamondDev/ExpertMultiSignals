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

   string            GetSolutionOrError();

   void              SetError(string errorMessage){error = errorMessage;};

public:
                     Expression() {};
   bool              Resolve();
   bool              HasError();
   TermType          GetTermAType();
   TermType          GetTermBType();
   int               GetTermAIndex(void);
   int               GetTermBIndex(void);

   string            GetSolvedString();
                      Expression(string a,string b, string _operator, int _operatorIndex,Caller *caller):
                     termA(a, caller), termB(b, caller), operatorValue(_operator),
                     operatorIndex(_operatorIndex), error(""),expressionStr(a+_operator+b) {}
  };

//+------------------------------------------------------------------+

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

TermType Expression::GetTermAType(void)
  {
   return(termA.GetType());
  }
  
TermType Expression::GetTermBType(void)
  {
   return(termB.GetType());
  }
  
int Expression::GetTermAIndex(void)
  {
   return(termA.GetIndex());
  }
  
int Expression::GetTermBIndex(void)
  {
   return(termB.GetIndex());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Expression::GetSolutionOrError(void)
  {
   bool solution = Resolve();
   return (HasError()? error: (string) solution);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Expression::HasError(void)
  {
   return(error != "");
  }
//+------------------------------------------------------------------+
