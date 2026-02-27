CREATE TABLE IF NOT EXISTS ezdfsfile (
  `name` text NOT NULL,
  name_trunk text NOT NULL,
  name_hash varchar(34) NOT NULL DEFAULT '',
  datatype varchar(255) NOT NULL DEFAULT 'application/octet-stream',
  scope varchar(25) NOT NULL DEFAULT '',
  size bigint(20) unsigned NOT NULL DEFAULT '0',
  mtime int(11) NOT NULL DEFAULT '0',
  expired tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (name_hash),
  KEY ezdfsfile_name (`name`(250)),
  KEY ezdfsfile_name_trunk (name_trunk(250)),
  KEY ezdfsfile_mtime (mtime),
  KEY ezdfsfile_expired_name (expired,`name`(250))
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ezdfsfile_cache LIKE ezdfsfile;

CREATE TABLE IF NOT EXISTS ezuser (
  contentobject_id int(11) NOT NULL DEFAULT '0',
  login varchar(150) NOT NULL DEFAULT '',
  email varchar(150) NOT NULL DEFAULT '',
  password_hash varchar(255),
  password_hash_type int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (contentobject_id)
) ENGINE=InnoDB;

-- Données de test
INSERT INTO ezuser VALUES
  (14, 'admin', 'admin@example.com', '$2y$10$abcdefghijklmnopqrstuuVGqKMOWPdSYJwDHqBmBHKpHPOzQxK1i', 5),
  (42, 'editor', 'editor@example.com', '$2y$10$zyxwvutsrqponmlkjihgguVGqKMOWPdSYJwDHqBmBHKpHPOzQxK1i', 5);

INSERT INTO ezdfsfile (name, name_trunk, name_hash, scope, datatype, size, mtime, expired) VALUES
  ('var/storage/images/test.jpg', 'var/storage/images/test.jpg', MD5('var/storage/images/test.jpg'), 'images', 'image/jpeg', 12345, UNIX_TIMESTAMP(), 0),
  ('var/storage/original/test.pdf', 'var/storage/original/test.pdf', MD5('var/storage/original/test.pdf'), 'media', 'application/pdf', 98765, UNIX_TIMESTAMP(), 0);
