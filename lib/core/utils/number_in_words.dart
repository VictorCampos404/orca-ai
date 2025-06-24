// import 'dart:math';

/// Converte um número (double) para sua representação por extenso em reais.
class NumberInWords {
  // --- Listas e Mapas de Nomes ---
  // Usamos listas para facilitar o acesso pelo índice do número.

  static const List<String> _unidades = [
    "",
    "um",
    "dois",
    "três",
    "quatro",
    "cinco",
    "seis",
    "sete",
    "oito",
    "nove",
  ];

  static const List<String> _dezenasEspeciais = [
    "dez",
    "onze",
    "doze",
    "treze",
    "quatorze",
    "quinze",
    "dezesseis",
    "dezessete",
    "dezoito",
    "dezenove",
  ];

  static const List<String> _dezenas = [
    "",
    "",
    "vinte",
    "trinta",
    "quarenta",
    "cinquenta",
    "sessenta",
    "setenta",
    "oitenta",
    "noventa",
  ];

  static const List<String> _centenas = [
    "",
    "cento",
    "duzentos",
    "trezentos",
    "quatrocentos",
    "quinhentos",
    "seiscentos",
    "setecentos",
    "oitocentos",
    "novecentos",
  ];

  /// Método principal que recebe um double e retorna a string por extenso.
  String write(double numero) {
    if (numero == 0) {
      return "zero reais";
    }

    // 1. Separa a parte inteira e a parte decimal (centavos)
    final int parteInteira = numero.truncate();
    final int parteDecimal = ((numero - parteInteira) * 100).round();

    // Converte cada parte para texto
    final String extensoInteiro = _converterInteiro(parteInteira);
    final String extensoDecimal = _converterDecimal(parteDecimal);

    // Formata a moeda (real/reais, centavo/centavos)
    final String moedaInteiro = _getTerminacaoMoeda(
      parteInteira,
      'real',
      'reais',
    );
    final String moedaDecimal = _getTerminacaoMoeda(
      parteDecimal,
      'centavo',
      'centavos',
    );

    // Junta as partes
    String resultado = "";

    if (parteInteira > 0) {
      resultado = "$extensoInteiro $moedaInteiro";
    }

    if (parteDecimal > 0) {
      if (parteInteira > 0) {
        resultado += " e ";
      }
      resultado += "$extensoDecimal $moedaDecimal";
    }

    return resultado.trim();
  }

  /// Converte a parte inteira do número em texto por extenso.
  String _converterInteiro(int numero) {
    if (numero == 0) return "";
    if (numero == 1000000) return "um milhão";

    List<String> partes = [];
    int contadorClasses = 0;

    // 2. Divide o número em classes de 3 dígitos (milhar, milhão, etc.)
    while (numero > 0) {
      int grupoDeTres = numero % 1000;
      if (grupoDeTres > 0) {
        String textoGrupo = _escreverCentena(grupoDeTres);
        String classe = _getClasse(contadorClasses, grupoDeTres);
        partes.add("$textoGrupo $classe".trim());
      }
      numero = numero ~/ 1000;
      contadorClasses++;
    }

    // 3. Junta as classes com "e" e vírgulas de forma inteligente
    return _juntarPartes(partes.reversed.toList());
  }

  /// Converte a parte decimal (centavos) para texto.
  String _converterDecimal(int numero) {
    if (numero == 0) return "";
    return _escreverCentena(numero);
  }

  /// O coração da lógica: converte um número de 1 a 999 para texto.
  String _escreverCentena(int n) {
    if (n < 1 || n > 999) return "";

    if (n == 100) return "cem";

    List<String> p = [];
    int c = n ~/ 100;
    int resto = n % 100;

    if (c > 0) {
      p.add(_centenas[c]);
    }

    if (resto > 0) {
      if (c > 0) p.add("e"); // ex: "cento E vinte"

      if (resto < 10) {
        p.add(_unidades[resto]);
      } else if (resto < 20) {
        p.add(_dezenasEspeciais[resto - 10]);
      } else {
        int d = resto ~/ 10;
        int u = resto % 10;
        p.add(_dezenas[d]);
        if (u > 0) {
          p.add("e"); // ex: "vinte E cinco"
          p.add(_unidades[u]);
        }
      }
    }
    return p.join(" ");
  }

  /// Retorna o nome da classe (mil, milhão) no singular ou plural.
  String _getClasse(int contador, int valor) {
    const classesSingular = ["", "mil", "milhão", "bilhão"];
    const classesPlural = ["", "mil", "milhões", "bilhões"];

    if (contador == 0) return "";
    return valor == 1 ? classesSingular[contador] : classesPlural[contador];
  }

  /// Retorna a terminação da moeda (singular ou plural).
  String _getTerminacaoMoeda(int valor, String singular, String plural) {
    if (valor == 0) return "";
    return valor == 1 ? singular : plural;
  }

  /// Junta as partes do número (ex: "um milhão", "duzentos mil", "cem") com "e" e vírgulas.
  String _juntarPartes(List<String> partes) {
    String resultado = partes.join(", ");

    // Substitui a última vírgula por " e " se a lógica permitir.
    int ultimoIndiceVirgula = resultado.lastIndexOf(',');
    if (ultimoIndiceVirgula != -1) {
      // Regra: "mil e cem", "mil e um", mas não "mil, e duzentos"
      String parteFinal = resultado.substring(ultimoIndiceVirgula + 2);
      List<String> palavrasFinais = parteFinal.split(' ');

      // Se a parte final for um número menor que 100 ou um múltiplo de 100, usamos "e"
      if (palavrasFinais.length <= 2 && !parteFinal.contains("cento")) {
        resultado =
            "${resultado.substring(0, ultimoIndiceVirgula)} e${resultado.substring(ultimoIndiceVirgula + 1)}";
      }
    }

    return resultado;
  }
}
