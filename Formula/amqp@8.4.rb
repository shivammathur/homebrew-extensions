# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT84 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "f526973dab5d142b24f9719fb6be214303cbfae4a9471beef97bf49235d65a79"
    sha256 cellar: :any,                 arm64_ventura:  "46fb4303fb80a4184da67287571390180e94a2a09e2229147bf9438a30086bdd"
    sha256 cellar: :any,                 arm64_monterey: "8e43a20bfc6dd0051e777ea8551d45a9aecc6086d7ef353315dac805bb37b461"
    sha256 cellar: :any,                 ventura:        "8cf2e5a677398078cc25ae79b5b0d93f99e7590e124d65c9f177fab5e02d5b0a"
    sha256 cellar: :any,                 monterey:       "5848e396138cdd71b83dc12271179a91012239c23039a97cc5315e628c48c1ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bc7b36b3864c3c8b8564e83bb98ec26f165a5c75994bc85311b5bc0231933f4c"
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
