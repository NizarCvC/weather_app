import 'dart:convert';

class LocalNames {
  final String? kn;
  final String? hi;
  final String? featureName;
  final String? sr;
  final String? pt;
  final String? zh;
  final String? it;
  final String? he;
  final String? ur;
  final String? fi;
  final String? ru;
  final String? ar;
  final String? eo;
  final String? ko;
  final String? eu;
  final String? en;
  final String? fa;
  final String? ms;
  final String? cs;
  final String? de;
  final String? ku;
  final String? ml;
  final String? fr;
  final String? tr;
  final String? lt;
  final String? ascii;
  final String? et;
  final String? es;

  LocalNames({
    this.kn,
    this.hi,
    this.featureName,
    this.sr,
    this.pt,
    this.zh,
    this.it,
    this.he,
    this.ur,
    this.fi,
    this.ru,
    this.ar,
    this.eo,
    this.ko,
    this.eu,
    this.en,
    this.fa,
    this.ms,
    this.cs,
    this.de,
    this.ku,
    this.ml,
    this.fr,
    this.tr,
    this.lt,
    this.ascii,
    this.et,
    this.es,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kn': kn,
      'hi': hi,
      'featureName': featureName,
      'sr': sr,
      'pt': pt,
      'zh': zh,
      'it': it,
      'he': he,
      'ur': ur,
      'fi': fi,
      'ru': ru,
      'ar': ar,
      'eo': eo,
      'ko': ko,
      'eu': eu,
      'en': en,
      'fa': fa,
      'ms': ms,
      'cs': cs,
      'de': de,
      'ku': ku,
      'ml': ml,
      'fr': fr,
      'tr': tr,
      'lt': lt,
      'ascii': ascii,
      'et': et,
      'es': es,
    };
  }

  factory LocalNames.fromMap(Map<String, dynamic> map) {
    return LocalNames(
      kn: map['kn'] != null ? map['kn'] as String : null,
      hi: map['hi'] != null ? map['hi'] as String : null,
      featureName: map['featureName'] != null ? map['featureName'] as String : null,
      sr: map['sr'] != null ? map['sr'] as String : null,
      pt: map['pt'] != null ? map['pt'] as String : null,
      zh: map['zh'] != null ? map['zh'] as String : null,
      it: map['it'] != null ? map['it'] as String : null,
      he: map['he'] != null ? map['he'] as String : null,
      ur: map['ur'] != null ? map['ur'] as String : null,
      fi: map['fi'] != null ? map['fi'] as String : null,
      ru: map['ru'] != null ? map['ru'] as String : null,
      ar: map['ar'] != null ? map['ar'] as String : null,
      eo: map['eo'] != null ? map['eo'] as String : null,
      ko: map['ko'] != null ? map['ko'] as String : null,
      eu: map['eu'] != null ? map['eu'] as String : null,
      en: map['en'] != null ? map['en'] as String : null,
      fa: map['fa'] != null ? map['fa'] as String : null,
      ms: map['ms'] != null ? map['ms'] as String : null,
      cs: map['cs'] != null ? map['cs'] as String : null,
      de: map['de'] != null ? map['de'] as String : null,
      ku: map['ku'] != null ? map['ku'] as String : null,
      ml: map['ml'] != null ? map['ml'] as String : null,
      fr: map['fr'] != null ? map['fr'] as String : null,
      tr: map['tr'] != null ? map['tr'] as String : null,
      lt: map['lt'] != null ? map['lt'] as String : null,
      ascii: map['ascii'] != null ? map['ascii'] as String : null,
      et: map['et'] != null ? map['et'] as String : null,
      es: map['es'] != null ? map['es'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalNames.fromJson(String source) => LocalNames.fromMap(json.decode(source) as Map<String, dynamic>);
}
