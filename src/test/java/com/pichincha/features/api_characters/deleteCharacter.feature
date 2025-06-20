@REQ_CHAPTER-1 @HU1 @obtener_personajes @testuser @Agente2 @E2 @iniciativa_personajes
Feature: CHAPTER-1 Obtener todos los personajes (microservicio para consulta de personajes)

  Background:
    * url port_testuser
    * path '/testuser/api/characters'

  @id:11 @eliminarPersonaje @respuestaExitosa204
  Scenario: T-API-CHAPTER-1-CA11-Eliminar personaje exitosamente 204 - karate
    * def id = typeof id == 'undefined' ? null : id
    * def requestBody = read('classpath:data/api_characters/request_create.json')
    * def characters = call read('classpath:com/pichincha/features/api_characters/getCharacters.feature@obtenerPersonajes')
    And print characters
    * def existente = karate.filter(characters.response, function(x){ if (id != null) { return x.id == id} else {return x.name == requestBody.name } })
    * if (existente.length == 0 && id == null)  existente[0] =  karate.call('classpath:com/pichincha/features/api_characters/createCharacter.feature@crearPersonaje').response
    * def personaje = existente[0]
    And print personaje
    * path '/' + personaje.id
    When method DELETE
    Then status 204

  @id:12 @eliminarPersonajeNoExiste @noEncontrado404
  Scenario Outline: T-API-CHAPTER-1-CA12-Eliminar personaje cuando no existe 404 - karate
    * path '/' + <id>
    When method DELETE
    Then status 404
    And match response.error == '<error>'

    Examples:
      | id | error     |
      | 9999 | Character not found |

