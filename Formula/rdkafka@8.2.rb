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
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "6319f7266a753de058f4a11cb30dca861143fd810f362eeac4ea73d28923e537"
    sha256 cellar: :any,                 arm64_big_sur:  "524f65e5d61da01dde73028f0f49978bd278713e5b69656c63dc9b5b9f0a9242"
    sha256 cellar: :any,                 monterey:       "fe815afea43453cf0f0f89776cebaebd208a9dc8421ac691bc2530ed088038f6"
    sha256 cellar: :any,                 big_sur:        "656b9207ecfdbdd91fdca27e8d9713dcd34c3c3dbc998349f54a4782fede9e89"
    sha256 cellar: :any,                 catalina:       "1471bedf9ce80b338273646c4b9ebdeab84ffe6774a7ab4146b3f131913070ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6512b226746287d7cf35b2024351a7d4a88c0313dfb2ba0a40d7807c3638744"
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
