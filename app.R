library(shiny)

ui <- navbarPage("Taller de Epistemología y Metodología",
                                  
                                  tags$head(
                                    tags$style(HTML("
                     
                     /* Botones normales */
                     .btn,
                     .btn-default,
                     .btn-primary {
                       background-color: #90EE90 !important;
                       border-color: #90EE90 !important;
                       color: black !important;
                       background-image: none !important;
                     }
                     
                     /* Estados hover, focus y active */
                     .btn:hover,
                     .btn:focus,
                     .btn:active,
                     .btn-default:hover,
                     .btn-default:focus,
                     .btn-default:active,
                     .btn-primary:hover,
                     .btn-primary:focus,
                     .btn-primary:active {
                       background-color: #90EE90 !important;
                       border-color: #90EE90 !important;
                       color: black !important;
                       box-shadow: none !important;
                       outline: none !important;
                     }
                     
                   "))
                                  ),                 
                 tabPanel("Capítulo I: Epistemología y Metodología",
                          
                          h3("La articulación del campo epistemológico y metodológico"),
                          p("La coherencia entre teoría (epistemología) y herramientas (metodología) es esencial en la investigación científica."),
                          br(),
                          # --- Quiz ampliado ---
                          h4("Quiz interactivo"),
                          br(),
                          radioButtons("q1", "1) ¿Qué significa articular epistemología y metodología?",
                                       choices = list(
                                         "Combinar teorías sin conexión" = "a",
                                         "Lograr coherencia entre teoría y método" = "b",
                                         "Aplicar técnicas sin marco teórico" = "c"
                                       ), selected = character(0)),
                          br(),
                          radioButtons("q2", "2) ¿Qué ocurre si no hay coherencia?",
                                       choices = list(
                                         "Los resultados pueden ser inválidos" = "a",
                                         "Aumenta la validez" = "b",
                                         "No cambia nada" = "c"
                                       ), selected = character(0)),
                          br(),
                          radioButtons("q3", "3) ¿Cuál es la función de la metodología?",
                                       choices = list(
                                         "Reflexionar sobre los métodos usados" = "a",
                                         "Ignorar la epistemología" = "b",
                                         "Reemplazar la teoría" = "c"
                                       ), selected = character(0)),
                          actionButton("submitQuiz", "Responder"),
                          textOutput("feedbackQuiz"),
                          br(),
                          br(),
                          # --- Flashcards ---
                          h4("Flashcards de repaso"),
                          actionButton("nextCard", "Mostrar siguiente concepto"),
                          textOutput("flashcard"),
                          br(),
                          # --- Actividad práctica ---
                          h4("Actividad práctica"),
                          p("Caso: Una investigación sobre corrupción se limita a encuestas de opinión."),
                          actionButton("sol2", "Ver respuesta sugerida"),
                          textOutput("resp2"),
                          br(),
                          # --- Ejercicio de reflexión con descarga ---
                          h4("Ejercicio de reflexión"),
                          textAreaInput("reflexion", "Escribe brevemente cómo aplicarías la articulación epistemología-metodología en tu campo de estudio:", width = "100%", height = "100px"),
                          downloadButton("descargarReflexion", "Descargar reflexión en .txt"),
                          br(),
                          br(),
                          br(),
                          # --- Verdadero/Falso ---
                          h4("Actividad de verdadero/falso"),
                          checkboxGroupInput("vf", "Marca las afirmaciones correctas:",
                                             choices = list(
                                               "El conocimiento científico es asistemático" = "a",
                                               "La epistemología analiza la validez del conocimiento" = "b",
                                               "La metodología ignora los paradigmas" = "c",
                                               "El conocimiento cotidiano es espontáneo" = "d"
                                             )),
                          actionButton("submitVF", "Verificar"),
                          textOutput("feedbackVF"),
                          br(),br(),
                          # --- Asociación múltiple ---
                          h4("Asociación de conceptos"),
                          selectInput("asoc1", "La epistemología se centra en:", 
                                      choices = c("", "Validez del conocimiento", "Diseño de encuestas", "Recolección de datos")),
                          selectInput("asoc2", "La metodología se centra en:", 
                                      choices = c("", "Estrategias y procedimientos", "Objeto filosófico del conocimiento", "Valores implicados en la ciencia")),
                          actionButton("submitAsoc", "Verificar respuestas"),
                          textOutput("feedbackAsoc"),
                          br(),br(),
                          # --- Mini caso crítico ---
                          h4("Mini caso crítico"),
                          p("Un investigador afirma que su estudio es 'científico' porque aplicó una encuesta a 20 personas sin marco teórico."),
                          radioButtons("casoCritico", "¿Qué problema epistemológico-metodológico aparece?",
                                       choices = list(
                                         "Falta de coherencia entre teoría y método" = "a",
                                         "Exceso de validez" = "b",
                                         "Uso correcto de metodología" = "c"
                                       ), selected = character(0)),
                          actionButton("submitCasoCritico", "Responder"),
                          textOutput("feedbackCasoCritico")
                 )
)

server <- function(input, output, session) {
  
  # --- Quiz feedback ---
  observeEvent(input$submitQuiz, {
    if (input$q1 == "b" && input$q2 == "a" && input$q3 == "a") {
      output$feedbackQuiz <- renderText("¡Correcto! Has comprendido la articulación epistemología-metodología.")
    } else {
      output$feedbackQuiz <- renderText("Revisa los conceptos: la coherencia y la función reflexiva de la metodología son esenciales.")
    }
  })
  
  # --- Flashcards ---
  flashcards <- c(
    "Epistemología: estudio del conocimiento y su validez.",
    "Metodología: estrategias y procedimientos para producir conocimiento.",
    "Ciencia: conjunto de conocimientos sistemáticamente estructurados.",
    "Proceso de investigación: generación de conocimiento científico."
  )
  
  currentCard <- reactiveVal(1)
  
  observeEvent(input$nextCard, {
    current <- currentCard()
    if (current < length(flashcards)) {
      currentCard(current + 1)
    } else {
      currentCard(1)
    }
    output$flashcard <- renderText(flashcards[currentCard()])
  })
  
  # --- Actividad práctica ---
  observeEvent(input$sol2, {
    output$resp2 <- renderText("Respuesta sugerida: Limitarse a encuestas de opinión sin un marco teórico sólido ni triangulación metodológica reduce la validez de la investigación. Se requiere articular epistemología y metodología para obtener resultados consistentes.")
  })
  
  # --- Reflexión con descarga ---
  output$descargarReflexion <- downloadHandler(
    filename = function() {
      paste("reflexion_epistemologia.txt")
    },
    content = function(file) {
      writeLines(input$reflexion, file)
    }
  )
  
  # --- Verdadero/Falso ---
  observeEvent(input$submitVF, {
    correct <- c("b","d")
    if (all(input$vf %in% correct) && length(input$vf) == length(correct)) {
      output$feedbackVF <- renderText("¡Correcto! Has identificado bien las afirmaciones.")
    } else {
      output$feedbackVF <- renderText("Revisa tus respuestas: recuerda que el conocimiento científico es sistemático y la epistemología analiza la validez.")
    }
  })
  
  # --- Asociación de conceptos ---
  observeEvent(input$submitAsoc, {
    if (input$asoc1 == "Validez del conocimiento" && input$asoc2 == "Estrategias y procedimientos") {
      output$feedbackAsoc <- renderText("¡Correcto! Epistemología = validez del conocimiento; Metodología = estrategias y procedimientos.")
    } else {
      output$feedbackAsoc <- renderText("Revisa tus respuestas: recuerda que epistemología se centra en la validez del conocimiento y metodología en los procedimientos.")
    }
  })
  
  # --- Mini caso crítico ---
  observeEvent(input$submitCasoCritico, {
    if (input$casoCritico == "a") {
      output$feedbackCasoCritico <- renderText("¡Correcto! El problema es la falta de coherencia entre teoría y método.")
    } else {
      output$feedbackCasoCritico <- renderText("Revisa: el problema central es la incoherencia epistemológica-metodológica.")
    }
  })
}

shinyApp(ui, server)
