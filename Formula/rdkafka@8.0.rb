# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT80 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.2.tgz"
  sha256 "b250b0b6df32484e59936b676983ba134376d15652f02552b2bf0482ab2cbce9"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "a436b4ff2dd5a69debfdfb726a5b92301fe6104a0f8de8d5ec75da82287356f9"
    sha256 cellar: :any,                 big_sur:       "d1e9782b7ade3b44afa5e6f2906f193d9369100a4e98f423ed83b6567619d468"
    sha256 cellar: :any,                 catalina:      "07fc68080db511f1444662afb798204160c41b58d77663c5e3fe9a0b60f5eaed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0d0f6c78ba5ad5ceac8524a9269b41de3a339441b16d30cef15d26281747072e"
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
