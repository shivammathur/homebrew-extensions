# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "686841e5012d06a4c9e3c62106ea59ada21ba7fc6def9eb0c5746d9763c0a15d"
    sha256 cellar: :any,                 arm64_sequoia: "48bb07e2f1b4ea9a92f10aaab5c393da2caeafe34d5f3787cce4b1f79abf9126"
    sha256 cellar: :any,                 arm64_sonoma:  "795a80a0897b27da59a5f8f6893e19c5ad747a029b259ebfca384a08b51588f2"
    sha256 cellar: :any,                 sonoma:        "1e18ef4af80433729f25f77689a29bff65330895afeeca49c6a9ef39b90c31fd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7d7c5f6719616169509b97edd72bbae858b7a04b5afa9cf63ba1323fedd04e8b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "134da2ab7ebb38d4adf7abc9911ea67d01bbe79dd13fa6047f6411da9678a4d4"
  end
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/115ea486ac8b4b1b17d3859f2c970e2efa5b12d5.tar.gz?commit=115ea486ac8b4b1b17d3859f2c970e2efa5b12d5"
  version "8.6.0"
  sha256 "d1f17da304e6c0729c463a0ded77b80ba165f8c6a4c81c30a028c3e699f9a278"
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
