
module sui_primitives::sui_primitives {

    #[test]
    fun test_numbers() {
        let a = 50;
        let b = 50;
        assert!(a == b, 601);

        let c = a + b;
        assert!(c == 100, 602);

        let d = c - a;
        assert!(d == 50, 603);
    }

    #[test]
    fun test_overflow() {
        let a : u16 = 500;
        let b: u16 = 500;

        let c : u16 = a + b;
        assert!(c == 1000u16, 604) ;
    }

    #[test]
    fun test_addition() {
        let a  = 500;
        let b = 500;

        let c = a + b;
        std::debug::print(&c);
    }

    #[test]
    fun test_mutability() {
        let mut a = 100;
        a = a - 10;
        assert!(a == 90, 605) ;
    }

    #[test]
    fun test_boolean(){
        let a = 500;
        let b = 1000;
        let greater = b > a;
        assert!(greater == true, 606);
    }

    #[test]
    fun test_loop(){
        let fact = 5;
        let mut result : u256 = 1;
        let mut i = 2;
        while (i <= fact) {
            result  = result * i;
            i = i + 1;
        };
        std::debug::print(&result);
        assert!(result == 120, 607);
    }

    #[test]
    fun test_vector(){
        let mut myVec: vector<u8> = vector[10, 20, 30];

        assert!(myVec.length() == 3, 11);
        assert!(!myVec.is_empty(), 12);

        myVec.push_back(40);
        let last_value = myVec.pop_back();

        assert!(last_value == 40, 13);

        while (myVec.length() > 0) {
            myVec.pop_back();
        };
        assert!(myVec.is_empty(), 14);
    }

    #[test]
    fun test_vectors(){
        let mut myVec: vector<u8> = vector[10];
        myVec.push_back(20);
        std::debug::print(&myVec.length());
        std::debug::print(&myVec.pop_back());
    }

    #[test_only]
    use std::string::{String};

    #[test]
    fun test_string(){
        let myString : String           = b"Hello".to_string();
        let myStringArr : vector<u8>    = b"Hello";

        std::debug::print(&myStringArr.length());
        std::debug::print(&myString);
        std::debug::print(&myStringArr);

        assert!(myString.length() == myStringArr.length(), 41);
        assert!(myString == myStringArr.to_string(), 42);
    }

    #[test]
    fun test_string2(){
        let myStringArr = b"Hello, World!";
        let mut i: u64 = 0;
        let mut indexOfW : u64 = 0;
        while(i < myStringArr.length()){
            indexOfW = if(myStringArr[i] == 87) { i } else { indexOfW };
            i = i + 1;
        };
        assert!(indexOfW == 7);
    }

}
