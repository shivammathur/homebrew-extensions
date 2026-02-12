# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "e2e3f17b2add5978660f38621e7dc64453504418d91bc9320da58a93be6d5a0b"
    sha256 cellar: :any,                 arm64_sequoia: "c41e67e1be24d2add26dec5f3383db0c7aa609bfca74cc222fa241307213e8e4"
    sha256 cellar: :any,                 arm64_sonoma:  "32105a88f6e4cb91f58512933fb76d575972e57ff23797c933e31af9ea9dfe8f"
    sha256 cellar: :any,                 sonoma:        "dc30103368e1850f66508fbaad60f299dffe518b10cc2dc73392b211ec58393d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0acfebb06e4c340f0fe52fafaf9fd09dcd7460cebcafab7e7b89d69062e43262"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03c8c7910f03d6cbd18e3a04eecc3e4af91cc8676d7e6940e78ec05b640842ac"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/7134e69ab2a73da2a5f0e540a135a559210278bb.tar.gz?commit=7134e69ab2a73da2a5f0e540a135a559210278bb"
  version "8.6.0"
  sha256 "bf54dc1fb166fda8e09483c448677070c142868a1ddc6f1a612ab69602dc0f7f"
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
