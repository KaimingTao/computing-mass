apply_theme <- function(p) {
  p = p + theme(
      legend.position = "none",
      # legend.title = element_blank(),
      # axis.title.x = element_blank(),
      # axis.title.y = element_blank(),
      # axis.text.x = element_blank(),
      axis.title.y = element_text(size=10),
      axis.title.x = element_text(size=10),
      # plot.title = element_text(hjust = 0.5, size=12),
      strip.background = element_blank(),
      strip.text = element_blank(),
      panel.background = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
    )
  p
}


library(tidyverse)

# TODO: use library(iterators) to simplify for loop
#   - Issue: need install library(iterators)

accuracy= 100
step_length = 0.05
even_split_length =0.025

power10 <- (number) {
  return(10 ^(number))
}

prettyJitter <- function(df, col1, col2, col1Iterator) {

  # Using Round(accuracy * log10) to make sure
  # similar value will be horizontally aligned.
  df <- mutate(df, Log10Value=round(log10(df[[col2]]) * accuracy))

  new_df = data.frame()

  for (x_idx in 1:length(col1Iterator)) {
    x_name = col1Iterator[x_idx]

    # Get rows for one x-axis item
    df_rows = filter(df, df[[col1]] == x_name)

    new_df_rows = data.frame()

    # Get unique y-axis value
    unique_y_count = count(df_rows, Log10Value)

    if (nrow(unique_y_count) == 0) {
      next
    }
    for (y_idx in 1:nrow(unique_y_count)) {
      y_value = as.integer(unique_y_count[y_idx,1])
      y_count = as.integer(unique_y_count[y_idx,2])
      df_rows_with_value = filter(df_rows, Log10Value==y_value)

      left_cursor = x_idx
      right_cursor = x_idx


      # generate start x-axis position for same y-axis value
      if (y_count %% 2 == 0) {
        left_cursor = x_idx - even_split_length
        right_cursor = x_idx + even_split_length
        x_pos = c(left_cursor, right_cursor)
        y_count = y_count - 2
      } else {
        x_pos = c(x_idx)
        y_count = y_count - 1
      }

      # generate all x-axis position for same y-axis value
      for(c in 1:y_count) {
        if(y_count < 1) {
          break
        }
        if (c %% 2) {
          left_cursor = left_cursor - step_length
          x_pos = prepend(x_pos, left_cursor)
        } else {
          right_cursor = right_cursor + step_length
          x_pos = append(x_pos, right_cursor)
        }
      }

      # add position to each row for same y-axis value
      for(c in 1:length(x_pos)) {
        p = x_pos[c]
        row = df_rows_with_value[c,]
        row['X'] <- p
        row['Col2'] = power10(row$Log10Value / accuracy)
        new_df_rows = rbind(new_df_rows, row)
      }
    }

    new_df = rbind(new_df, new_df_rows)
  }

  return(new_df)
}


# pretty break

int_breaks <- function(x, n = 5) {
  l <- pretty(x, n)
  l[abs(l %% 1) < .Machine$double.eps ^ 0.5] 
}
