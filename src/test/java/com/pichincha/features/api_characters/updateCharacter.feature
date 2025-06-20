@REQ_CHAPTER-1 @HU1 @obtener_personajes @testuser @Agente2 @E2 @iniciativa_personajes
Feature: CHAPTER-1 Obtener todos los personajes (microservicio para consulta de personajes)

  Background:
    * url port_testuser
    * path '/testuser/api/characters'
    * def requestBody = read('classpath:data/api_characters/request_update.json')

  @id:9 @actualizarPersonaje @respuestaExitosa200
  Scenario: T-API-CHAPTER-1-CA09-Actualizar personaje exitosamente 200 - karate
    * def characters = call read('classpath:com/pichincha/features/api_characters/getCharacters.feature@obtenerPersonajes')
    And print characters
    * def existente = karate.filter(characters.response, function(x){ return x.name == requestBody.name })
    * if (existente.length == 0) existente[0] = karate.call('classpath:com/pichincha/features/api_characters/createCharacter.feature@crearPersonaje').response
    * path '/' + existente[0].id
    And request requestBody
    When method PUT
    Then status 200
    And match response.alterego == requestBody.alterego

  @id:10 @actualizarPersonajeNoExiste @noEncontrado404
  Scenario Outline: T-API-CHAPTER-1-CA10-Actualizar personaje cuando no existe 400 - karate
    * path '/' + <id>
    And request requestBody
    When method PUT
    Then status 404
    And match response.error == '<error>'

    Examples:
      | id | error     |
      | 9999 | Character not found |

