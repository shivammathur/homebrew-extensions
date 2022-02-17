# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT80 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.1.tgz"
  sha256 "8a4abe701e593d1042c210746104f4b04b15ac98db6331848eed91acadfcf192"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "126d35af241f69603453d46c5e7206c316d9ed552fbced9e3714766cdfadfc87"
    sha256 cellar: :any,                 big_sur:       "0c700c74e0aa6aeb63f276a97ca7416dfeab4fd99c07efda97c3236f04e781c9"
    sha256 cellar: :any,                 catalina:      "d052f725f13c1b8a371e4bb73d1f92b28cc8f02c4daa1f308bb931a5e082bcd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e5f9202635a4fb4d1cb8dffd954264923bc88b32e1d1de15e94ad1b513fe2c85"
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
