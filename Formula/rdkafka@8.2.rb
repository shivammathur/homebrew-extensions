# typed: true
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
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia:  "7a659498086457f0a0d32e0e87bd1b282fe88603195137e0dd5c6bdfaab9e02a"
    sha256 cellar: :any,                 arm64_ventura:  "a64eacdec9db436e357de489c5f4db59707e1d6c8b0ecd9915c155c4d775cb37"
    sha256 cellar: :any,                 arm64_monterey: "7fa54c761845f31045546a6777c0572448df8d7b14d0c20b45b990d62f7f2d45"
    sha256 cellar: :any,                 arm64_big_sur:  "9d1079b6bc9bedb4a844334efbb48f400a27d5f5e636a84da6d2dc22f2250487"
    sha256 cellar: :any,                 ventura:        "1b88219d71def453be57fda0492830e5bf7ce3f47480f6469f727ddf1bbc2bf3"
    sha256 cellar: :any,                 monterey:       "28c34a35ffb1ea81fb0f748ff02438551f832e13ebfa257c47dc74df5d7f0ee1"
    sha256 cellar: :any,                 big_sur:        "3e1a3236c01f5739a28918b48b90af2755336b068c718edff664508347e2a045"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "797f0983af68e349cb6e3b102448bff358f4035282d1072177066e78d0de3b81"
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
