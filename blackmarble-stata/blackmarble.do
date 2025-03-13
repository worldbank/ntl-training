* BlackMarble
* Function that creates a dataset to use later
* What specify
* -- All NTL stuff
* -- full path of dta file to save (eg, "~/Desktop/ntl.dta")
* What exports
* -- Individual files
* -- Dataset (e.g., "~/Desktop/ntl_dta_individual_files")

* Process
* Downloads files as individual_files (.dta forma); skips if already downloaded
* Appends files together and updates the dta file
* Loads the data into memory

clear
local bucket "wb-blackmarble"
local region "us-east-2"
local prefix "gadm_410/ADM_0/ABW/blackmarble/annual/"
local years "2021 2022 2023"

tempname master

foreach year in `years' {
    local file "https://`bucket'.s3.`region'.amazonaws.com/`prefix'`year'.csv"

    // Import directly using curl and stdin
    !curl -s "`file'" | cat > tempfile.csv
    import delimited using tempfile.csv, clear

    // If first file, save as master dataset
    if "`year'" == "2021" {
        save `master'
    }
    else {
        append using `master'
        save `master', replace
    }
}

display "All files successfully loaded and appended!"

