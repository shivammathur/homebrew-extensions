# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "c88d1fe0636bcf1b703ec8298cbd4712d027a65e69bb73c04506b1389800b056"
    sha256 cellar: :any,                 arm64_ventura:  "c490e0da1664df52a0e42087c46ba30cb84c07e15d3694d116ba49553dfd974f"
    sha256 cellar: :any,                 arm64_monterey: "cf71103c4dc78c97d42e243bfb360eaaae337063c3538e09585550db3b37399e"
    sha256 cellar: :any,                 arm64_big_sur:  "e364159a7cc818752cea5c418149bb2a70d0b2556170ca2c4d05fce0762346da"
    sha256 cellar: :any,                 ventura:        "cf727fc621f42c9b8a96350dbcb967bc3671a9d604a90b064294a31077930767"
    sha256 cellar: :any,                 monterey:       "5d091a7ef8220dd0d256a3cb7ab6e1ff3f6a465501f20558312d1ab8fdeeb6af"
    sha256 cellar: :any,                 big_sur:        "f207d6150d68035ba533f4bcf1e272888c00eacf468ceaf519c558792c53ba32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6416c224188d35055939c912bf07eabec9982ae55bcc7fbdaa678542cf0bf7a"
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
