# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0173ef4b84697a6d7964248a0da0faae4cff7fa4.tar.gz?commit=0173ef4b84697a6d7964248a0da0faae4cff7fa4"
  version "8.6.0"
  sha256 "9ba1a54d32d44c2e1b019705a892c9a4b46c13983a3f7035c3fb6b6c8f8c0f53"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "4b2574e1278cf99139ac2124d35bf62f0d1cef2fc69d6d950fdee6a39491c538"
    sha256 cellar: :any,                 arm64_sequoia: "be635299acffbf0126c1ddcb938d709904cac1dc65c5fe4952a19481ba52c7b4"
    sha256 cellar: :any,                 arm64_sonoma:  "cfebd425ba97864cd355fe41f60f4d8ae78f33630ade5712bf612aa804116fa6"
    sha256 cellar: :any,                 sonoma:        "b66ec95fc4d115bd7e2fa1ef24ec07e6311d4449d1916a2b13fda47755e076ef"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a2ac449588e990ce2340ad2171cd724fd847489de9216527941e874bd8028d2e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fb89913a40340e4667633d04a66df8b3daa09239350608dfeb8d8ebc72371c1c"
  end

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
