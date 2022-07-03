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
    sha256 cellar: :any,                 arm64_monterey: "0afe7796d13b79e8d5d47fcb2f49a736afb968a13f5f07f40a5e16da19d46c6d"
    sha256 cellar: :any,                 arm64_big_sur:  "68eb3ae1619959ed84d1f3c9f234fb9f768709b2b5d322dce23c19e2221851cb"
    sha256 cellar: :any,                 monterey:       "87857aeead5e0e762f13914e7ef7fd43d137c1e5a18149b135acb2d2d97bfc49"
    sha256 cellar: :any,                 big_sur:        "57347bd3daa5395df7e5b4045ff62773bcea9814f8f1aa9c19af0e22aa8da26f"
    sha256 cellar: :any,                 catalina:       "8b116eed25af94f2cf5dc804a538c68c5feec2cc5a4ab64899a54ee52bd84054"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eeefe10ba5231073ed45f538e9e4d57b2dbf23b0d2e99b2dba1e863fb8faecaf"
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
