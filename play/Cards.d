module play.Cards;

import std.traits : EnumMembers;
import std.random;

enum Colours {
    heart,
    diamond,
    spade,
}

enum Ranks {
    Ace,
    One,
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

struct Card {
    Colours colour;
    Ranks rank;
}

struct Deck {
    protected Card[EnumMembers!Colours.length * EnumMembers!Ranks.length] cards;
    protected size_t top_card;
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
    }
}
