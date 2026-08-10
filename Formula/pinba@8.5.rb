# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pinba Extension
class PinbaAT85 < AbstractPhpExtension
  init
  desc "Pinba PHP extension"
  homepage "https://github.com/tony2001/pinba_extension"
  url "https://github.com/tony2001/pinba_extension/archive/refs/tags/RELEASE_1_1_2.tar.gz"
  sha256 "7df27fb3e9de548459b56638394d824781c8f13395da1a0b7f94515f03e15ddc"
  head "https://github.com/tony2001/pinba_extension.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_tahoe:   "8db8ab6cd6ca82e78a600c3142a874c7ac4886f2e07f698ab4e5bffa279c78d8"
    sha256 cellar: :any, arm64_sequoia: "ae4704e41a33173ed86fc2be63658f450ba695511f84c40680b4dd05ba195ab1"
    sha256 cellar: :any, arm64_sonoma:  "b8b6987bf2778190e76383c7b986b0edef9b2412e4e48a52d4a9c1028bdc939f"
    sha256 cellar: :any, sonoma:        "4d126ba7d3eb2bcfeb2f33c258ea746c20a873abba1e9cac49a6f658716442fd"
    sha256 cellar: :any, arm64_linux:   "96fc9e584bc08256caf2878393376c90437e4a4e89f6cef29ed05fae5797b755"
    sha256 cellar: :any, x86_64_linux:  "0f4aed53122e7226d901762c87998fccafbcfe06641dfde2f3bd1f34b05c5804"
  end

  depends_on "protobuf-c"

  livecheck do
    url :stable
  end

  patch :DATA

  def install
    system formula_opt_bin("protobuf-c")/"protoc-c", "--c_out=.", "pinba.proto"
    mv "pinba.pb-c.c", "pinba-pb-c.c"
    args = %W[
      --enable-pinba=#{Utils::Path.formula_opt_prefix("protobuf-c")}
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
