# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT71 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/rdkafka@7.1-6.0.3"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "b5a8b05873b467db8fdcb3a622b9d3ceb3979ae4537682c201e811ebdd221563"
    sha256 cellar: :any,                 arm64_big_sur:  "5442f67ee12db8739639beb04a483ae63d26d413edb7c10777f67ccb2548c251"
    sha256 cellar: :any,                 monterey:       "04f2f4973e00998081b147746addafe1c8e7bbb26d7acf106709c8055f76d494"
    sha256 cellar: :any,                 big_sur:        "bcd9dbe2111ad7b499b61a00329e7e6867e545527ceebf0c4235d94317c2e9a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d4a0a610657e524d59a3808315e74e3b28d4d76de610577c57d524b14a7a65e6"
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
