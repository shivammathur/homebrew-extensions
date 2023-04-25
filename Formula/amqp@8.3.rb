# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT83 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-1.11.0.tgz"
  sha256 "dc5212b4785f59955118a219bbfbcedb7aa6ab2a91e8038a0ad1898f331c2f08"
  head "https://github.com/php-amqp/php-amqp.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "be47f383a8bb562f08107aa020c08bdfa37612e04e7a135c74ceda60f89b788f"
    sha256 cellar: :any,                 arm64_big_sur:  "365f244f2004fd1614f6e96363358b245474950068cb91ccc15bccfe9ab8243f"
    sha256 cellar: :any,                 ventura:        "9693f4ff84c409df5fff2f654f870fb94d35381865c55c0d95558561a068118f"
    sha256 cellar: :any,                 monterey:       "7c7e903c7ef790a8dbe7e356587bca5a005b081e24e6853909cafb32ec45694a"
    sha256 cellar: :any,                 big_sur:        "52ba0cef1815c450151890f72b5d65ff6af9dad93423323edbaab038865ae847"
    sha256 cellar: :any,                 catalina:       "9b45ad279027ab15c1ad0d927b1122a3fd84d5063bfce1591c8f47345751e564"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a91b2062a083f246d0c2e2bccb682bbfefd68c7de55e462708a56e8839721a69"
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
