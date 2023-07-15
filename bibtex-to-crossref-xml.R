# function that takes a BibTeX entry as input and converts 
# it into a valid Crossref XML object. It uses the bib2df 
# package to parse the BibTeX entry and retrieve the relevant 
# fields. The XML structure is then created using the xml2 
# package, and the fields from the BibTeX entry are added 
# to the XML.

library(bib2df)
library(xml2)

# Function to convert BibTeX entry to Crossref XML
bibtex_to_crossref_xml <- function(bibtex_entry) {
  # Parse BibTeX entry
  df <- bib2df(bibtex_entry)
  
  # Create XML structure
  citation <- xml_new_root("crossref_query")
  journal_article <- xml_add_child(citation, "journal_article")
  
  # Add the citation fields
  for (col in colnames(df)) {
    if (!is.na(df[1, col])) {
      xml_add_child(journal_article, col, df[1, col])
    }
  }
  
  # Print the XML
  cat(as.character(citation))
}

# Example BibTeX citation
x <- "
@article{Lecy2012,
  author = {Lecy, Jesse D. and Van Slyke, David M.},
  title = {Nonprofit Sector Growth and Density: Testing Theories of Government Support},
  journal = {Journal of Public Administration Research and Theory},
  year = {2012},
  volume = {23},
  number = {1},
  pages = {189-214},
  publisher = {Oxford University Press (OUP)},
  doi = {10.1093/jopart/mus010},
  url = {http://dx.doi.org/10.1093/jopart/mus010}
}"

# Convert BibTeX entry to Crossref XML
bibtex_to_crossref_xml( x )
