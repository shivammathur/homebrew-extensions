# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pinba Extension
class PinbaAT80 < AbstractPhpExtension
  init
  desc "Pinba PHP extension"
  homepage "https://github.com/tony2001/pinba_extension"
  url "https://github.com/tony2001/pinba_extension/archive/refs/tags/RELEASE_1_1_2.tar.gz"
  sha256 "7df27fb3e9de548459b56638394d824781c8f13395da1a0b7f94515f03e15ddc"
  head "https://github.com/tony2001/pinba_extension.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2a0b39780cb2018daf5ef024b3995ee755117ac223646513914be93eb1c16170"
    sha256 cellar: :any,                 arm64_sequoia: "f1031699cbe9c9ef1ba5f44d96894bd6516cf27c09cb7003c750b27a90a59b8f"
    sha256 cellar: :any,                 arm64_sonoma:  "22927cc2a6ed8c18a16c438f70d2c3dc617ce92d26e589713f9bf178bfbefc91"
    sha256 cellar: :any,                 sonoma:        "c833d0564c0819f566c3dfb666c4fb12a85a292b00978bf14854e065c3df215a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6f335767f570a3604a71a28d2411e9677738f50a622f4bb42ed96259991a07d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3241577c0df631a076aca6346b08e8acadbb66b0edd3e292a431066ab42f6d5d"
  end

  depends_on "protobuf-c"

  livecheck do
    url :stable
  end

  patch :DATA

  def install
    args = %W[
      --enable-pinba=#{Formula["protobuf-c"].opt_prefix}
    ]
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end

__END__
diff --git a/pinba.proto b/pinba.proto
index 1596199..b9947ae 100644
--- a/pinba.proto
+++ b/pinba.proto
@@ -24,4 +24,6 @@ message Request {
 	optional string schema          = 19;
 	repeated uint32 tag_name        = 20;
 	repeated uint32 tag_value       = 21;
+	repeated float timer_ru_utime    = 22;
+	repeated float timer_ru_stime    = 23;
 }
diff --git a/config.m4 b/config.m4
index b50499b..4475a03 100644
--- a/config.m4
+++ b/config.m4
@@ -8,5 +8,7 @@ if test "$PHP_PINBA" != "no"; then
 AC_CHECK_HEADERS(malloc.h)
 PHP_CHECK_FUNC(mallinfo)
 
-  PHP_NEW_EXTENSION(pinba, pinba-pb-c.c pinba.c protobuf-c.c, $ext_shared,, -DNDEBUG)
+  PHP_ADD_LIBRARY(protobuf-c, 1, PINBA_SHARED_LIBADD)
+  PHP_SUBST(PINBA_SHARED_LIBADD)
+  PHP_NEW_EXTENSION(pinba, pinba-pb-c.c pinba.c, $ext_shared,, -DNDEBUG)
 fi
diff --git a/pinba.c b/pinba.c
index 9fa6cd5..3c235a7 100644
--- a/pinba.c
+++ b/pinba.c
@@ -172,7 +172,7 @@ static inline pinba_client_t  *php_pinba_client_object(zend_object *obj) {
 	} while (0)
 #endif
 
-static int php_pinba_key_compare(const void *a, const void *b);
+static int php_pinba_key_compare(Bucket *a, Bucket *b);
 
 /* {{{ internal funcs */
 
@@ -1059,26 +1059,21 @@ static void php_pinba_flush_data(const char *custom_script_name, long flags) /*
 }
 /* }}} */
 
-static int php_pinba_key_compare(const void *a, const void *b) /* {{{ */
+static int php_pinba_key_compare(Bucket *a, Bucket *b) /* {{{ */
 {
-	Bucket *f;
-	Bucket *s;
 	zval first;
 	zval second;
 
-	f = (Bucket *) a;
-	s = (Bucket *) b;
-
-	if (f->key == NULL) {
-		ZVAL_LONG(&first, f->h);
+	if (a->key == NULL) {
+		ZVAL_LONG(&first, a->h);
 	} else {
-		ZVAL_STR(&first, f->key);
+		ZVAL_STR(&first, a->key);
 	}
 
-	if (s->key == NULL) {
-		ZVAL_LONG(&second, s->h);
+	if (b->key == NULL) {
+		ZVAL_LONG(&second, b->h);
 	} else {
-		ZVAL_STR(&second, s->key);
+		ZVAL_STR(&second, b->key);
 	}
 
 	return string_compare_function(&first, &second);
