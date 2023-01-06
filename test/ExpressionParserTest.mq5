//+------------------------------------------------------------------+
//|                                               ExpresSParserS.mq5 |
//|                                    Copyright (c) 2020, Marketeer |
//|                          https://www.mql5.com/en/users/marketeer |
//|                           https://www.mql5.com/ru/articles/8028/ |
//+------------------------------------------------------------------+
#include "../ExpressionParser.mqh"
#define CLEAR(pointer) if(CheckPointer(pointer) == POINTER_DYNAMIC) delete pointer;

template<typename K,typename V>
struct Tuple
  {
   K                 key;
   V                 value;
  };

struct TestCase: public Tuple<string,double>
  {
  };

const double a= 1, b = 2, c = 3, _d = 4;
Variable testVariables[] =
  {
     {"a", a},
     {"b", b},
     {"c", c},
     {"d", _d}
  };
TestCase testsuite[] =
  {
     {"a+b+c+d", 10},
     {"((pow(5,2)+pow(10,2)+25)/30*2)*2/4-2*cos(0)", 3},
     {"1<2 && 3<4", 1},
  };

Caller caller;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void test(TestCase &tests[])
  {
   const int testsCount = ArraySize(tests);
   int countPassed = 0;

   Print("Running ", testsCount, " tests on ExpressionParser", " …");

   for(int index = 0; index < testsCount; index++)
     {
      string expression = tests[index].key;
      ExpressionParser *parser = new ExpressionParser(expression,GetPointer(caller));

      if(!parser.Init())
        {
         Print("Error in parser Init(): ", expression);

         CLEAR(parser);
         continue;
        }

      double result = parser.SolveExpression();
      string testInfo = IntegerToString(index + 1) + " ";
      string expected = expression + " = "+ DoubleToString(result) + "; expected = " + DoubleToString(tests[index].value);
      if(result == tests[index].value)
        {
         countPassed++;
         testInfo += " passed, ok: ";
        }
      else
         testInfo += " failed, error: ";

      Print(testInfo,expected);
      CLEAR(parser);

     }
   Print(countPassed, " tests passed of ", testsCount);
  };



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void testParserPerformance(const string expression, const int runnings)
  {
   ulong before, total = 0;
   double result;

   ExpressionParser *parser = new ExpressionParser(expression, GetPointer(caller));
   if(!parser.Init())
     {
      Print("Error in parser Init(): ", expression);
      CLEAR(parser);
      return;
     }

   for(int index = 0; index < runnings; index++)
     {
      before = GetMicrosecondCount();
      result = parser.SolveExpression();
      total += GetMicrosecondCount() - before;
     }
   Print("Microseconds: ", total);
   CLEAR(parser);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnStart()
  {
   Print(">>> Functional testing");
   test(testsuite);

   Print(">>> Performance tests (timing per method)");
   testParserPerformance("(a + b) * (c > 10000 ? c / 4 : c * 4)", 10000);

  }
//+------------------------------------------------------------------+
