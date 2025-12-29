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
    sha256 cellar: :any,                 arm64_tahoe:   "ec74d411004c1a0ceff3f49e51276b6578a31fe5bc39644fef429d314ffa4ccf"
    sha256 cellar: :any,                 arm64_sequoia: "0e30a9750853e36dc934df30a16f84a34d589ce64c016ba904b874a88a4e08c8"
    sha256 cellar: :any,                 arm64_sonoma:  "52803d8d8f567c8d04cd6a9d6858a07aba17d0ed66cceec5488e2068396b9327"
    sha256 cellar: :any,                 sonoma:        "60848ce3761d4a5e68c3d53fa814d34594a6291dcfe72b6fd26fb8697c6323a3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "238f62ff71a6c08be1ec031cfd323ff00a47b6a88e8326e2bca0dc18b09eb2dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c883956ebda0029f2a5acce0bf3d6cdf05bacc16eb95f43aea641f4eec753c18"
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
