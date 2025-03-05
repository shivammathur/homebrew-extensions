# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT85 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "5a34ff9fe23e24f5ab2e9df4d6446523b3c8beab9f6fe33e517c338571d7c4c1"
    sha256 cellar: :any,                 arm64_sonoma:  "a5e9ee6e14f84af2d5f1d2eaa37b42d1bb44cfa4ea55fd8e15dda3142487a930"
    sha256 cellar: :any,                 arm64_ventura: "dc55546fb4e43a970f962d1414dbfe405568cf16d102d8233a7509b2c3977780"
    sha256 cellar: :any,                 ventura:       "c2ce9d079e2ffa733c223a213f5be7d84e479b511d4cc5306f16db59d6369914"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f917a0490cfcd3b7d13ac9807beb6f7d4c75b1c1c920d49463f59965e5fcc13"
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
