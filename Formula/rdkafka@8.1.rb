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
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "39df9b515eb9ec0b3dcd86d9f3bc65049af1f93f592947942c309e5e99e7e4f9"
    sha256 cellar: :any,                 arm64_big_sur:  "6ee91224bc525ba25caeff5afbca83f4ccd5208b97c7fabad62694123c076c9d"
    sha256 cellar: :any,                 monterey:       "589cec906caea148bd868086b10d1ec2ce399e1a0fcb365f90b5772a711a85df"
    sha256 cellar: :any,                 big_sur:        "6394cf247f026a7be97aa87476363d921222b960cb78b995a053c61a325e8ccb"
    sha256 cellar: :any,                 catalina:       "9af76259e1503b304b7bcd375beeae7c3232ad8626a2b91cd15342b54c139fb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6f5afe7b07a1bf8956dd40fe0c2620823dab89ccf963554939cb026673434edd"
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
