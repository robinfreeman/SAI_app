# Work PC uses: rsconnect 0.4.3 
library(ggthemes)


logfname <- "download_log.csv"
writetolog <- function(newcount,newsessionid,operation){
    time <- format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z")
    df <- data.frame(time=time,count=newcount,sessionid=newsessionid,operation=operation)
    doappend <- file.exists(logfname)
    if (doappend){
        write.table(df,logfname,append=T,quote=F,col.names=F,sep=",",row.names=F)
    } else {
        write.table(df,logfname,append=F,quote=F,sep=",",row.names=F)
    }
}

shinyServer(function(input, output, session) {

    
    observeEvent(input$download_check, {
        if(input$download_check == F){
            shinyjs::disable("download_alldata")
        } else {
            ga_collect_pageview(page = paste0("/download/checkbox/"))
            shinyjs::enable("download_alldata")
        }
    })
    
    output$download_alldata <- downloadHandler(
        filename <- function() {
            paste("LivingPlanetIndex_20200910", ".zip", sep="")
        },
        content <- function(file) {
            #writetolog(1,session$token,"download_alldata")
            file.copy("data/data_download/LivingPlanetIndex_2020_PublicData.zip", file)
        },
        contentType = "application/zip"
    )
    
    update_counter <- reactiveVal(0)
    
    output$plot <- renderPlot({
        
        if (update_counter() < 4) {
            invalidateLater(300, session)
        }
        hist(rnorm(isolate(input$n)))
    })
    
    ## initialise a blank map, points added afterwards by next function
    output$map <- renderMapdeck({
        
        isolate(update_counter(update_counter() + 1))
        
        mapdeck(location = c(144.9, -37.8)
                , zoom = 11
                , pitch = 45
                , style = mapdeck_style("light")
        )
        
    })
    
    observe({
        # Re-execute this reactive expression after 1000 milliseconds
        isolate(update_counter(update_counter() + 1))
        
        ga_collect_pageview(page = "/map")
        
        if (update_counter() < 2) {
            invalidateLater(1000, session)
        } else {
            mapdeck_update(map_id = "map") %>%
            add_pointcloud(
                data = lpi_data_map
                , layer_id = "locations"
                , lon = 'Longitude'
                , lat = 'Latitude'
                , tooltip = "Binomial"
                #, update_view = TRUE
                , radius = 3
                , fill_opacity = 0.5
            )  %>%
            add_pointcloud(
                data = lpi_data_map
                , layer_id = "locations"
                , lon = 'Longitude'
                , lat = 'Latitude'
                , tooltip = "Binomial"
                #, update_view = FALSE
                , radius = 3
                , fill_opacity = 0.5
            )  %>%
            add_pointcloud(
                data = subset(lpi_data_map, New_LPR20 == 1)
                , layer_id = "new_populations"
                , lon = 'Longitude'
                , lat = 'Latitude'
                , tooltip = "Binomial"
                , fill_colour = '#00ff00'
                , fill_opacity = 0.5
                , radius = 3
                #, update_view = FALSE
            ) %>%
            add_pointcloud(
                data = subset(lpi_data_map, New_spp_LPR20 == 1)
                , layer_id = "new_species"
                , lon = 'Longitude'
                , lat = 'Latitude'
                , tooltip = "Binomial"
                , fill_colour = '#ff0000'
                , radius = 3
                , fill_opacity = 0.5
                , update_view = TRUE
            ) 
        }
        
    })
    
    
    ## use an observer to add and remove layers
    observeEvent({input$all_locations},{
        if (input$all_locations == T) {
            mapdeck_update(map_id = "map") %>%
                add_pointcloud(
                    data = lpi_data_map
                    , layer_id = "locations"
                    , lon = 'Longitude'
                    , lat = 'Latitude'
                    , tooltip = "Binomial"
                    , update_view = FALSE
                    , radius = 3
                    , fill_opacity = 0.5
                )
        } else {
            mapdeck_update(map_id = "map") %>% clear_pointcloud("locations")
        }
    })
    ## use an observer to add and remove layers
    observeEvent({input$new_pops},{
        if (input$new_pops == T) {
            mapdeck_update(map_id = "map") %>%
                add_pointcloud(
                    data = subset(lpi_data_map, New_LPR20 == 1)
                    , layer_id = "new_populations"
                    , lon = 'Longitude'
                    , lat = 'Latitude'
                    , tooltip = "Binomial"
                    , fill_colour = '#00ff00'
                    , fill_opacity = 0.5
                    , radius = 3
                    , update_view = FALSE
                )
        } else {
            mapdeck_update(map_id = "map", ) %>% clear_pointcloud("new_populations")
        }
    })
    
    ## use an observer to add and remove layers
    observeEvent({input$new_sp},{
        if ( input$new_sp == T) {
            mapdeck_update(map_id = "map") %>%
                add_pointcloud(
                    data = subset(lpi_data_map, New_spp_LPR20 == 1)
                    , layer_id = "new_species"
                    , lon = 'Longitude'
                    , lat = 'Latitude'
                    , tooltip = "Binomial"
                    , fill_colour = '#ff0000'
                    , radius = 3
                    , fill_opacity = 0.5
                    , update_view = FALSE
                )
        } else {
            mapdeck_update(map_id = "map") %>% clear_pointcloud("new_species")
                
        }
    })
    
    
    
    output$prop_trends_plot_pop <- renderPlot({
        
        
        ga_collect_pageview(page = paste0("/data/pop_trends_proportions/"))
        
        df <- pivot_longer(population_lambdas_table, cols=c("Increase", "Stable", "Decline"), names_to = "Trend", values_to = "n") %>% group_by(Taxa) %>% mutate(Percent = n / sum(n)*100)
        
        
        df$Trend = factor(df$Trend, levels = c("Decline", "Stable", "Increase"))
        df$Taxa = factor(df$Taxa, levels = c("Fishes", "Amphibians", "Reptiles", "Birds", "Mammals"))
        
        ggplot(df, aes(x = Taxa, y = Percent, fill = Trend))+
            geom_bar(stat = "identity", )+
            geom_text(aes(label = paste(format(Percent, digits = 2),"%"), y = Percent), 
                      position = position_stack(vjust = 0.5))+
            coord_flip() + 
            labs(title = "***Population trends* by taxonomic group**  
    <span style='font-size:11pt'>Percentage of increasing/stable/declining *population* trends in major taxonomic groups in the LPI</span>") + 
            theme_minimal() +
            theme(
                plot.title = element_markdown(lineheight = 1.1),
                legend.text = element_markdown(size = 11),
                plot.caption = element_markdown(size = 11)
            ) + 
            labs(x = "Class", y = "Percentage",fill = "Taxa")
    })
    
    output$prop_trends_plot_sp <- renderPlot({
    
        
        ga_collect_pageview(page = paste0("/data/sp_trends_proportions/"))
        
        df <- pivot_longer(species_lambdas_table, cols=c("Increase", "Stable", "Decline"), names_to = "Trend", values_to = "n") %>% group_by(Taxa) %>% mutate(Percent = n / sum(n)*100)
        
        df$Trend = factor(df$Trend, levels = c("Decline", "Stable", "Increase"))
        df$Taxa = factor(df$Taxa, levels = c("Fishes", "Amphibians", "Reptiles", "Birds", "Mammals"))
        
        ggplot(df, aes(x = Taxa, y = Percent, fill = Trend))+
            geom_bar(stat = "identity", )+
            geom_text(aes(label = paste(format(Percent, digits = 2),"%"), y = Percent), 
                      position = position_stack(vjust = 0.5))+
            coord_flip() + 
            labs(title = "***Species* trends by taxonomic group**  
    <span style='font-size:11pt'>Percentage of increasing/stable/declining species trends in major taxonomic groups in the LPI</span>") + 
            theme_minimal() +
            theme(
                plot.title = element_markdown(lineheight = 1.1),
                legend.text = element_markdown(size = 11),
                plot.caption = element_markdown(size = 11)
            ) + 
            labs(x = "Class", y = "Percentage",fill = "Taxa")
    })
    
    
    output$ts_length <- renderPlot({
        
        
        ga_collect_pageview(page = paste0("/data/ts_length/"))
        
        lpi_data_all$Taxa = factor(lpi_data_all$Taxa, levels = c("Fishes", "Amphibians", "Reptiles", "Birds", "Mammals"))
        
        ggplot(lpi_data_all, aes(x = Taxa, y = TS_length, fill = Taxa))+
            geom_boxplot() + 
            labs(title = "**Time-series length in taxonomic groups**  
    <span style='font-size:11pt'>Distribution of time-series lengths across major taxonomic groups in the LPI</span>") + 
            theme_minimal() +
            theme(
                plot.title = element_markdown(lineheight = 1.1),
                legend.text = element_markdown(size = 11),
                plot.caption = element_markdown(size = 11)
            ) + 
            labs(x = "Class", y = "Percentage",fill = "Taxa")
    })
    
    output$trends_vs_ts_length <- renderPlot({
        
        LPI_trends_ts_length$Title = factor(LPI_trends_ts_length$Title, c("Global LPI (3 years+)", "Global LPI (5 years+)", "Global LPI (10 years+)"))
        
        ggplot(LPI_trends_ts_length, aes(x=Year, y=LPI_final, ymin=CI_low, ymax=CI_high, 
                                 group=Title, color=Title, fill=Title)) + 
            geom_ribbon(alpha=0.5) + 
            geom_line() + 
            labs(x = "Year")+
            labs(y = "Index (1970 = 1)")+
            labs(title = "**LPI without shorter time-series**  
    <span style='font-size:11pt'>Exploring the impact of removing time series of less than 3, 5, 10 years</span>") + 
            theme_minimal() +
            theme(
                plot.title = element_markdown(lineheight = 1.1),
                legend.text = element_markdown(size = 11),
                plot.caption = element_markdown(size = 11)
            ) + facet_wrap(~Title)
    })
    
    output$lambda_plot <- renderPlot({
        
        LPI_trends$Title = factor(LPI_trends$Title, levels = c("Global", "Terrestrial", "Freshwater", "Marine"))
        
        ggplot(LPI_trends, aes(x=Year, y=LPI_final, ymin=CI_low, ymax=CI_high, 
                               group=Title, color=Title, fill=Title)) + 
            geom_ribbon(alpha=0.5) + 
            geom_line() + 
            scale_color_manual(values = colmap) + 
            scale_fill_manual(values = colmap) + 
            labs(x = "Year")+
            labs(y = "Index (1970 = 1)")+
            labs(title = "**LPI without shorter time-series**  
    <span style='font-size:11pt'>Exploring the impact of removing time series of less than 3, 5, 10 years</span>") + 
            theme_minimal() +
            theme(
                plot.title = element_markdown(lineheight = 1.1),
                legend.text = element_markdown(size = 11),
                plot.caption = element_markdown(size = 11)
            ) + facet_wrap(~Title)
    })
    
    output$trendPlot2 <- renderPlotly({
        
        ga_collect_pageview(page = paste0("/trends/plot/", gsub(" ", "_", input$trend_name2)))
        
        df_trend <- filter(LPI_trends, Title %in% input$trend_name2)
        
        #print(df_trend)
        
        # Graph title
        if (length(input$trend_name)>2) {
            j_names_comma <- paste(input$trend_name2[-length(input$trend_name2)], collapse = ', ')
            j_names <- paste(j_names_comma, ", and ", input$trend_name[length(input$trend_name2)],
                             sep="")
        }
        
        else{
            j_names <- paste(input$trend_name2, collapse = ' and ')
        }
        
        graph_title  <- paste("Living Planet Index for ", j_names, sep="")
        
        p = ggplot(df_trend, aes(x=Year, y=LPI_final, ymin=CI_low, ymax=CI_high, 
                                 group=Title, color=Title, fill=Title, 
                                 text = paste0(Year, ": ", format(round(LPI_final, 2), nsmall = 2), " (", format(round(CI_low, 2), nsmall = 2), " - ", format(round(CI_high, 2), nsmall = 2), ")"))) + 
            geom_ribbon(alpha=0.5, aes(text="")) + 
            geom_hline(yintercept = 1.0, color="black", linetype="dotted") + 
            coord_cartesian(ylim=(c(0, 2))) + 
            geom_line() + 
            scale_color_manual(values = colmap) + 
            scale_fill_manual(values = colmap) + 
            labs(x = "Year")+
            labs(y = "Index (1970 = 1)")+
            labs(title = graph_title)+
            theme_light() + 
            theme(legend.title=element_blank())
        
        ggplotly(p, tooltip = "text") %>%
            layout(legend = list(
                orientation = "h"
            )
            )
    })
    
    output$trend_description <- renderText({ 
        df_trend <- filter(LPI_trends, Title %in% input$trend_name2)
        
        descriptions = unique(df_trend$Description)
        
        HTML(descriptions)
        
    })
    
    # Reactive value for selected dataset ----
    datasetInput <- reactive({
        ga_collect_pageview(page = paste0("/trends/download/", gsub(" ", "_", input$trend_name2)))
        df_trend <- filter(LPI_trends, Title %in% input$trend_name2)
        df_trend = df_trend[, -5]
    })
                
    output$downloadData <- downloadHandler(
        filename = function() {
            paste(input$trend_name2, ".csv", sep = "")
        },
        content = function(file) {
            write.csv(datasetInput(), file, row.names = FALSE)
        }
    )
    
    output$popsPlot2 <- renderPlotly({
        
        ga_collect_pageview(page = paste0("/trends/pop_numbers/", gsub(" ", "_", input$trend_name2)))
        
        df_points = datapoints
        
        if (!"Global" %in% input$trend_name2) { # If we're not plotting everything
            
            #cat(file=stderr(), unique(datapoints$LPR_IPBES_Region), "\n")
            
            #cat(file=stderr(), gsub("IPBES ", "", input$trend_name2), "\n")
            #df_points = subset(datapoints, System %in% input$trend_name2 | LPR_IPBES_Region %in% gsub("IPBES ", "", input$trend_name2))
            points_idx = which((datapoints$System %in% input$trend_name2 | datapoints$LPR_IPBES_Region %in% gsub("IPBES ", "", input$trend_name2)) & datapoints$System != "Marine")
            
            # Add reptiles back in if selected
            if ("Reptiles" %in% input$trend_name2) {
                reptile_idx = which(datapoints$Reptile == TRUE)
                points_idx = union(points_idx, reptile_idx)
            }
            df_points = datapoints[points_idx, ]
        }
        
        library(tidyr)
        df <- df_points %>%
            group_by(year) %>%
            summarise(Populations = length(unique(ID)), Species = length(unique(Binomial))) %>%
            pivot_longer(cols = c("Populations", "Species"))
        
        p = ggplot(df, aes(x=year, y=value, group=name, color=name)) + 
            geom_point(alpha=0.5) +
            labs(x = "Year")+
            labs(y = "Frequency")+
            theme_light() + 
            theme(legend.position="top")
        
        ggplotly(p) %>%
            layout(legend = list(
                orientation = "h"
            )
            )
    })
    
    ## initialise a blank map, points added afterwards by next function
    output$popsmap2 <- renderMapdeck({
        
        ga_collect_pageview(page = "/trends/map")
        
        mapdeck(style = mapdeck_style("light")) %>%
            add_pointcloud(
                data = lpi_data_map
                , layer_id = "Global"
                , lon = 'Longitude'
                , lat = 'Latitude'
                , tooltip = "Binomial"
                , fill_colour = '#ff0000'
                , radius = 3
                , fill_opacity = 0.5
                , update_view = FALSE
            )
    })
    
    observeEvent({input$trend_name2}, {
        
        df_points = datapoints
        
        if (!"Global" %in% input$trend_name2) { # If we're not plotting everything
            
            #cat(file=stderr(), unique(datapoints$LPR_IPBES_Region), "\n")
            
            #cat(file=stderr(), gsub("IPBES ", "", input$trend_name2), "\n")
            #df_points = subset(datapoints, System %in% input$trend_name2 | LPR_IPBES_Region %in% gsub("IPBES ", "", input$trend_name2))
            points_idx = which((datapoints$System %in% input$trend_name2 | datapoints$LPR_IPBES_Region %in% gsub("IPBES ", "", input$trend_name2)) & datapoints$System != "Marine")
            
            # Add reptiles back in if selected
            if ("Reptiles" %in% input$trend_name2) {
                reptile_idx = which(datapoints$Reptile == TRUE)
                points_idx = union(points_idx, reptile_idx)
            }
            df_points = datapoints[points_idx, ]
        }
       
        points_to_map =  subset(lpi_data_map, ID %in% unique(df_points$ID))
        
        #cat(file=stderr(), input$trend_name2)
        #cat(file=stderr(), nrow(points_to_map))
        
        mapdeck_update(map_id = "popsmap2") %>%
            add_pointcloud(
                data = points_to_map
                , layer_id = "Global"
                , lon = 'Longitude'
                , lat = 'Latitude'
                , tooltip = "Binomial"
                , fill_colour = '#ff0000'
                , radius = 3
                , fill_opacity = 0.5
                , update_view = FALSE
            )
    })
    
})