import 'dart:convert';

import 'package:orca_ai/core/clients/gemini_client.dart';
import 'package:orca_ai/data/datasources/post_gemini/post_gemini_datasource.dart';
import 'package:orca_ai/data/dtos/doc_dto.dart';

class PostGeminiImpDatasource implements PostGeminiDatasource {
  final GeminiClient _client;

  PostGeminiImpDatasource(this._client);

  @override
  Future<DocDto> call({required String prompt}) async {
    final text = """
        **Atue como um assistente especialista em criar propostas comerciais.**

        Sua tarefa é analisar o texto fornecido pelo usuário, que descreve um serviço, e converter essas informações em um objeto JSON estruturado para um orçamento.

        **Siga estas regras rigorosamente:**
        1.  **Formato da Resposta:** A sua resposta final deve conter **exclusivamente** o objeto JSON. Não inclua absolutamente nenhum texto antes ou depois do JSON, nem utilize blocos de código markdown (```json).
        2.  **Extração de Dados:**
            * **`ac`**: Extraia o nome da pessoa ou empresa a quem o orçamento se destina. Se não for mencionado, o valor deve ser `null`.
            * **`value`**: Extraia o valor numérico do serviço e formate-o como moeda brasileira (ex: "R\$ 5.000,00").
        3.  **Criação e Aprimoramento de Dados:**
            * **`title`**: Crie um título profissional e conciso para o orçamento. Exemplo: "Proposta de Desenvolvimento de Aplicativo Mobile".
            * **`description`**: Pegue a descrição do serviço fornecida e aprimore-a. Torne-a mais clara, profissional e detalhada, destacando os pontos principais do serviço a ser prestado.

        **Estrutura Obrigatória do JSON de Saída:**
        ```json
        {
          "title": "string",
          "ac": "string | null",
          "description": "string",
          "value": "string" | null,
        }

        Texto do user a ser analisado:
        $prompt
      """;

    final response = await _client.post(
      url: "/v1beta/models/gemini-2.0-flash:generateContent",
      body: {
        "contents": [
          {
            "parts": [
              {"text": text},
            ],
          },
        ],
      },
    );

    String jsonString =
        response.data['candidates']?[0]?['content']?['parts']?[0]?['text']
            ?.toString() ??
        "";

    jsonString =
        jsonString.replaceAll("```json", "").replaceAll("```", "").trim();

    final json = jsonDecode(jsonString);

    return DocDto.fromMap(json);
  }
}
