# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT87 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/5e19866c1766e38c527f9f94faa170370dc4209f.tar.gz"
  sha256 "a11d140cb67da8920df0a063c4d77b893b71b0195bb96f871c5f5915e0544ec8"
  version "3.5.0"
  revision 3
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "20cc1aff9d2142afa42f0cf9f95fe9573e8a897c4b931b66163300fed7756658"
    sha256 arm64_golden_gate: "e8ba1025907a852f4a5564fee832a4d083f8fe5eef78902cc962c5693a77f294"
    sha256 arm64_tahoe:       "923d0374d5718b6ff7c99999c348f05031bf2ee7bf9a132c5c840b6f62b46492"
    sha256 arm64_sequoia:     "c275ef6db88b23f450a87c3bcaa2578493129511430b3bd900d7ab30d0da2be4"
    sha256 arm64_linux:       "6f28e723f2cb9662803ce4ab609baf6feafae9a73a5b7a8e5a5aaedcbf3b1024"
    sha256 x86_64_linux:      "6b8d4ba7913468b0e02dbd52fb6ffb6a09f497117e398df16e1780cf2e1e4dd4"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "config.m4" do |s|
      s.gsub! "8.7.0", "8.8.0"
      s.gsub! "80700", "80800"
    end
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    inreplace "src/lib/usefulstuff.c", "ext/standard/flock_compat.h", "main/flock_compat.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
