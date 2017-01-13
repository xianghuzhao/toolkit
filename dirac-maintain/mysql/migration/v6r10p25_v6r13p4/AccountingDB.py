#!/usr/bin/env python

import MySQLdb

import sys

user=sys.argv[1]
passwd=sys.argv[2]


def run_sql(sql):
#    print sql
    cursor.execute(sql)
#    connection.commit()

def all_tables():
    sql = 'SHOW TABLES'
    cursor.execute(sql)
    return [c[0] for c in cursor.fetchall()]

def drop_table(table_name):
    sql = 'DROP TABLE %s' % table_name
    run_sql(sql)

def rename_table(table_name):
    new_name = table_name.replace('BES_Production', 'CAS_Production')
    sql = 'RENAME TABLE %s TO %s' % (table_name, new_name)
    run_sql(sql)
    return new_name

def bucket_table(table_name):
    sql = ''
    run_sql(sql)

def in_table(table_name):
    sql = 'DROP INDEX `idIndex` ON %s' % table_name
    run_sql(sql)
    if 'WMSHistory' in table_name:
        sql = '  ALTER TABLE `%s` MODIFY `Status` varchar(128) NOT NULL' % table_name
        run_sql(sql)
        sql = '  ALTER TABLE `%s` MODIFY `MinorStatus` varchar(128) NOT NULL' % table_name
        run_sql(sql)
        sql = '  ALTER TABLE `%s` MODIFY `ApplicationStatus` varchar(128) NOT NULL' % table_name
        run_sql(sql)

def key_table(table_name):
    sql = 'DROP INDEX `value` ON %s' % table_name
    run_sql(sql)
    if 'Status' in table_name and 'WMSHistory' in table_name:
        sql = '  ALTER TABLE `%s` MODIFY `value` varchar(128) NOT NULL' % table_name
        run_sql(sql)

def type_table(table_name):
    sql = ''
    run_sql(sql)

def update_catalog():
    sql = 'ALTER TABLE `ac_catalog_Types` MODIFY `bucketsLength` varchar(255) NOT NULL'
    run_sql(sql)
    sql = 'ALTER TABLE `ac_catalog_Types` MODIFY `valueFields` varchar(255) NOT NULL'
    run_sql(sql)
    sql = 'ALTER TABLE `ac_catalog_Types` MODIFY `keyFields` varchar(255) NOT NULL'
    run_sql(sql)

    sql = "DELETE FROM `ac_catalog_Types` WHERE `name` LIKE 'BES_Test%'"
    run_sql(sql)

    sql = "UPDATE `ac_catalog_Types` SET `name` = REPLACE(`name`,'BES_','CAS_')"
    run_sql(sql)

    sql = "UPDATE `ac_catalog_Types` SET `keyFields`='Status,Site,User,UserGroup,JobGroup,MinorStatus,ApplicationStatus,JobSplitType' WHERE name='CAS_Production_WMSHistory'"
    run_sql(sql)

def main():
    global connection
    global cursor

    connection = MySQLdb.connect(user=user, passwd=passwd, db="AccountingDB")
    connection.autocommit(True)
    cursor = connection.cursor()


    # delete unused tables
    for t in all_tables():
        if 'ac_catalog_Types' in t:
            update_catalog()
            continue

        if 'BES_Test' in t:
            drop_table(t)
            continue

        new_t = rename_table(t)

        if 'ac_bucket' in new_t:
#            bucket_table(new_t)
            pass
        elif 'ac_in' in new_t:
            in_table(new_t)
        elif 'ac_key' in new_t:
            key_table(new_t)
        elif 'ac_type' in new_t:
#            type_table(new_t)
            pass

    # update one item of ac_catalog_Types
    update_catalog()


    cursor.close()
    connection.close()

if __name__ == "__main__":
    main()
