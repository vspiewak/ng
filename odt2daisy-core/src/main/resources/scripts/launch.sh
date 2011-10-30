#/!bin/sh

# SAXON LIB
LIB=lib/saxon-8.7.jar
# SAXON OPTIONS (ex: -T)
LIB_OPTS=
# OUTPUT FILE
OUTPUT=/tmp/output.xml

if [ $# -lt 1 ]
then
    echo "Usage $0 filename/directory"
    echo "Exiting"
    exit 1
fi

function process {

    echo "input: $1"
    unzip -oq $1
    
    # start timer
    START=$(date +%s)

    java -jar $LIB $LIB_OPTS content.xml odt_merge.xsl > /tmp/1
    java -jar $LIB $LIB_OPTS /tmp/1 odt_flat_page.xsl > /tmp/2
    java -jar $LIB $LIB_OPTS /tmp/2 odt_flat_images.xsl > /tmp/3
    java -jar $LIB $LIB_OPTS /tmp/3 odt_flat_headers.xsl > /tmp/4 #$2
    java -jar $LIB $LIB_OPTS /tmp/4 odt_flat_blocks.xsl > $2
    #java -jar $LIB $LIB_OPTS content.xml odt_flat_images.xsl > $2
    
    # end timer
    END=$(date +%s)
    DIFF=$(( $END - $START ))
    echo "$DIFF sec"

    echo " "
    echo "output: $2"

    rm -rf Configurations2 META-INF Pictures Thumbnails \
	layout-cache mimetype \
	content.xml styles.xml styles.xml meta.xml settings.xml \
	manifest.rdf
}

# if file
if  [ -f "$1" ]
then
   echo " "
   process $1 $OUTPUT
fi

# if directory
if  [ -d "$1" ]
then
  
    # for each files
    for i in $( ls "$1"); do

        FILE="$1/$i"

	if  [ ! -f $FILE ]
	then
	    echo "Skipping $FILE"
	fi
	
	if  [ "${FILE#*.}" == "odt" ]
	then
	    echo " "
            process $FILE /tmp/$i.xml
	fi

    done
fi
