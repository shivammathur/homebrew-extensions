# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/4f346fc187631455b5180d368537c5d9b06fd0b1.tar.gz?commit=4f346fc187631455b5180d368537c5d9b06fd0b1"
  version "8.7.0"
  sha256 "717462b35f6dda6f9a138f0066f5273a53706619860773604be42824402f32b5"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "ab63638b055895f7ce07fb97451e5427eb39ae364d95389deee97363e06227c8"
    sha256 cellar: :any, arm64_tahoe:       "70e9d8df96ee34e18fffe64edf575828dd08ce7068d94c1e369fc17a6d7ee2fd"
    sha256 cellar: :any, arm64_sequoia:     "d7e67f840a6595b9e01b01528ac878f3b4621f75150be4e819d8fe98dc89e015"
    sha256 cellar: :any, arm64_linux:       "e10a0b3b9ff6e2feed2306e45fae0cc30a8306ec2415d0dc2499d8a3d0a272d1"
    sha256 cellar: :any, x86_64_linux:      "360abf43da55c44be7ff5f708dfb29b4f822331c6f8109f82ca109479c9c3266"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
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
