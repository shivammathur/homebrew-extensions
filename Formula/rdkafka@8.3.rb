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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "8a4e9182a33e391a2a2801c124524bfa17274f57526451b23d03adb7d94bd8ef"
    sha256 cellar: :any,                 arm64_big_sur:  "a95a5b3cf772f5120f8979339ce8bf505039f35e026815cb3ce1661e84bfcf31"
    sha256 cellar: :any,                 ventura:        "4f7792f43d783be308be74e9f1f9e2f03fc7297405e884e63a7f68732101f508"
    sha256 cellar: :any,                 monterey:       "005d7886ed77b5e93495ab003581fe6bb4abc81e73effb61cf6583983cd40c9e"
    sha256 cellar: :any,                 big_sur:        "2b1c3d7056a77e701aab21d6130261cd0261789846350ae8df8da2d0662fe512"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "61a5ca4d70c83b3a0723efa6aafa2e462873deb44581a1ea605426cc331bbd5e"
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
