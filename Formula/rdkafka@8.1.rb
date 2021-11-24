# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT81 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.1.tgz"
  sha256 "8488988cf210e45a9822afdc35868cb47909ec0fff258a2f9f4603288078fdd7"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_big_sur: "3e2f048e182ebdca4805469f544de0609bacb2b4b19f089d8700981d368b5a51"
    sha256 cellar: :any,                 big_sur:       "7e1fc62c1c6fb7ba7a5c6e7df44a3fe5a39dc0d12ece0df231e3fc0217d53340"
    sha256 cellar: :any,                 catalina:      "86a66fd295da17f8d913588bfbc36056f50a045fa3285556faaf6541cf98261d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ac69a5e8aa41d8a226473a4dbd382d545d348726ad547d53c144767d01b42f0"
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
