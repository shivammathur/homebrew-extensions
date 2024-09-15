# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT81 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "53508f14e40f49d60885ceb3a8e3b194620d8ce74e735e99ac94af81d8b33d92"
    sha256 cellar: :any,                 arm64_ventura:  "965a76bf80cb0c8d8fedd6cf43b1c63c0f2d34684acb319e2ad1f2b3bfb21830"
    sha256 cellar: :any,                 arm64_monterey: "b4b8e6937cbdee8b596f0097919f68b04e5dad561ea9d1f0b3ed000edd46ad56"
    sha256 cellar: :any,                 arm64_big_sur:  "64bebe0f67ba170af0262ee251c7d19ecb1d3fa6db63006054364e19c49e79ab"
    sha256 cellar: :any,                 ventura:        "6206bfcd2f0ee8e89e94f3b537ccbe3cfa7baf2e97bf88d5c5ddacdd61a8721b"
    sha256 cellar: :any,                 monterey:       "23c9b1bab9615c56c964b2a6faebfb827c58289290b7b16b59df18818e96ef4a"
    sha256 cellar: :any,                 big_sur:        "ddbba1dd2710befc54207d3a14e7690f1a752ac2861252ee5ed88cb8a289edf3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cec0d373856c05c5f1447184346f7672787067b82f3a922c000664f7b3ee44a9"
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
