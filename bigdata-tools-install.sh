# -------------------------------
#  ENV Variables
# -------------------------------
WORKSPACE_DIR=/home/a78khan/workspace
DOWNLOAD_DIR=$WORKSPACE_DIR/downloads
SOFTWARE_DIR=$WORKSPACE_DIR/software
CONFIGS_DIR=$SOFTWARE_DIR/configs


# -------------------------
#  Hadoop
# -------------------------
URL=http://apache.forsale.plus/hadoop/common/hadoop-2.8.1/hadoop-2.8.1.tar.gz
wget -P $DOWNLOAD_DIR $URL
FILE_NAME=${URL##*/}
tar xf $DOWNLOAD_DIR/$FILE_NAME -C $SOFTWARE_DIR

# copy the config
mkdir -p $CONFIGS_DIR/hadoop_2.8.1
rsync $SOFTWARE_DIR/hadoop-2.8.1/etc/hadoop/ $CONFIGS_DIR/hadoop_2.8.1/

hadoop jar ~/workspace/software/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.8.1.jar pi 32 100

# -------------------------
#  Hive
# -------------------------
URL=http://apache.forsale.plus/hive/hive-2.3.0/apache-hive-2.3.0-bin.tar.gz
wget -P $DOWNLOAD_DIR $URL
FILE_NAME=${URL##*/}
tar xf $DOWNLOAD_DIR/$FILE_NAME -C $SOFTWARE_DIR
schematool -dbType derby -initSchema

# ----------------------------------------------------------------------------------------------------------------
# Test data and queries
#  DATA: wget https://www.isi.edu/~lerman/downloads/twitter/link_status_search_with_ordering_real_csv.zip
# ----------------------------------------------------------------------------------------------------------------
hive -e "drop table twitter;"
hcat -e "CREATE TABLE IF NOT EXISTS twitter (link STRING, id STRING, create_at DATE, create_at_long BIGINT, inreplyto_screen_name STRING, inreplyto_user_id STRING, source STRING, bad_user_id STRING, user_screen_name STRING, order_of_users INT, user_id STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' STORED AS TEXTFILE tblproperties('skip.header.line.count'='1') ;"
hive -e "LOAD DATA LOCAL INPATH '/home/a78khan/workspace/datasets/twitter-2010/link_status_search_with_ordering_real.csv' into table twitter;"
hive -e "select count(*) from twitter
hive -e "select user_screen_name, count(user_screen_name) AS cnt from twitter GROUP BY user_screen_name ORDER BY cnt DESC;"
