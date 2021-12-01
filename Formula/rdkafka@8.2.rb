# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT82 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.2.tgz"
  sha256 "b250b0b6df32484e59936b676983ba134376d15652f02552b2bf0482ab2cbce9"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "74f0cd17bc6d6f0dc75e85cfe6f6aa8cd73517ba3094b38d71c513c213ee8667"
    sha256 cellar: :any,                 big_sur:       "fa942880f4b935f64921613b065685b335f871c071da799501a0b43247c5b389"
    sha256 cellar: :any,                 catalina:      "e4fc3613d07a7e30a2aa34d921cbb8db06f9d0b5d9bba8a64dcc5b7ef9addcfd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a9325b20d19db444e5190de3ac77e5004d3dc46632b68de024bc6a9d67aa0ec"
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
