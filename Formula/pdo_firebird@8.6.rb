# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "0ff39db8c2b9ad6848c9d5f3a610116720019797950bb7385d1a123a1c162c67"
    sha256 cellar: :any,                 arm64_sequoia: "371de22dc605b2a83436a549442a88060caaa79df6d4486127c25ebb79a6abb0"
    sha256 cellar: :any,                 arm64_sonoma:  "f54601826059fc33b68fcd2055b671f9ac81323434c0fcdbd37f4b3bc357b1cb"
    sha256 cellar: :any,                 sonoma:        "ec3efd2cd3f8946d9665ae201faab6f14532e61fb8bf4b05dc389780fe33344b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a0d9bc89f36ea484c79dd36746080a31f89ea1c6bd7904c299ca87f8b4fd56f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8769ffe8558b240d09e657164cbf32ea0641a2df08334737e23270a0554de40b"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5fc9d9d9a74522116aa855c33e8de97a3a115c50.tar.gz?commit=5fc9d9d9a74522116aa855c33e8de97a3a115c50"
  version "8.6.0"
  sha256 "059772a5998319f79967331d89a5a8f0f109fe017d9d7d2dc0079f8ca87b852d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"
  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client"].opt_prefix
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
