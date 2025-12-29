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
    sha256 cellar: :any,                 arm64_tahoe:   "8bc4bacc26ee2c4e07851729ec4c13f14811496005311acf7d4f8fec15dfd2ce"
    sha256 cellar: :any,                 arm64_sequoia: "1f6e5131bc34f5c397b6c73dbfed3b2286eb6d1d7c688494e45d5c84217fe669"
    sha256 cellar: :any,                 arm64_sonoma:  "7393a8b13cd72ff0141d27693867e391114f0b08fb036035d5b4fc3847599fff"
    sha256 cellar: :any,                 sonoma:        "e309a6e4d7e4be543184cb72cd4e5a7d0fb2e7ae561855a97161b31c92e6ced3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "103bd04e35c7ca4e3d52cdfde9b6c80f4da933a51d0c39f96ae2224d39d020ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0b35b27f2e9df18fffcf987516b3966b15937b453c28711a5f3851b24f42b35"
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
