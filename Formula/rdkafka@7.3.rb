# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT73 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.2.tgz"
  sha256 "b250b0b6df32484e59936b676983ba134376d15652f02552b2bf0482ab2cbce9"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "ef2e3f036b9ebdd15493c6859bcd9965c84ffc600a61711386bee9ce5fd27518"
    sha256 cellar: :any,                 big_sur:       "835770ebc2ffbd31e59294d56223cd9b9d1360e28107f4055b3a34fd658d1845"
    sha256 cellar: :any,                 catalina:      "0ffe91ea6515a7a6b042553eb2bcf23ccaf1e216b0cf50c98eebf5e861818755"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bbfb382d5c0080ac68b83ea3f8653a5cea6e27628f86702534ed686cb0770213"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
