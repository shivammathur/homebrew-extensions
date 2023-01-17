# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT82 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "d768be4154288253b13b7a1aeb22a7e59c433b8eab32143d7a16136010e100bb"
    sha256 cellar: :any,                 arm64_big_sur:  "68c519d9a8ddd9361ddb926251df94da8c9cf0fe6595c16e882169b88a9237f7"
    sha256 cellar: :any,                 monterey:       "4528f6a36662e41efefe17a724d33d6a0ae70eef5fa21753a0a817b4a00956c5"
    sha256 cellar: :any,                 big_sur:        "02c4a091cd0c15f0c2c9b1ffc7aa921b608735ff83ca1d0b029a8ed64508c3f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "45c46cf2fc0344052cf3085ce46a818ee29a017b5ef6d984c9a5139c4aae1bca"
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
