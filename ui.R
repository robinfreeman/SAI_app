  # Panel div for visualization
# override the currently broken definition in shinyLP version 1.1.0
panel_div <- function(class_type, content) {
  div(class = sprintf("panel panel-%s", class_type),
      div(class = "panel-body", content)
  )
}

shinyUI(navbarPage(title=div(tags$a(href="https://stats.livingplanetindex.org/",img(src="zsl_logo.png")), ""), id = "navBar",
                   theme = "paper.css",
                   collapsible = TRUE,
                   inverse = TRUE,
                   windowTitle = "The Living Planet Report 2020",
                   position = "fixed-top",
                   footer = includeHTML("./www/include_footer.html"),
                   header = tags$style(
                     ".navbar-right {
                     float: right !important;
                     }",
                     "body {padding-top: 75px;}"),
                   
                   tabPanel("HOME", value = "home",
                            
                            shinyjs::useShinyjs(),
                            
                            tags$head(
                              tags$script(HTML("
                                         var fakeClick = function(tabName) {
                                         var dropdownList = document.getElementsByTagName('a');
                                         for (var i = 0; i < dropdownList.length; i++) {
                                         var link = dropdownList[i];
                                         if(link.getAttribute('data-value') == tabName) {
                                         link.click();
                                         };
                                         }
                                         };
                                         ")),
                              tags$script(" $(document).ready(function () {
                                              $('#navBar a').bind('click', function (e) {
                                                $(document).scrollTop(0);
                                              });
                                            });"
                              )
                                      
                            ), 
                            
                            fluidRow(
                              HTML("
                                 <section class='banner'>
                                 <div class='parallax'>Image from the Our Planet series<br/>
                                 © Paul Stewart / Netflix / Silverback</div>
                                 </section>
                                 ")
                            ),
                            fluidRow(
                              column(3),
                              column(6,
                                     shiny::HTML("<center> <h1>THE LIVING PLANET REPORT 2020</h1> </center>"),
                                     shiny::HTML("<center> <h5>A closer look at the data behind the latest Living Planet Report</h5> </center>")
                              ),
                              column(3)
                            ),
                            
                            
                            # PAGE BREAK
                            tags$hr(),
                            
                            # REport cover
                            fluidRow(style="text-align: center; margin: auto; width: 80%;", 
                                     img(src="LPI_GlobalIndex_2020.png", align = "center"),
                                     shiny::HTML("<h5><center> The 2020 Living Planet Index records a decline of 
                                                 68% in average population abundance since 1970</center> </h5>")
                            ),
                            
                            fluidRow(
                              
                              style = "height:50px;"),

                            fluidRow(
                              column(3),
                              column(2,
                                     tags$div(align = "center", 
                                              tags$a("Map the LPI data", 
                                                     onclick="fakeClick('MAP')", 
                                                     class="btn btn-primary btn-lg")
                                     )
                              ),
                              column(2,
                                     tags$div(align = "center", 
                                              tags$a("Understand the data", 
                                                     onclick="fakeClick('DATA')", 
                                                     class="btn btn-primary btn-lg")
                                     )
                              ),
                              column(2,
                                     tags$div(align = "center", 
                                              tags$a("LPI Trends", 
                                                     onclick="fakeClick('TRENDS')", 
                                                     class="btn btn-primary btn-lg")
                                     )
                              ),
                              column(3)
                            ),
                            fluidRow(style = "height:25px;"
                            ),
                            
                            # PAGE BREAK
                            tags$hr(),
                            
                            # WHERE
                            fluidRow(style="text-align: center; margin: auto; width: 80%;", 
                                     shiny::HTML("<br><br><center> <h1>Understanding the Living Planet Index</h1> </center><br>"),
                                     img(src="populations_map.png", align = "center"),
                                     p(),
                                     shiny::HTML("<h5><center>The Living Planet Index is a multi-species indicator based on average trends in population abundance of vertebrate species from all around the world. Biodiversity is perhaps most widely understood at the species level, so as a measure of trends in species abundance the LPI has a high degree of resonance with decision makers and the public and links clearly to ecological process and ecosystem function. The latest version of the indicator is composed of over 20,000 population trends for over 4,000 amphibian, bird, fish, mammal and reptile species.</center></h5>")
                              
                            ),
                            
                            fluidRow(
                              
                              style = "height:50px;"),
                            
                            fluidRow(
                              column(3),
                              column(2,
                                     tags$div(align = "center", 
                                              tags$a("Map the LPI data", 
                                                     onclick="fakeClick('MAP')", 
                                                     class="btn btn-primary btn-lg")
                                     )
                              ),
                              column(2,
                                     tags$div(align = "center", 
                                              tags$a("Understand the data", 
                                                     onclick="fakeClick('DATA')", 
                                                     class="btn btn-primary btn-lg")
                                     )
                              ),
                              column(2,
                                     tags$div(align = "center", 
                                              tags$a("LPI Trends", 
                                                     onclick="fakeClick('TRENDS')", 
                                                     class="btn btn-primary btn-lg")
                                     )
                              ),
                              column(3)
                            ),
                            fluidRow(
                              
                              style = "height:50px;"),
                            
                            # PAGE BREAK
                            tags$hr(),
                            
                            fluidRow(
                              column(3),
                              column(6,
                                     shiny::HTML("<br><br><center> <h1>How can I learn more?</h1> </center><br>"),
                                     shiny::HTML("<h5><center> Use the links below to learn more about this year's Living Planet Report.</center> </h5>")
                              ),
                              column(3)
                            ),
                            
                            # BUTTONS TO START
                            fluidRow(
                              column(3),
                              column(6,
                                     
                                     tags$div(class = "wrap",
                                              div(class = "center", 
                                                  style="padding: 5px",
                                                  tags$a("Access the 2020 Living Planet Report",
                                                         onclick = "window.open('https://wwf.panda.org/knowledge_hub/all_publications/living_planet_report_2018/', '_blank')",
                                                         class="btn btn-primary btn-lg")
                                              ),
                                              div(class = "center",
                                                  style="padding: 5px",
                                                  tags$a("Visit the Living Planet Index website", 
                                                         onclick = "window.open('https://www.livingplanetindex.org/', '_blank')",
                                                         class="btn btn-primary btn-lg") #onclick="fakeClick('careerPF')", 
                                              )
                                     )
                              ),
                              column(3)
                            ),
                            
                            fluidRow(
                              
                              style = "height:50px;"),
                            fluidRow(style="text-align: center", 
                                     img(src="2020 LPR - report covers.png"),
                            ),

                            fluidRow(
                              
                              style = "height:50px;"),
                            
                            
                            
                   ), # Closes the first tabPanel called "Home"
                   
                   tabPanel("MAP", value = "MAP",
                            fluidRow(
                              column(width = 3,
                                     checkboxInput("all_locations", label = "All Locations", value = TRUE),
                                     checkboxInput("new_pops", label = "New Populations (2020)", value = TRUE),
                                     checkboxInput("new_sp", label = "New Species (2020)", value = TRUE),
                                     p(strong("Locations of Living Planet Index species populations")),
                                     p("Map showing the  locations of the monitored populations in the LPI. Newly added populations 
                                       since the last report are highlighted in green and species new to the LPI are
                                       shown in red."),
                                    p(strong("Source: WWF/ZSL (2020)")),
                              ),
                              column(width = 9, 
                                     mapdeckOutput(outputId = "map")
                              )
                            )
                   ),  # Closes the second tabPanel called "Map"
                   
                  tabPanel("DATA", value = "DATA",
                            tabsetPanel(
                                      tabPanel("What kind of data?", 
                                               h3(strong("")),
                                               fluidRow(style="text-align: center; margin: auto; width: 80%;",
                                                        p(style="text-align: justify;", "The data used in constructing the LPI are time-series of either population size, density (population size per unit area), abundance (number of individuals per sample) or a proxy of abundance (for example, the number of nests recorded may be used instead of a direct population count). The table below gives you an idea of what can and can’t be used."),        
                                                        p(style="text-align: justify;", "If you have data you would like to contribute to the Living Planet Database, please get in touch with us at LivingPlanetIndex (at) ioz.ac.uk."),
                                                        img(src='Data_requirements.png', align = "centre")
                                               )   
                                      ),
                                      tabPanel("What does it mean?", 
                                                   fluidRow(style="text-align: center; margin: auto; width: 80%;",
                                                            h3(strong("What does the LPI indicate?")),
                                                            p(style="text-align: justify;", "The headline trend from this Living Planet Report is that globally, monitored populations of birds, mammals, fish, reptiles and amphibians have declined in abundance by 68% on average between 1970 and 2016. But what does this actually mean? Below is a table of what the LPI is and what the common misconceptions are."),        
                                                            shiny::HTML("<table class='misconception' style='width:80%;'>
  <tr>
  <th>Features of the LPI</th>
  <th>Common misconceptions</th> 
  </tr>
  <tr>
  <td>The LPI is shows the average rate of change in animal population sizes</td>
  <td>The LPI doesn't show numbers of species lost or extinctions, although some populations do decline to local extinction</td>
  </tr>
  <tr>
  <td>Species and populations in the LPI show increasing, declining and stable trends</td>
  <td>Not all species and populations in the LPI are in decline</td>
  </tr>
  <tr>
  <td>About half of the species we have in the LPI show an average decline in population trend</td>
  <td>The LPI statistic does not mean that 68 per cent of species or populations are declining</td>
  </tr>
  <tr>
  <td>The average change in population size in the LPI is a decline of 68 per cent</td>
  <td>The LPI statistic does not mean that 68% populations or individual animals have been lost</td>
  </tr>
  <tr>
  <td>The LPI represents the monitored populations included in the index</td>
  <td>The LPI doesn't necessarily represent trends in other populations, species or biodiversity as a whole</td>
  </tr>
  <tr>
  <td>The LPI includes data for threatened and non-threatened species - if it's monitored consistently over time, it goes in!</td>
  <td>The species in the LPI are not selected based on whether they are under threat, but as to whether there is robust population trend data available</td>
  </tr>
  </table>"),
                                               ),   
                                      ),
                                      tabPanel("Mixture of trends", 
                                               h3(strong("Are all species in the LPI declining?")),
                                               p(style="text-align: justify;", "LPI results are calculations of average trends. This means that for the global LPI some populations and species are faring worse than a 68% decline whereas others are not declining as much or are increasing. The average trend calculated for each species in the LPI shows that just over half of reptile, bird and mammal species are stable or increasing (Figure 5). Conversely, the average trend for over 50% of fishes and amphibians species shows a decline."),        
                                               p(style="text-align: justify;","As the number of species which have positive and negative trends are more or less equal, this means that the magnitude of the declining trends exceeds that of the increasing trends in order to result in an average decline for the global LPI. This also suggests that the global LPI is not being driven by just a few very threatened species, but that there are a large number of species in each group (almost 50%) that together produce an average declining trend."),
                                               p(style="text-align: justify;", "If we look at trends at the population level, a similar pattern emerges, although in this case amphibians are the only taxonomic group with over 50% of populations showing a negative trend."),
                                               plotOutput("prop_trends_plot_pop"),
                                               plotOutput("prop_trends_plot_sp"),
                                      ),
                                      tabPanel("Short time-series", 
                                               h3(strong("What influence do short time-series have on the LPI trend?")),
                                               p(style="text-align: justify;", "The LPI database contains data gathered from different sources and collected at different scales, and not explicitly for the purpose of the analyses presented in the Living Planet Report. It therefore consists of time series of varying lengths (interval between the first and the last observation) and fullness (number of observations over the total number of years) For some species/groups, however, only shorter time-series are available, as shown in Figure 7. Whilst time series for birds and mammals appear to be longer, amphibians are almost exclusively represented in the database by shorter time-series. Collecting and using only long-term data, which are often available for species/groups that are doing better on the whole, we could potentially miss declines in other species, which are important signals from a conservation perspective. Also, a recent study comparing known long-term trends in bird abundance with samples of these complete time series (Wauchope et al. 2019) suggests that if a significant trend is detected by the sample it is likely to reliably describe the direction (positive or negative) of the complete trend. Although it remains to be tested if these results can be expanded to other taxonomic groups and types of data, this might suggest that a decline detected in a short time series is worth investigating to confirm the trend and potentially avoid further decline."),        
                                               plotOutput("ts_length"), 
                                               p(style="text-align: justify;", "To gauge whether the inclusion of these shorter time-series might be skewing the results of the global LPI, we re-calculated the trend excluding short time-series (Figure 8). Overall, the removal of shorter time-series appears to have little influence on the overall trend, with the trend calculated excluding time-series with less than 3 years of data largely overlapping with the global trend. Trends calculated excluding time-series with less than 5 and 10 years of data diverge from the global trend from 2002 and 2003, respectively. However, the confidence intervals around these trends overlap for the most part with the confidence intervals around the global trend, and the final index values differ from the final value of the global trend by 3 and 5% respectively."),
                                               plotOutput("trends_vs_ts_length")
                                      )
                                      #,
                                      #tabPanel("Sensitivity to outliers",
                                      #         h3(strong("Do outliers and extreme trends have a strong influence on the Living Planet Index value?")),
                                      #         p(style="text-align: justify;", "The geometric mean, the metric the LPI is based on, can be sensitive to extreme values and outliers (Buckland et al. 2011, Gregory et al. 2019), both positive and negative. To some extent this is not surprising.â¯If we remove the figures for the top performing companies in the FTSE All Share, or the worst performing companies then, inevitably, the FTSE figure would change. While this new methodology helps to identify those species populations that are most in decline, excluding or segregating these from the remaining populations is complex. What we are investigating is how increasing the representation of our dataset can mitigate some of the sensitivities of the methods we use to extreme increases and declines. If we look at the total change between 1970 and 2016 for the species included in the global LPI (Figure 6), we can see that - as expected - fewer species exhibit extreme increases and declines compared to the number of species that show stable trends or moderate increases and declines."),        
                                      #         plotOutput("lambda_plot")
                                      #)
                              )
                   ),  # Closes the second tabPanel called "Data"
                   
                   tabPanel("TRENDS", value = "TRENDS",
                            sidebarLayout( 
                              sidebarPanel(
                                h5("View trends from the Living Planet Report"),
                                # Select Justices name here
                                selectInput("trend_name2",
                                               label = "Trend",
                                               choices = unique(LPI_trends$Title),
                                               multiple = F,
                                               selected = "Global"
                                ),
                                p(style="text-align:justify", htmlOutput("trend_description")),
                                downloadButton("downloadData", "Download"),
                                helpText("Data: Living Planet Report 2020, WWF/ZSL")
                              ),
                              
                              # Show a plot of the generated distribution
                              mainPanel(
                                fluidRow(
                                  column(12,offset=0,
                                         plotlyOutput('trendPlot2')
                                  )),
                                fluidRow(
                                  column(6,offset=0,
                                         plotlyOutput('popsPlot2')
                                  ),
                                  column(6,offset=0,
                                         mapdeckOutput(outputId = "popsmap2")
                                  )
                                )
                              )
                            )  # Closes the sidebarLayout
                   ),  # Closes the second tabPanel called "Trends"
                   
                   tabPanel("DOWNLOAD", value = "DOWNLOAD",
                            fluidRow(
                              column(2),
                              column(8,
                                     # Panel for Background on team
                                     # Panel for Background on team
                                     div(class="panel panel-default",
                                         div(class="panel-body",  
                                             h5("Download the data behind the Living Planet Index"),
                                            tags$p(h6("The Living Planet Database contains tens of thousands of vertebrate population time-series from around the world. 
                                                      It is the largest collection of its kind, and is publicly available, making it an invaluable tool for both research 
                                                      and conservation.")),
                                            tags$p(h6("This dataset contains time-series of population abundance data for vertebrate species spanning years between 1970 and 2016. These 
                                                      data were used in the Living Planet Report 2020. Confidential records that cannot be shared have been 
                                                      removed from this data set. A beta version of the code used in calculation of the Living Planet Index 
                                                      using this data set can be found here "), tags$a(href="https://github.com/Zoological-Society-of-London/rlpi","https://github.com/Zoological-Society-of-London/rlpi")),
                                            tags$p(h6("Please tick the box below to agree to our data-use agreement: "), tags$a(href="https://livingplanetindex.org/documents/data_agreement.pdf", "https://livingplanetindex.org/documents/data_agreement.pdf")),
                                            checkboxInput("download_check",
                                              label = "Agree"
                                            ),
                                          downloadButton("download_alldata", "Download"),
                                         )
                                     )
                                  ),
                              column(2)
                            )
                   ),  # Closes the second tabPanel called "Download"
                   
                   tabPanel("ABOUT", value = "about",
                            
                            fluidRow(
                              column(2),
                              column(8,
                                     # Panel for Background on team
                                     div(class="panel panel-default",
                                         div(class="panel-body",  
                                            tags$div( align = "center",
                                                      div( align = "center", 
                                                           h5("About the Data")
                                                      )
                                            ),
                                            tags$p(h6("The Living Planet Database contains tens of thousands of vertebrate population time-series from around the world. It is the largest collection of its kind, and is publicly available, making it an invaluable tool for both research and conservation. The data are used to calculate species indices for a wide range of applications; best known is the Living Planet Index: an indicator also used to measure progress towards the CBD's Aichi Targets.")),
                                         )
                                     )
                              ),
                              column(2)
                            ),
                            fluidRow(
                              column(2),
                              column(8,
                                     # Panel for Background on team
                                     div(class="panel panel-default",
                                         div(class="panel-body",  
                                             tags$div( align = "center",
                                                       div( align = "center", 
                                                            h5("About the team")
                                                       )
                                             ),
                                             tags$p(h6("The Living Planet Index is produced by a team based at the Institute of Zoology, Zoological Society of London. You can reach the team by emailing LivingPlanetIndex (at) ioz.ac.uk")),
                                             
                                             fluidRow(
                                               
                                               # Rob
                                               column(2,
                                                      div(class="panel panel-default", 
                                                          div(class="panel-body",   style = "height:300px", 
                                                              align = "center",
                                                              div(
                                                                tags$img(src = "Robin_Freeman.png", 
                                                                         width = "90px", height = "90px")
                                                              ),
                                                              div(
                                                                tags$h5("Robin Freeman"),
                                                                tags$h6( tags$i("Head of Indicators & Assessments Research Unit"))
                                                              )
                                                          )
                                                      )
                                               ),
                                               
                                               # Lou
                                               column(2,
                                                      div(class="panel panel-default",
                                                          div(class="panel-body",    style = "height:300px", 
                                                              align = "center",
                                                              div(
                                                                tags$img(src = "Louise_McRae.jpg", align = "center",
                                                                         width = "90px", height = "90px")
                                                              ),
                                                              div(
                                                                tags$h5("Louise McRae"),
                                                                tags$h6( tags$i("Project Manager"))
                                                              )
                                                          )
                                                      )
                                               ),
                                               
                                               # Stef
                                               column(2,
                                                      div(class="panel panel-default",
                                                          div(class="panel-body",   style = "height:300px", 
                                                              align = "center",
                                                              div(
                                                                tags$img(src = "Stefanie_Deinet.jpg", 
                                                                         width = "90px", height = "90px")),
                                                              div(
                                                                tags$h5("Stefanie Deinet"),
                                                                tags$h6( tags$i("Postgraduate Research Assistant"))
                                                              )
                                                          )
                                                      )
                                               ),
                                               
                                               # Vale
                                               column(2,
                                                      div(class="panel panel-default",
                                                          div(class="panel-body",   style = "height:300px", 
                                                              align = "center",
                                                              div(
                                                                tags$img(src = "Valentina_Marconi.png", 
                                                                         width = "90px", height = "90px")),
                                                              div(
                                                                tags$h5("Valentina Marconi"),
                                                                tags$h6( tags$i("Postgraduate Research Assistant"))
                                                              )
                                                          )
                                                      )
                                               ),
                                               
                                               # Sophie
                                               column(2,
                                                      div(class="panel panel-default",
                                                          div(class="panel-body",   style = "height:300px", 
                                                              align = "center",
                                                              div(
                                                                tags$img(src = "Sophie.jpg", 
                                                                         width = "90px", height = "90px")),
                                                              div(
                                                                tags$h5("Sophie Ledger"),
                                                                tags$h6( tags$i("Living Planet Report Fellow"))
                                                              )
                                                          )
                                                      )
                                               ),
                                               
                                               # Kate
                                               column(2,
                                                      div(class="panel panel-default",
                                                          div(class="panel-body",  style = "height:300px", 
                                                              align = "center",
                                                              div(tags$img(src = "Kate_Scott-Gatty.jpeg", 
                                                                         width = "90px", height = "90px")),
                                                              div(
                                                                tags$h5("Kate Scott-Gatty"),
                                                                tags$h6( tags$i("Research Assistant"))
                                                              )
                                                          )
                                                      )
                                               ),
                                               column(3)
                                               
                                             )
                                         )
                                     ) # Closes div panel
                              ), # Closes column
                              column(2)
                            ),
                            
                            fluidRow(
                              column(2),
                              column(8,
                                     # Panel for Background on Data
                                     div(class="panel panel-default",
                                         div(class="panel-body",  
                                             tags$div( align = "center",
                                                       div( align = "center", 
                                                            h5("Acknowledgements")
                                                       )
                                             ),
                                             tags$p(h6("We are very grateful to the following individuals and organisations who have worked with us and/or shared their data.")),
                                             tags$p(h6("Richard Gregory, Peter Vorisek and the European Bird Census Council for data from the Pan-European Common Bird Monitoring scheme; the Global population Dynamics Database from the Center for Population Biology, Imperial College London; Derek Pomeroy, Betty Lutoaya and Herbert Tushabe for data from the National Biodiversity Database, Makerere University Institute of Environment and Natural Resources, Uganda; Kristin Thorsrud Teien and Jorgen Randers, WWF Norway; Pere Tomas-Vives, Christian Peremou, Driss Ezzine de Blas, Patrick Grillas and Thomas Galewski, Tour du Valat, Camargue, France; David Junor and Alexis Morgan, WWF Canada and all data contributors to the LPI for Canada; Miguel Angel Nunez Herrero and Juan Diego Lopez Giraldo, the Environmental Volunteer Programmer in Natural Areas of Murcia region, Spain; Mike Gill from the CBMP, Christoph Zockler, UNEP-WCMC and all data contributors to the ASTI reports (www.asti.is); WWF Netherlands and all data contributors to the LPI for global estuarine systems; all individuals who have provided data for the Canadian Species Index; Lorenzo Alvarez-Filip and collaborators for providing Caribbean reef-fish data; Sergi Herrando and the Catalan Ornithological Institute for providing the data behind the Catalan Common Bird Survey (SOCC), Ape Populations, Environments and Surveys (A.P.E.S.) database; all individuals who have provided data for the Forest Specialist Index; University of Queensland and the Threatened Species Index team and friends; Frans Schepers, Rewilding Europe and all contributors to the Wildlife comeback project; Arjan Berkhuysen, the World Fish Migration Foundation and all data contributors to the LPI of migratory freshwater fish.")),
                                             tags$p(h6("We would like to acknowledge the following individuals for their help adding data to the LPI database over the years:  Jenny Beschizza, Audrey Bourgois, Antony Brown, Rachel Burrows, Tharsila Carranza, Ffion Cassidy, Etienne Cousin, Olivia Daniel, Adriana De Palma, Sarah Evans, Annemarie Greenwood, Jonathan Gunasekera, Nicola Harrison, Peter Hill, Charlie Howarth, David Jacoby, Danielle Kopecky, Gayle Kothari, Julia Latham, Tanja Lumetsberger, Duana Lynch, Hannah MacGregor, Nicole Maddock, Robyn Manley, Suzie Marshall, Jenny Martin, Harriet Milligan, Helen Muller, Amy Munro-Faure, Charlotte Outhwaite, Fiona Pamplin, Hannah Peck, Jack Plummer, Victoria Price, Holly Pringle, Louise Raggett, Elizabeth Robinson, Jo Roche, Hannah Rotton, May Shirkhorshidi, Michael Taylor, Isabel Thomas, Carolyn Thompson, Sandra Tranquilli, Ellie Tresize, Mariam Turay and Sarah Whitmee." ))
                                         ) # Closes div panel
                                     ), # Closes column
                              column(2)
                              )
                            ),
                            
                        )  # Closes About tab
                   
  )
)

