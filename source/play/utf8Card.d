module play.utfCard;

import play.Cards;

uint cardIndex(const Card card) pure nothrow {
	return card.colour*15+(1+card.rank); 
}

	// https://en.wikipedia.org/wiki/Playing_cards_in_Unicode
dchar utf8card(const Card card) pure nothrow {
	enum baseUtf = ["\u1F0A0", "\u1F0B0", "\u1F0C0","\u1F0D0"]; 
 pragma(msg, typeof(baseUtf));
	return dchar(0);	
}
