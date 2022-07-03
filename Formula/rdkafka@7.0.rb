# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT70 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "364b66eff42c79842c3a385f68404e7d4c29ea399604f07d555149486b4bea0b"
    sha256 cellar: :any,                 arm64_big_sur:  "0393f0795c8d3acf5232c8e3ba4d371e647285122876e8d9779b8d7328b119eb"
    sha256 cellar: :any,                 monterey:       "3c01b62697f118be2b6640fce18b942d2b97294e530484f3234c73303c7fbc68"
    sha256 cellar: :any,                 big_sur:        "94eb09ac7b376bd0e036bae52af59a29eb4c74c122b980581e19ffa8dc1aeee2"
    sha256 cellar: :any,                 catalina:       "2c943bd0c9df4cce2309b24951a7382332c41969a3f8af812f4172b064a752d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b848149482558bdbd79d0acd22f0746b852165714bf219a15a4fad6f9fda197a"
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
