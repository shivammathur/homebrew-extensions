# typed: false
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
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/rdkafka@8.1-6.0.3"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "3a5bf34a49f049c037e84119ac52189c413d6c17444b779ed5bcc9817fa0157b"
    sha256 cellar: :any,                 arm64_big_sur:  "69f785d58e2b47c9196ae788361cfb6da2d9db29b4c01eaf0842c961a71cf125"
    sha256 cellar: :any,                 monterey:       "93f9c6b495ca47dbe8f17f5d726408f33b24d3bc26756da3a9890cdfc0cfba7a"
    sha256 cellar: :any,                 big_sur:        "2f418182d6ef700e24241d92a75af246d1ec0d67a439e262addbfe4ca94344b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "49e535d3fa8c2f99b2c317cb6d96bcb5639bbfb369cb64c301da2d8859e18aea"
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
