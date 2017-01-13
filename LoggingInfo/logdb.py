import sqlite3

class LogDb:
    def __init__(self, name):
        self.__name = name

    def create(self):
        conn = sqlite3.connect(self.__name)
        c = conn.cursor()
        c.execute("CREATE TABLE IF NOT EXISTS log (id INTEGER PRIMARY KEY, job_id INTEGER NOT NULL, site char(64), hostname char(64), app_status char(64), time INTEGER)")
        c.execute("CREATE INDEX IF NOT EXISTS job_id_log_idx ON log (job_id)")
        c.execute("CREATE INDEX IF NOT EXISTS site_log_idx ON log (site)")
        c.execute("CREATE INDEX IF NOT EXISTS hostname_log_idx ON log (hostname)")
        c.execute("CREATE INDEX IF NOT EXISTS app_status_log_idx ON log (app_status)")
        c.execute("CREATE INDEX IF NOT EXISTS time_log_idx ON log (time)")
        conn.commit()
        conn.close()

    def insert(self, data):
        conn = sqlite3.connect(self.__name)
        c = conn.cursor()
        ret = c.execute("INSERT INTO log (job_id, site, hostname, app_status, time) VALUES (?, ?, ?, ?, ?)",
                (data['job_id'], data['site'], data['hostname'], data['app_status'], data['time']))
        conn.commit()
        conn.close()

    def get(self):
        conn = sqlite3.connect(self.__name)
        c = conn.cursor()
        c.execute("select * from log")
        result = c.fetchall()
        conn.commit()
        conn.close()
        return result


def main():
    ldb = LogDb('db/log.db')
    ldb.create()

if __name__ == '__main__':
    main()
