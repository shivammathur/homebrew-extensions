# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pinba Extension
class PinbaAT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "e8ffc123ed496f05a94558872fa95781999b9917f1071b08ba78bcf16f1ddfbe"
    sha256 cellar: :any, arm64_sequoia: "979a1d7550a37707cfe2960038356f8e8a49d05159e9848785869b6ec86b34e1"
    sha256 cellar: :any, arm64_sonoma:  "05f5d8379651e086de0813e03817fe7e9f981467b23f9150110344d79736c73f"
    sha256 cellar: :any, sonoma:        "84a2539a555a608b62eb3547f833c4ac3b9c68ea40eaab6cd37d29ffde2dc804"
    sha256 cellar: :any, arm64_linux:   "5c9e42d8fc05efb5192ab3cdca62f43e9df79a614c6d4b870bd2c0f47cd68611"
    sha256 cellar: :any, x86_64_linux:  "92e689a44d06827abd9b6a4c0c68f7128ee721d774cc72d6e5c62f57438b5db4"
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
