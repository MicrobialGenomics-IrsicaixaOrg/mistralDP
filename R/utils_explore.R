#' Create a Slider Input for Categorical Data
#'
#' This function generates a slider input for categorical data stored in a data
#' frame column.
#'
#' @param df A data frame containing the categorical data.
#' @param col The name of the column in the data frame containing the
#'   categorical data.
#' @param ns The namespace for the Shiny app.
#' @param title The title to be displayed above the slider input. If NULL, the
#'   column name will be used.
#'
#' @return A Shiny UI element containing a slider input for selecting
#'   categories.
#' @noRd
#' @examples
#' # Assuming "data" is a data frame containing a column named "Category"
#' ns <- NS("my_app")
#' ui <- fluidPage(
#'   chr_sliderinput(df = data, col = "Category", ns = ns)
#' )
chr_sliderinput <- function(df, col, ns, title = NULL) {
  var <- df %>% dplyr::pull(col) %>% unique()

  if (!(is.character(var) | is.factor(var))) {
    rlang::abort("col must be character or factor")
  }

  if (is.null(title)) {
    title <- stringr::str_replace_all(col, "_", " ") %>% stringr::str_to_title()
  }

  lvls <- as.factor(var) %>% levels()

  tagList(
    h6(title, align = "center"),
    shiny::hr(),
    checkboxGroupInput(
      inputId = ns(col),
      label = NULL,
      choiceNames = stringr::str_replace_all(lvls, "_", " ") %>% stringr::str_to_title(),
      choiceValues = lvls,
      selected = lvls
    )
  )
}

#' Create a Slider Input for Categorical Data
#'
#' This function generates a slider input for categorical data stored in a data
#' frame column.
#'
#' @param df A data frame containing the categorical data.
#' @param col The name of the column in the data frame containing the
#'   categorical data.
#' @param ns The namespace for the Shiny app.
#' @param title The title to be displayed above the slider input. If NULL, the
#'   column name will be used.
#'
#' @return A Shiny UI element containing a slider input for selecting
#'   categories.
#' @noRd
#' @examples
#' # Assuming "data" is a data frame containing a column named "Category"
#' ns <- NS("my_app")
#' ui <- fluidPage(
#'   chr_sliderinput_2(df = data, col = "Category", ns = ns)
#' )
chr_sliderinput_2 <- function(df, col, ns, title = NULL) {
  var <- df %>% dplyr::pull(col) %>% unique()

  if (!(is.character(var) | is.factor(var))) {
    rlang::inform(glue::glue("col must be character or factor: {col}"))
    var <- as.factor(var)
  }

  if (is.null(title)) {
    title <- stringr::str_replace_all(col, "_", " ") %>% stringr::str_to_title()
  }

  lvls <- as.factor(var) %>% levels()
  checkboxGroupInput(
    inputId = ns(col),
    label = NULL,
    choiceNames = stringr::str_replace_all(lvls, "_", " ") %>% stringr::str_to_title(),
    choiceValues = lvls,
    selected = lvls,
    inline = TRUE
  )
}

#' Create a Slider Range Input for Numeric Data
#'
#' This function generates a slider range input for numeric data stored in a
#' data frame column.
#'
#' @param df A data frame containing the numeric data.
#' @param col The name of the column in the data frame containing the numeric
#'   data.
#' @param ns The namespace for the Shiny app.
#' @param title The title to be displayed above the slider range input. If NULL,
#'   the column name will be used.
#'
#' @return A Shiny UI element containing a slider range input for selecting
#'   numeric range.
#' @noRd
#' @examples
#' # Assuming "data" is a data frame containing a column named "Age"
#' ns <- NS("my_app")
#' ui <- fluidPage(
#'   num_sliderrange(df = data, col = "Age", ns = ns)
#' )
num_sliderrange <- function(df, col, ns, title = NULL) {
  var <- df %>% dplyr::pull(col)

  if (!is.numeric(var)) {
    rlang::abort("col must be numeric")
  }

  if (is.null(title)) {
    title <- stringr::str_replace_all(col, "_", " ") %>% stringr::str_to_title()
  }

  lvls <- as.factor(var) %>% levels()

  tagList(
    h6(title, align = "center"),
    shiny::hr(),
    shiny::br(),
    # shinyWidgets::setSliderColor(color = "#999999", sliderId = 1),
    sliderInput(
      inputId = ns(col),
      label = NULL,
      min = min(var),
      max = max(var),
      value = c(min(var), max(var)),
      step = 1
    )
  )
}

