@REQ_CHAPTER-1 @HU1 @obtener_personajes @testuser @Agente2 @E2 @iniciativa_personajes
Feature: CHAPTER-1 Obtener todos los personajes (microservicio para consulta de personajes)

  Background:
    * url port_testuser
    * path '/testuser/api/characters'
    * def requestBody = read('classpath:data/api_characters/request_create.json')

  @id:6 @crearPersonaje @respuestaExitosa201
  Scenario: T-API-CHAPTER-1-CA06-Crear personaje exitosamente 200 - karate
    * def characters = call read('classpath:com/pichincha/features/api_characters/getCharacters.feature@obtenerPersonajes')
    * def existente = karate.filter(characters.response, function(x){ return x.name == requestBody.name })
    And print existente
    * if (existente.length > 0) karate.call('classpath:com/pichincha/features/api_characters/deleteCharacter.feature@eliminarPersonaje', { id: existente[0].id })
    And request requestBody
    When method POST
    Then status 201
    And match response.id != null

  @id:7 @crearPersonajeNombreDuplicado @noEncontrado400
  Scenario Outline: T-API-CHAPTER-1-CA07-Crear personaje cuando el nombre es duplicado 400 - karate
    And request requestBody
    When method POST
    Then status 400
    And match response.error == '<error>'

    Examples:
      | error   |
      | Character name already exists |

  @id:8 @crearPersonajeCampoVacio @noEncontrado400
  Scenario: T-API-CHAPTER-1-CA08-Crear personaje cuando un campo es vacio 400 - karate
    * set requestBody.name = ""
    And request requestBody
    When method POST
    Then status 400
    And match response.name == 'Name is required'
