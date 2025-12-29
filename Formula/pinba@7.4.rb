# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pinba Extension
class PinbaAT74 < AbstractPhpExtension
  init
  desc "Pinba PHP extension"
  homepage "https://github.com/tony2001/pinba_extension"
  url "https://github.com/tony2001/pinba_extension/archive/refs/tags/RELEASE_1_1_2.tar.gz"
  sha256 "7df27fb3e9de548459b56638394d824781c8f13395da1a0b7f94515f03e15ddc"
  head "https://github.com/tony2001/pinba_extension.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "74133fd3aff39f17b1df636f4bf6f250448fbc476f24662d92e7fd92bf113a49"
    sha256 cellar: :any,                 arm64_sequoia: "b36b1f44a68bc6eacbd31ccebc6ee17a5ea91bb2398953e88e32ca6bd4953a38"
    sha256 cellar: :any,                 arm64_sonoma:  "b960a8b997e35673bb7a9ae39c025a77da74a1b2a4f67f44f09c5d910cd5f2db"
    sha256 cellar: :any,                 sonoma:        "9ce15c33763917b438be6dabacc20816473252be635522577e56dd8e13202dea"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e9b2ae4c3ca04f1451b7a9f9ad52ab4fccac75a453390e9622452a6e23a23f30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f032e96be7e6b3c808d1f26e14a7e1c8596b7707e97011c259de5508bdf3e961"
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
