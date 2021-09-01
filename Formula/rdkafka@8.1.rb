# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT81 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.0.tgz"
  sha256 "432fbaae43dcce177115b0e172ece65132cc3d45d86741da85e0c1864878157b"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "3f84cf911cd2988c2b27a9f9b7ea1fe0ab9ff17592dd24bd398ff15789932670"
    sha256 cellar: :any,                 big_sur:       "96f2b9bb12c5b2124519e9eba8885a9f1e8973c573cbb1d3aba69e41bc226a73"
    sha256 cellar: :any,                 catalina:      "f93dd98abf1954eca8c2edb4704f9d72d0b36ba663a668a09cfd5aee52cc2e55"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e18e0db319b9f191290e16b4a5841953f6e81d582bb6834e286bc5406849e14"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
