# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pinba Extension
class PinbaAT70 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "1871e98adea0f0581e2a8faaba7050e4f198afdffdb026aed83c78d42037edd0"
    sha256 cellar: :any, arm64_sequoia: "05af1bd168a54b1abd2ff777c7c1fdec9720017a3d4487e96b578e48cfe7238c"
    sha256 cellar: :any, arm64_sonoma:  "892bed08785d1a823bc09a54202746152cb90f2ca9e4302c87b8848b22bd6593"
    sha256 cellar: :any, sonoma:        "abd2db2c0dc41e64c790cb628c6b0dc232802f3408af3c8f0a75e595dc18cdde"
    sha256 cellar: :any, arm64_linux:   "97e98c8edb2c8bfa503f9cb5845def8043882f62c0d71b74af7bfea68b002c9a"
    sha256 cellar: :any, x86_64_linux:  "142257644a1752f6d3d2eb9d0c7039128935da363c7cdd407a1b40ae212ef985"
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
