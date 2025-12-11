module abilities_events_params::abilities_events_params;
use std::string::String;
use sui::event;

//Error Codes
const EMedalOfHonorNotAvailable: u64 = 111;

// Structs

public struct HeroRegistry has key {
    id: UID,
    heroes: vector<ID>,

}

public struct Medal has key, store {
    id: UID,
    name: String,   
}

public struct MedalStorage has key {
    id: UID,
    medals: vector<Medal>,
}

public struct Hero has key {
    id: UID, // required
    name: String,
    medals: vector<Medal>,
}

public struct HeroMinted has copy, drop {
    hero_id: ID,
    owner: address,
}

// Module Initializer
fun init(ctx: &mut TxContext) {}

public fun mint_hero(name: String, registry: &mut HeroRegistry, ctx: &mut TxContext): Hero {
    let freshHero = Hero {
        id: object::new(ctx), // creates a new UID
        name,
        medals: vector::empty<Medal>(),
    };
    // Emit HeroMinted event
    let event: HeroMinted = HeroMinted {
        hero_id: object::id(&freshHero),
        owner: ctx.sender(),
    };

    registry.heroes.push_back(object::id(&freshHero));

    freshHero
}

public fun mint_and_keep_hero(name: String, registry: &mut HeroRegistry, ctx: &mut TxContext) {
    let hero = mint_hero(name, registry, ctx);
    transfer::transfer(hero, ctx.sender());
}

fun award_medal_of_honor(hero: &mut Hero, medalStorage: &mut MedalStorage, medalName: String) {
    // let medalIndex = vector::index_of(&medalStorage.medals, |medal: &Medal| {
    //     // medal.name == medalName
    // });
    let medalIndex = option::none<u64>(); // Placeholder for Option<u64> index found
    if (option::is_none(&medalIndex)) {
        abort EMedalOfHonorNotAvailable;
    }
    let index = option::extract(medalIndex);
}


fun nameTest(hero: &mut Hero){
    

}


/////// Tests ///////

#[test_only]
use sui::test_scenario as ts;
#[test_only]
use sui::test_scenario::{take_shared, return_shared};
#[test_only]
use sui::test_utils::{destroy};
#[test_only]
use std::unit_test::assert_eq;

//--------------------------------------------------------------
//  Test 1: Hero Creation
//--------------------------------------------------------------
//  Objective: Verify the correct creation of a Hero object.
//  Tasks:
//      1. Complete the test by calling the `mint_hero` function with a hero name.
//      2. Assert that the created Hero's name matches the provided name.
//      3. Properly clean up the created Hero object using `destroy`.
//--------------------------------------------------------------
#[test]
fun test_hero_creation() {
    let mut test = ts::begin(@USER);
    init(test.ctx());
    test.next_tx(@USER);

    //Get hero Registry

    let hero = mint_hero(b"Flash".to_string(), test.ctx());
    assert_eq!(hero.name, b"Flash".to_string());

    destroy(hero);
    test.end();
}

//--------------------------------------------------------------
//  Test 2: Event Emission
//--------------------------------------------------------------
//  Objective: Implement event emission during hero creation and verify its correctness.
//  Tasks:
//      1. Define a `HeroMinted` event struct with appropriate fields (e.g., hero ID, owner address).  Remember to add `copy, drop` abilities!
//      2. Emit the `HeroMinted` event within the `mint_hero` function after creating the Hero.
//      3. In this test, capture emitted events using `event::events_by_type<HeroMinted>()`.
//      4. Assert that the number of emitted `HeroMinted` events is 1.
//      5. Assert that the `owner` field of the emitted event matches the expected address (e.g., @USER).
//--------------------------------------------------------------




#[test]
fun test_event_thrown() { 
    let HeroMinted { hero_id: _, owner } = event::events_by_type<>()[0];
     assert_eq!(owner, @USER);



    assert_eq!(1, 1); 
    assert_eq!(2, 2)
    
    
}


#[test_only]




//--------------------------------------------------------------
//  Test 3: Medal Awarding
//--------------------------------------------------------------
//  Objective: Implement medal awarding functionality to heroes and verify its effects.
//  Tasks:
//      1. Define a `Medal` struct with appropriate fields (e.g., medal ID, medal name). Remember to add `key, store` abilities!
//      2. Add a `medals: vector<Medal>` field to the `Hero` struct to store the medals a hero has earned.
//      3. Create functions to award medals to heroes, e.g., `award_medal_of_honor(hero: &mut Hero)`.
//      4. In this test, mint a hero.
//      5. Award a specific medal (e.g., Medal of Honor) to the hero using your `award_medal_of_honor` function.
//      6. Assert that the hero's `medals` vector now contains the awarded medal.
//      7. Consider creating a shared `MedalStorage` object to manage the available medals.
//--------------------------------------------------------------
#[test]
fun test_medal_award() { assert_eq!(1, 1); }
