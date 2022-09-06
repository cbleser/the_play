module play.Cards;

import std.traits : EnumMembers;
import std.random;
import std.range : zip;
import std.algorithm.searching : count;

enum Colours {
    heart,
    diamond,
    spade,
	club,
}

enum Ranks {
    Ace,
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Ten,
    Knight,
    Dame,
    King,
}

@safe
struct Card {
    Colours colour;
    Ranks rank;
}

@safe
struct Deck {
pragma(msg, EnumMembers!Colours.length); 
pragma(msg, [EnumMembers!Colours].length); 
protected {
        Card[EnumMembers!Colours.length * EnumMembers!Ranks.length] cards;
        size_t top_card;
    }
    @disable this();
    this(const size_t times) {
        size_t index;
        foreach (c; EnumMembers!Colours) {
            foreach (r; EnumMembers!Ranks) {
                cards[index++] = Card(c, r);
            }
        }
        shuffle(times);
    }

    private void shuffle(const size_t times) {
        import std.algorithm.mutation : swap;

        auto rnd = Random(unpredictableSeed);
        const random_shufflie = () => uniform(0, cards.length, rnd);
        foreach (i; 0 .. times) {
            const shuffle_from = random_shufflie();
            const shuffle_to = random_shufflie();
            if (shuffle_from != shuffle_to) {
                swap(cards[shuffle_from], cards[shuffle_to]);
            }
        }
    }

    pure nothrow @nogc {
        bool empty() const {
            return top_card >= cards.length;
        }

        const(Card) front() const {
            return cards[top_card];
        }

        void popFront() {
            top_card++;
        }

        uint correlate(const Deck rhs) const {
            return zip(cards[], rhs.cards[])
                .count!(m => m[0] == m[1]) & uint.max;
        }
    }
}

@safe
unittest {
	import std.stdio;
    const standard_deck = Deck(0);
    //   foreach (i; 0 .. 100) {
    foreach (s; 0 .. 10_000) {
        const new_deck = Deck(s);
        const col = new_deck.correlate(standard_deck);
  	if (s % 100i==0) {
writeln;
			writef("%6d ", s);
		}
	       if (col > 5) {
 write("#");
			//           writefln("s=%d col=%d", s, col);
        ////}
              }
	}
}
