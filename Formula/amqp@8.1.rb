# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT81 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.2.0.tgz"
  sha256 "5ae624bd785e299523f6132c204bd562cc73066dd33a10a12aa96389f55a4de7"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "312e66d641c931f1f2c51b701419d486cdcdaff04eba6a4790e7bdf32b57f81e"
    sha256 cellar: :any,                 arm64_sequoia: "1ea7e7517588047246dabb6187ade7ded69cdcc7690761736e21f718b3501c67"
    sha256 cellar: :any,                 arm64_sonoma:  "2c21f7150dad16d481bd2e6cef84c05a5f923c46ee78b7f8a6f3752372788dbd"
    sha256 cellar: :any,                 sonoma:        "df16fe507ba9b3e1e55e851300ae71a40c180601448792a41e485712f1b2f7d7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b87b0f4851ee08f86aa6e11abeb588572d6c62e0ab46cc8f9e8299d05524e745"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a61df34651068ce9c51011b61b85326f813df2ac105e6f06ce3ec323ca76d17a"
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
