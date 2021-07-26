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
    rebuild 1
    sha256                               arm64_big_sur: "f240f0e09335ef2ee259733eec99e81dbf50b12dc135453cc2c9caf40ae4b6b5"
    sha256                               big_sur:       "194a30b7c362afbb0ffe79697312601921b677414b43c5672277d3d515f39134"
    sha256                               catalina:      "8bf6dd98866e9776ef925cbabc27f135f800138394503793dec3bdf391005b5d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4196cfcc8d1f1365c72351634e9ad08e41caf0d165690b2c62c19ceeade4db1d"
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
