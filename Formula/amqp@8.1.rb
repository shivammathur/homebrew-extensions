# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT81 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.0.tgz"
  sha256 "c3fffd671858abd07a5a6b12cb5cede51cc4a04fa7b3a25e75dc8baee14bce01"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "29cfdf1815f1e0d1c3b388bfe7f8c1d6f167803bb77197fe04c03e7d0e00b339"
    sha256 cellar: :any,                 arm64_monterey: "d7b8c0d2a5d49e56d17906ac25f8121bad44f053a06ad320c8204f877d046b70"
    sha256 cellar: :any,                 arm64_big_sur:  "accbff15ff194f557a1356efd94a17f4a24d7310f5dadfbdb7b2f5b81242a033"
    sha256 cellar: :any,                 ventura:        "bb50e46979ae3b511cc81bce6974cc462492b2149bab5fa700a78a59531ff2f1"
    sha256 cellar: :any,                 monterey:       "b3c46cb6b107cb119bebf2b90b21313b0ad1e66591b0254a98879c24088ffdeb"
    sha256 cellar: :any,                 big_sur:        "8ec6e289de30ee80dc0bcf6c0484320e33795f196e9a424de04d7958a7af7f4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8bbea9d228a6fe5fcec270cb60cb7aebdc465f9ad39d0aee3b069c540e9e2d9a"
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
