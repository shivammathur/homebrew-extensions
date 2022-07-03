# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT80 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "70803b5948b50bd35a1da34ff10d3a5e094925a4ddce42df997b817fb18dc903"
    sha256 cellar: :any,                 arm64_big_sur:  "8444411429b0945656191d12976c7345316495e389314cd2fec6a7b8388f6851"
    sha256 cellar: :any,                 monterey:       "9293a9edca27156c18cba6beb1cb9c7aa9bb9cdbb0bb62ab4dcf863478acf338"
    sha256 cellar: :any,                 big_sur:        "2bf44710e9e2fda46a07acf3ea92c5dd4c9a628ca63e16665578ac0ce4019e49"
    sha256 cellar: :any,                 catalina:       "0c9c21c3cae05f65e44f5c8b193e799e841994fa3e8d97e9e403a93412aeb846"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d52cd1dc71732fe4b79fe2104c7f47190f6ee6d0a7dbc854e5ad5f916063a2b7"
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
