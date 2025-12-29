# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pinba Extension
class PinbaAT72 < AbstractPhpExtension
  init
  desc "Pinba PHP extension"
  homepage "https://github.com/tony2001/pinba_extension"
  url "https://github.com/tony2001/pinba_extension/archive/refs/tags/RELEASE_1_1_2.tar.gz"
  sha256 "7df27fb3e9de548459b56638394d824781c8f13395da1a0b7f94515f03e15ddc"
  head "https://github.com/tony2001/pinba_extension.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a668a195b4e12ed3f4f6030821a697cd4dc3f566f6956e753cd91d93216ff796"
    sha256 cellar: :any,                 arm64_sequoia: "7d1f4a56ad9cf80177a19b4e31352d278f9f084dbbdb8fa78e3f3237fc307c49"
    sha256 cellar: :any,                 arm64_sonoma:  "1361dd0cb3e62da09aa72ecb8fc06bcc51da2dd432de1df0a343fbbe699f8bcc"
    sha256 cellar: :any,                 sonoma:        "fccbe4902e136796127e0bcdcb8911193ec5a1522fb652ccb5761e04748e9fd7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c76bb2616e7e2382232cd21343d79b6a9b3e1eec5c262c79ee57cd13e989f3ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f06a3b4d410e8a6e6b580b6128eac20a4b8ebfecd10356454d7d6d95a5f5ee14"
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
