@REQ_CHAPTER-1 @HU1 @obtener_personajes @testuser @Agente2 @E2 @iniciativa_personajes
Feature: CHAPTER-1 Obtener todos los personajes (microservicio para consulta de personajes)

  Background:
    * url port_testuser
    * path '/testuser/api/characters'

  # Escenario: Obtener todos los personajes (GET /testuser/api/characters)
  @id:1 @obtenerPersonajes @respuestaExitosa200
  Scenario: T-API-CHAPTER-1-CA01-Obtener personajes exitosamente 200 - karate
    When method GET
    Then status 200
    And match response != null
    And match response[0].id != null

  @id:2 @obtenerPersonajesError @errorInterno500
  Scenario: T-API-CHAPTER-1-CA02-Obtener personajes con error interno 500 - karate
    * path '/'
    * param forceError = 'true'
    When method GET
    Then status 500
    And match response.error == 'Internal server error'

  # Escenario: Obtener personaje por ID (GET /testuser/api/characters/{id})
  @id:3 @obtenerPersonajePorId @respuestaExitosa200
  Scenario Outline: T-API-CHAPTER-1-CA03-Obtener personaje por ID <id> exitosamente 200 - karate
    * path '/' + <id>
    When method GET
    Then status 200
    And match response != null
    And match response.id == <id>
    And match response.name == '<nombre>'
    And match response.alterego == '<alterego>'

    Examples:
      | id | nombre     | alterego     |
      | 1544 | Super Hero Test 451 | Cristian Ruiz |

  @id:4 @obtenerPersonajePorIdNoEncontrado @noEncontrado404
  Scenario Outline: T-API-CHAPTER-1-CA04-Obtener personaje por ID <id> no encontrado 404 - karate
    * path '/' + <id>
    When method GET
    Then status 404
    And match response.error == 'Character not found'

    Examples:
      | id   |
      | 9999 |