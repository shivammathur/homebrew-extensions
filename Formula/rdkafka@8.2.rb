# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT82 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.2.tgz"
  sha256 "faaf617f1cae0e85430306e078197313fc65615c156ff16fc7fc3b92de301ef5"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "f7f3d2bab67dce7b1df8db5ebb2b9b1b8ca3d51f3b9170ad694d40d453b2ff22"
    sha256 cellar: :any,                 big_sur:       "793d6d379b01103b7275c89150d7a3ed40dff202dad09909add88300bb224024"
    sha256 cellar: :any,                 catalina:      "4da29f143ae64a3973c53e316d7dd3b9b49ad6b945de0a4868130c8f1357222a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5bc5b6f0f678e20eae3ea889bba318acb89bfbc6560dd6a512af7506052f2e90"
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
