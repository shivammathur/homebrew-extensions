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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "8f543ca419a1d3ba3e172b259095b5b80db58f674a8623396c9c3018897390b5"
    sha256 cellar: :any,                 arm64_big_sur:  "c0753c8f6dde30ef293a841e2de223c2b2169e0287995227fcf8d5b764e0ac15"
    sha256 cellar: :any,                 monterey:       "8fcce6db4e32b347594b6d86a41ca16e1e705f23f9bba85253edb5d2ee6c5834"
    sha256 cellar: :any,                 big_sur:        "8ff7a384e2b4335ccb4d24309ffb5df10b499025d273a92533907ad3b9dcf8f9"
    sha256 cellar: :any,                 catalina:       "e0e6828aa5d96cb7f2b5bd507c58edab20a4fed0d84377ec5c3406091b46d1ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "243576f9434171f7a54a355f9036e8412298fb199aa8e5f9e0965d441235b579"
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
