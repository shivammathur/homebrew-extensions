# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pinba Extension
class PinbaAT71 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "90f46dea652ce072c906fd884c6f131764c8fe7ffdb05199f5f0029980fb0262"
    sha256 cellar: :any, arm64_sequoia: "a3199d6e7ec08f782e51be7b8223dc38d60ad56740935e3111bbf42e3448038d"
    sha256 cellar: :any, arm64_sonoma:  "4e02b3d3d7d605a6e3abe7d61be7651ea51f503a31080466b929ec0579deeac3"
    sha256 cellar: :any, sonoma:        "f3fe84795814f2dae93bc8934cc875f2461b6cd8d4b551b0a18cd9b9a46b6068"
    sha256 cellar: :any, arm64_linux:   "a52073d66dd13616bb0e34dc911b27487547998b755baab58899c8fee1665a91"
    sha256 cellar: :any, x86_64_linux:  "0641bf83025db4b5813f9f03c8e344965a38ba31ec3d26e23051d54ac20b00a4"
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
