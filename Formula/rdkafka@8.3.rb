# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT83 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "59566736e7f68960b26cf93d7a2ccbd8689df311f1a715ba935f128dc42514c8"
    sha256 cellar: :any,                 arm64_big_sur:  "4a478a6fd7a5d7571e8636340e6950c1189b270b0fb2f56eb801e165f10d740f"
    sha256 cellar: :any,                 monterey:       "0f5a2b9b99156d927a46bcb4a8e5b0abe0320d5f6907a0afc50f56acae020388"
    sha256 cellar: :any,                 big_sur:        "43ef486789140caddd9be292e80f030121793a1c885148504c98ba2bd40dc335"
    sha256 cellar: :any,                 catalina:       "25eb45ec6e2012e54c03925cd8f3389d8b0a73ce45066e58980f0c3a4f675660"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b949cc966a7244c9ae3b02e32062288dabab843e2e1db1a10798ea953dfc06b"
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
