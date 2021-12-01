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
    sha256 cellar: :any,                 arm64_big_sur: "bcc948e1b57bb38598ebb05d1b591d6372862fafa6e24f6d662ad07f36384123"
    sha256 cellar: :any,                 big_sur:       "b98cb7b399962243dace365e6b5f1069659eb638aed7a01730b9d1300f0af532"
    sha256 cellar: :any,                 catalina:      "37c2b9580e19bcdc9ea35d8489189a1ae8523a421322ac43c1e4b8cdc654d66c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cff38a95d392c51a42931d4506452b27095f46b7dd2448ad957001d7689da967"
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
