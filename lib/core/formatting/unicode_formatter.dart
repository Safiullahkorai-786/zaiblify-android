enum ZaibStyle {
  bold, italic, boldItalic, script, doubleStruck, fraktur, smallCaps,
  fullwidth, bubble, reverse, upsideDown, underline, strikethrough, monospace,
}

class UnicodeFormatter {
  static String apply(String input, ZaibStyle style) {
    switch (style) {
      case ZaibStyle.bold: return _math(input, 0x1d400, 0x1d41a);
      case ZaibStyle.italic: return _math(input, 0x1d434, 0x1d44e);
      case ZaibStyle.boldItalic: return _math(input, 0x1d468, 0x1d482);
      case ZaibStyle.monospace: return _math(input, 0x1d670, 0x1d68a, digits: true);
      case ZaibStyle.script: return _table(input, _script);
      case ZaibStyle.doubleStruck: return _table(input, _doubleStruck);
      case ZaibStyle.fraktur: return _table(input, _fraktur);
      case ZaibStyle.smallCaps: return input.split('').map((c) => _smallCaps[c.toLowerCase()] ?? c).join();
      case ZaibStyle.fullwidth: return input.runes.map((r) => r == 32 ? 0x3000 : (r >= 33 && r <= 126 ? r + 0xfee0 : r)).map(String.fromCharCode).join();
      case ZaibStyle.bubble: return _table(input, _bubble);
      case ZaibStyle.reverse: return input.runes.toList().reversed.map(String.fromCharCode).join();
      case ZaibStyle.upsideDown: return input.runes.toList().reversed.map((r) => _upsideDown[String.fromCharCode(r)] ?? String.fromCharCode(r)).join();
      case ZaibStyle.underline: return input.split('').map((c) => '$c\u0332').join();
      case ZaibStyle.strikethrough: return input.split('').map((c) => '$c\u0336').join();
    }
  }

  static String _table(String input, Map<String, String> table) => input.split('').map((c) => table[c] ?? table[c.toLowerCase()] ?? c).join();

  static String _math(String input, int upperStart, int lowerStart, {bool digits = false}) {
    final out = StringBuffer();
    for (final r in input.runes) {
      if (digits && r >= 48 && r <= 57) { out.write(String.fromCharCode(0x1d7f6 + r - 48)); continue; }
      if (r >= 65 && r <= 90) { out.write(String.fromCharCode(upperStart + r - 65)); continue; }
      if (r >= 97 && r <= 122) { out.write(String.fromCharCode(lowerStart + r - 97)); continue; }
      out.write(String.fromCharCode(r));
    }
    return out.toString();
  }

  static const _script = {'H':'ℋ','e':'ℯ','l':'ℓ','o':'ℴ','B':'ℬ','E':'ℰ','F':'ℱ','I':'ℐ','L':'ℒ','M':'ℳ','R':'ℛ','a':'𝒶','b':'𝒷','c':'𝒸','d':'𝒹','f':'𝒻','g':'ℊ','h':'𝒽','i':'𝒾','j':'𝒿','k':'𝓀','m':'𝓂','n':'𝓃','p':'𝓅','q':'𝓆','r':'𝓇','s':'𝓈','t':'𝓉','u':'𝓊','v':'𝓋','w':'𝓌','x':'𝓍','y':'𝓎','z':'𝓏'};
  static const _doubleStruck = {'C':'ℂ','H':'ℍ','N':'ℕ','P':'ℙ','Q':'ℚ','R':'ℝ','Z':'ℤ','a':'𝕒','b':'𝕓','c':'𝕔','d':'𝕕','e':'𝕖','f':'𝕗','g':'𝕘','h':'𝕙','i':'𝕚','j':'𝕛','k':'𝕜','l':'𝕝','m':'𝕞','n':'𝕟','o':'𝕠','p':'𝕡','q':'𝕢','r':'𝕣','s':'𝕤','t':'𝕥','u':'𝕦','v':'𝕧','w':'𝕨','x':'𝕩','y':'𝕪','z':'𝕫'};
  static const _fraktur = {'C':'ℭ','H':'ℌ','I':'ℑ','R':'ℜ','Z':'ℨ','a':'𝔞','b':'𝔟','c':'𝔠','d':'𝔡','e':'𝔢','f':'𝔣','g':'𝔤','h':'𝔥','i':'𝔦','j':'𝔧','k':'𝔨','l':'𝔩','m':'𝔪','n':'𝔫','o':'𝔬','p':'𝔭','q':'𝔮','r':'𝔯','s':'𝔰','t':'𝔱','u':'𝔲','v':'𝔳','w':'𝔴','x':'𝔵','y':'𝔶','z':'𝔷'};
  static const _smallCaps = {'a':'ᴀ','b':'ʙ','c':'ᴄ','d':'ᴅ','e':'ᴇ','f':'ꜰ','g':'ɢ','h':'ʜ','i':'ɪ','j':'ᴊ','k':'ᴋ','l':'ʟ','m':'ᴍ','n':'ɴ','o':'ᴏ','p':'ᴘ','q':'ǫ','r':'ʀ','t':'ᴛ','u':'ᴜ','v':'ᴠ','w':'ᴡ','y':'ʏ','z':'ᴢ'};
  static const _bubble = {'A':'Ⓐ','B':'Ⓑ','C':'Ⓒ','D':'Ⓓ','E':'Ⓔ','F':'Ⓕ','G':'Ⓖ','H':'Ⓗ','I':'Ⓘ','J':'Ⓙ','K':'Ⓚ','L':'Ⓛ','M':'Ⓜ','N':'Ⓝ','O':'Ⓞ','P':'Ⓟ','Q':'Ⓠ','R':'Ⓡ','S':'Ⓢ','T':'Ⓣ','U':'Ⓤ','V':'Ⓥ','W':'Ⓦ','X':'Ⓧ','Y':'Ⓨ','Z':'Ⓩ','a':'ⓐ','b':'ⓑ','c':'ⓒ','d':'ⓓ','e':'ⓔ','f':'ⓕ','g':'ⓖ','h':'ⓗ','i':'ⓘ','j':'ⓙ','k':'ⓚ','l':'ⓛ','m':'ⓜ','n':'ⓝ','o':'ⓞ','p':'ⓟ','q':'ⓠ','r':'ⓡ','s':'ⓢ','t':'ⓣ','u':'ⓤ','v':'ⓥ','w':'ⓦ','x':'ⓧ','y':'ⓨ','z':'ⓩ'};
  static const _upsideDown = {'a':'ɐ','b':'q','c':'ɔ','d':'p','e':'ǝ','f':'ɟ','g':'ƃ','h':'ɥ','i':'ᴉ','j':'ɾ','k':'ʞ','l':'ʃ','m':'ɯ','n':'u','r':'ɹ','t':'ʇ','v':'ʌ','w':'ʍ','y':'ʎ','!':'¡','?':'¿','.':'˙',',':'\'', '(' : ')', ')' : '('};
}
