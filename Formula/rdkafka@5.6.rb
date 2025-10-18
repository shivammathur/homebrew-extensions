# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT56 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-4.1.2.tgz"
  sha256 "8ae04c240ce810bc08c07ea09f90daf9df72f0dde220df460985945a3ceec7fc"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "4.1.x"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "51cd4cce52eaad48bf8ee14ba04a23aa7853c08045b6871ad250440e38f19b66"
    sha256 cellar: :any,                 arm64_ventura:  "744e73644a710b3e6d32e42823fa67d3626314ff8dcef502bc0b753024cd5483"
    sha256 cellar: :any,                 arm64_monterey: "45c4a3308c14b878079c0692f885c0adea18add92a8c42a203228e8f2494765f"
    sha256 cellar: :any,                 arm64_big_sur:  "2cc87106413603a3633b5e33f9616021a8c8d77b15a4ae51f03d2c7d05418a8e"
    sha256 cellar: :any,                 ventura:        "0e74090638bc1040f0a6121604595efedc625bc43d079a966ffbfdf34852b091"
    sha256 cellar: :any,                 monterey:       "8b315436937258ef21513f7049b88b3a13f79ca9fadea525dcffdac188c9f84a"
    sha256 cellar: :any,                 big_sur:        "dc0cd223ad773e9917421f6a4c02e0bcc1f6c67c17ee2c5e30161565d711583e"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "4d95044f48e1ab5c02487598ddea31fba34bca792ea9edd30c8ef35973704223"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b275e10a073d1454b2dc0fbc68c7a27d6ae03bbdc54111a09d783697fd5c4608"
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