#' Create a Slider Range Input for Numeric Data
#'
#' This function generates a slider range input for numeric data stored in a
#' data frame column.
#'
#' @param df A data frame containing the numeric data.
#' @param col The name of the column in the data frame containing the numeric
#'   data.
#' @param ns The namespace for the Shiny app.
#' @param title The title to be displayed above the slider range input. If NULL,
#'   the column name will be used.
#'
#' @return A Shiny UI element containing a slider range input for selecting
#'   numeric range.
#' @noRd
#' @examples
#' # Assuming "data" is a data frame containing a column named "Age"
#' ns <- NS("my_app")
#' ui <- fluidPage(
#'   num_sliderrange_2(df = data, col = "Age", ns = ns)
#' )
num_sliderrange_2 <- function(df, col, ns, title = NULL) {
  var <- df %>% dplyr::pull(col)

  if (!is.numeric(var)) {
    rlang::abort("col must be numeric")
  }

  if (is.null(title)) {
    title <- stringr::str_replace_all(col, "_", " ") %>% stringr::str_to_title()
  }

  lvls <- as.factor(var) %>% levels()
  sliderInput(
    inputId = ns(col),
    label = NULL,
    min = min(var),
    max = max(var),
    value = c(min(var), max(var)),
    step = 1
  )
}

#' Transform Units in a Data Frame Column
#'
#' This function transforms the values in a specified column of a data frame to
#' a human-readable format with appropriate units such as B (Bytes), KB
#' (Kilobytes), MB (Megabytes), GB (Gigabytes), and TB (Terabytes).
#'
#' @param df A data frame.
#' @param col A column in the data frame containing the values to be
#'   transformed.
#'
#' @return A data frame with the specified column transformed into a
#'   human-readable format with units.
#' @noRd
#'
#' @examples
#' df <- data.frame(size = c(1500, 500000, 12000000, 5000000000))
#' transformed_df <- transform_units(df, "size")
transform_units <- function(df, col) {
  df %>%
    dplyr::mutate(!!dplyr::sym(col) := dplyr::case_when(
      floor(log10(!!dplyr::sym(col))) >= 12 ~ stringr::str_c(round(!!dplyr::sym(col) / 1e12, 2), "TB"),
      dplyr::between(floor(log10(!!dplyr::sym(col))), 9, 11) ~ stringr::str_c(round(!!dplyr::sym(col) / 1e9, 2), "GB"),
      dplyr::between(floor(log10(!!dplyr::sym(col))), 6, 8) ~ stringr::str_c(round(!!dplyr::sym(col) / 1e6, 2), "MB"),
      dplyr::between(floor(log10(!!dplyr::sym(col))), 3, 5) ~ stringr::str_c(round(!!dplyr::sym(col) / 1e3, 2), "KB"),
      TRUE ~ stringr::str_c(!!dplyr::sym(col), "B")
    ))
}

#' Generate a Pie Chart
#'
#' This function takes a data frame and creates a pie chart to visualize
#' the distribution of a categorical variable.
#'
#' @param df A data frame containing the data.
#' @param group_var The name of the categorical variable to group by.
#' @param count_var The variable used for counting the occurrences.
#' @param title The title of the pie chart.
#' @param source_id The source identifier for the chart.
#'
#' @return A pie chart created using Plotly.
#' @export
#' @examples
#' pie_plt(mtcars, "cyl", "mpg", "Cylinder Distribution", "A")
pie_plt <- function(df,
                    group_var = "gender",
                    count_var = "patient_id",
                    title = NULL,
                    source_id = "A") {

  plotly::renderPlotly({
    if (is.null(title)) { title <- group_var }
    df %>%
      dplyr::group_by(!!dplyr::sym(group_var)) %>%
      dplyr::summarise(n = !!dplyr::sym(count_var) %>% unique() %>% length()) %>%
      dplyr::rename(group_var = !!group_var) %>%
      plotly::plot_ly(
        labels = ~ group_var,
        values = ~ n,
        type = "pie",
        textinfo = 'none',
        hoverinfo = 'text',
        text = ~ paste0(stringr::str_to_sentence(group_var), ": ", n, " Donors"),
        showlegend = FALSE,
        # hole = 0.5,
        title = stringr::str_to_sentence(title),
        source = source_id
      ) %>%
      plotly::config(displaylogo = FALSE)
  })
}

