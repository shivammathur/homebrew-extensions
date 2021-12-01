# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT81 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.2.tgz"
  sha256 "b250b0b6df32484e59936b676983ba134376d15652f02552b2bf0482ab2cbce9"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "692ab12914e19cfa30669e4479131277ecb741e3b82b6ca8565cc54f693ff9cc"
    sha256 cellar: :any,                 big_sur:       "7e099e83f808fdbaa57ac36314894d7a29508a70076ebf2f62614f1e48e57035"
    sha256 cellar: :any,                 catalina:      "f11a479529005afec7c8acb8d0a5eb13fd3f290187a74036502286e3d237fee8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10f8ee238ab9356f5832f63a979dcf05e92c0c6a810a877d56c6f30abb6f7c70"
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
