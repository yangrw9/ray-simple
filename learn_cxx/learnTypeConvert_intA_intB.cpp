
class intB;

class intA {
public:
  intA() = default;
  intA(const intB& ) // implicit convert from intB
  {

  }

//  operator intB();
//  operator intB() {  // never possible ??
//  }

};

class intB {
public:
  intB() = default;
  intB(const intA&) // implicit convert from intA
  {

  }
  
  operator intA() {

  }

};


void foo(intA a) {

}

void bar(intB b) {

}

int main () {
   intA a;
   foo(a);
   bar(a); // auto convert happen

   intB b;
   foo(b); // auto convert 
   bar(b);
}

