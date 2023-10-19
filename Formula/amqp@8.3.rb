# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT83 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.1.tgz"
  sha256 "c9b36f10c2e7b7da472440e21c35655c3bf41983b99bf1e438eac7d5bb1c2b45"
  head "https://github.com/php-amqp/php-amqp.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "e71a332340336848d7219f31cc6917f52bc9fb3dc303a9b8bf7c2feee8ac9a11"
    sha256 cellar: :any,                 arm64_monterey: "41c21cf67ebfa6b7f95c3c2547c9abfd47bde6bd9a6207efe6f8472a26623080"
    sha256 cellar: :any,                 arm64_big_sur:  "5bc25ca3c0b6544c407025ca1d780a9391e754f415080400cf01a120302f2dd4"
    sha256 cellar: :any,                 ventura:        "c3aded3af56e972ede25c7382b609e051e9614623748c329e81553b94092e36d"
    sha256 cellar: :any,                 monterey:       "1086cff91c272177bed599f7615241fc686266e6d86ac3d909f9511408284440"
    sha256 cellar: :any,                 big_sur:        "c3f5b7d853e2f5e80881eeb7614fa1fc7773d83c766e5e21a90913cc552b2188"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c9ddaba032dfd4dfb8e00c31f2e53161a213e90c3dab0324e6c5ca7b17ddcd2c"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    Dir.chdir "amqp-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
