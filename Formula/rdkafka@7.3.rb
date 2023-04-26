# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT73 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "2a790694aa64b1bfa98523a397d876510320549bb5595586ab3d7b816ef99e83"
    sha256 cellar: :any,                 arm64_big_sur:  "80dd805c46c88f2d03d1981ae023b87e492d9c625313812a05c12f9d884cbc8d"
    sha256 cellar: :any,                 ventura:        "8dedba7512e3d32a65386973f137169206d36b8c0684db304c9c992fe23dc53a"
    sha256 cellar: :any,                 monterey:       "9ea487fd60ee3df9cda7bd41d39303fea1705198f19b93793b36be362839e833"
    sha256 cellar: :any,                 big_sur:        "13a92ff7e11fcefc3292fd152de016a76ddf8d0ba1d5342dcc88055ddc368855"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d5816afb65af9846380328a3fb5a47975f90f2d1ae1f30ff252de6bd4d322e64"
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
