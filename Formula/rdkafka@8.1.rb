# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT81 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.2.tgz"
  sha256 "faaf617f1cae0e85430306e078197313fc65615c156ff16fc7fc3b92de301ef5"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "50059fec00d90cd0a8295f08e591c9dd0c332e2cf19cda80cc52b9683e9b4c62"
    sha256 cellar: :any,                 arm64_big_sur:  "e511c1cff3eaf879f48f65e8a7847d6b6782d5442565bd0c1ac5b329ea317bcf"
    sha256 cellar: :any,                 monterey:       "4bc925c8faf2c19904295c0b96836351662e88d9b99348d94a54ed6b5d7f1d51"
    sha256 cellar: :any,                 big_sur:        "c36f1d60fa495101adc6d801e2e6e9eb85b56f89d5631ae45c72f21c53132071"
    sha256 cellar: :any,                 catalina:       "8e5f9dadbdd5c2585e9d2cccd6689a39f734da0e9f8298d7be32f7505642de36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "186b657a883dd02ddde8d25d8f5fc54681cc5d5285ba8dfe8528a3c1101d54b6"
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
