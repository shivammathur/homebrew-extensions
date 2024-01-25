# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT83 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "f01a17096ac0c31e4e622b75a952e62cca85497517694e78e219bd758597124e"
    sha256 cellar: :any,                 arm64_ventura:  "3214588d0fc8c8fbf7c46e642c3672a817d097c4b07e567e02734df8c524cf13"
    sha256 cellar: :any,                 arm64_monterey: "354e7945d5027a51d543bcd15359b7159e015491d42b3130ac5d1c25d79ad78b"
    sha256 cellar: :any,                 ventura:        "7936ac3968166762a7ea3928d88cca272ecad1337819e0c45149ad897e8c923a"
    sha256 cellar: :any,                 monterey:       "649618bd7a94f889a307317ca7337285aeea8b8debbd85bc13868640ed6813bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e9b60a296f6c44fc81ebcd7422322514e84662c936663e3fbfaf560e78502909"
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
