# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT70 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/rdkafka@7.0-6.0.3"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "8e084fe56ac75dcde57fba24a2cb9248b1e2e4340b27c76205b22b89cee48eff"
    sha256 cellar: :any,                 arm64_big_sur:  "15e9fe58050b9231b481cc4e2bdd1ed81d5fb10b45530d0ddf9b9822a55bdf30"
    sha256 cellar: :any,                 monterey:       "acd5d57fd7fecb26ee89e12d4ac14e9e3904292d4c55815678f652bc34d1f28e"
    sha256 cellar: :any,                 big_sur:        "0a375bbef987160a7287eff192e6b41c6f201c502fabeabe049a04ae4ff7a659"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "38db21539a5703e56555366353affc5f0e788f210e616310aa9bb3313dce61b8"
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