#' Generate a Pie Chart
#'
#' This function takes a data frame and creates a pie chart to visualize
#' the distribution of a categorical variable.
#'
#' @param df A data frame containing the data.
#' @param group_var The name of the categorical variable to group by.
#' @param count_var The variable used for counting the occurrences.
#' @param title The title of the pie chart.
#' @param ns The namespace for Shiny.
#' @param click_id Click identification.
#'
#' @return A pie chart created using Plotly.
#' @export
#' @examples
#' pie_plt(mtcars, "cyl", "mpg", "Cylinder Distribution", "A")
pie_plt_2 <- function(df,
                      group_var = "gender",
                      count_var = "patient_id",
                      title = NULL,
                      ns,
                      click_id) {

  if (is.null(title)) { title <- group_var }
  click_js <-
    highcharter::JS(
      stringr::str_c(
        "function(event) {Shiny.onInputChange('",
        ns(""),
        click_id,
        "',event.point.name);}"
      )
    )

    df %>%
      dplyr::group_by(!!dplyr::sym(group_var)) %>%
      dplyr::summarise(n = !!dplyr::sym(count_var) %>% unique() %>% length()) %>%
      dplyr::rename(group_var = !!group_var) %>%
      highcharter::hchart("pie", highcharter::hcaes(x = group_var, y = n)) %>%
      highcharter::hc_title(text = title) %>%
      highcharter::hc_plotOptions(pie = list(
        dataLabels = list(enabled = FALSE),
        allowPointSelect = TRUE,
        point = list(
          events = list(
            click = click_js
          )
        )
      ))
}


#' Create an Interactive DataTable
#'
#' This function takes a data frame and generates an interactive DataTable
#' using the DT package with various customization options.
#'
#' @param df A data frame to be displayed in the DataTable.
#'
#' @return An interactive DataTable.
#' @export
#' @examples
#' custom_dt(iris)
custom_dt <- function(df) {
  df %>%
    stats::setNames(
      colnames(.) %>%
        stringr::str_replace_all("_", " ") %>%
        stringr::str_to_title()
    ) %>%
    DT::datatable(
      escape = FALSE,
      rownames = FALSE,
      extensions = "Scroller",
      class = "hover nowrap",
      style = "auto",
      plugins = "scrollResize",
      options = list(
        deferRender = TRUE,
        scrollY = "55vh",
        scrollX = TRUE,
        scroller = TRUE,
        headerCallback = DT::JS(
          "function(thead) {",
          "  $(thead).css('color', 'black');",
          "}"
        )
      )
    ) %>%
    DT::formatStyle(columns = colnames(.), fontSize = '25%')
}

#' Add Action Button to a Column in a Data Frame
#'
#' This function adds an action button to a specified column in a data frame.
#' The action button is created using Shiny's actionButton function.
#'
#' @param df A data frame to which the action button will be added.
#' @param col A character string specifying the column to which the action
#'   button will be added.
#' @param ns A shiny namespace object, usually from `ns <- NS(id)`.
#' @param inputId A character string specifying the input ID that will be used
#'   in Shiny's onInputChange function.
#'
#' @return A data frame with the specified column replaced by action buttons.
#' @export
acctionbutton_col <- function(df, col, ns, inputId) {
  df %>%
    dplyr::pull(!!col) %>%
    purrr::map_dfr( ~ {
      f_df <- dplyr::filter(df, project_id == .x)
      f_df[col] <- actionButton(
        class = "project_button",
        inputId = ns(paste0("button_", f_df[[col]])),
        label = f_df[[col]],
        onclick = paste0('Shiny.onInputChange(\"', ns(inputId), '\", this.id)')
      ) %>% as.character()

      f_df
    })
}



