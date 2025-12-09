//module folder_name::module_name(file_name)
module basic_move::basic_move; //Should be the same name as the folder name
use sui::test_scenario;
use std::string::String;
// const ErrorOne: u64 = 1;
// const Error2: u64 = 100;
const NumberOneIsNotEqualToOne: u64 = 100;


public struct Hero has key, store {
    id: object::UID,
    name: String,
    surname: String,
    age: u8,
}

public struct InsignificantWeapon has drop, store {
    power: u8,
}

public fun mint_hero(name: String, surname: String, age: u8, ctx: &mut TxContext): Hero {
    let hero = Hero { id: object::new(ctx), name, surname, age };
    hero //Return the hero object

    // hero {id: object::new(ctx) }
}

public fun create_insignificant_weapon(power: u8): InsignificantWeapon {
    InsignificantWeapon { power }
}

#[test]
fun test_mint() {
    let mut test = test_scenario::begin(@0x1);
    let hero_name = b"Zidan".to_string();
    let hero_surname = b"the great".to_string();
    let hero_age = 30;

    let minted_hero = mint_hero(hero_name, hero_surname, hero_age, test.ctx());
    assert!(minted_hero.name == b"Zidan".to_string(), NumberOneIsNotEqualToOne);
    assert!(minted_hero.age == 30, NumberOneIsNotEqualToOne);
    // assert!( 1 == 0, 100);
    destroy_for_testing(minted_hero);
    // let Hero { id } = minted_hero;

    // let insignificant_weapon = create_insignificant_weapon(10);
    // object::delete(id);
    test.end();
}

#[test]
fun test_drop_semantics() {}

#[test_only]
fun destroy_for_testing(hero: Hero){
    let Hero { 
        id,
        name: _,
        age: _,
        surname: _,
    } = hero;
    object::delete(id);
    //Here we can only delete the hero object because it has the drop ability
    //If we had an InsignificantWeapon object here we would not be able to delete it because it does not have the drop ability
    //We would have to transfer it or do something else with it instead of just deleting it
    //This is because the InsignificantWeapon struct does not have the drop ability
}

//Move => You must move value around
//Key => Mens that this object is can be a sui object(automatically a sui object)
//Drop => Means you tell the compiler that it can drop this object, without drop you must do something with the value
//Store => Means you can store this object inside other objects
//Copy => Means you can copy this value around
//Object => Is a built in sui module that allows you to create sui objects
//TxContext(ctx) => Is a built in sui module that gives you context about the transaction, like who is the sender
//ctx.sender() => Returns the address of the sender of the transaction
//object::new(ctx) => Creates a new sui object and returns its UID
//transfer::public_transfer(object, ctx.sender()) => Transfers the object to the sender of the transaction
//#[lint_allow(self_transfer)] => Is an attribute that allows you to transfer an object to yourself without getting a lint warning
