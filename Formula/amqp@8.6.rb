# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT86 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "0fc9a23b54010a9ba475a1988d590b578942dbdf14c19508fd47dd09e852ab0f"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "7046ed0d0d1cf58e8c7b83f37701d3185f0285b03e7c9d710330d46fa8c897b9"
    sha256 cellar: :any,                 arm64_sequoia: "fe5ff98a0127090431ca715de0ddfa49b079a6763e83b8bb0a0e1de2f43e9940"
    sha256 cellar: :any,                 arm64_sonoma:  "2bd4348205c4be92d6f43b7e4a815b65f3ac7584f03b2c36e8cc343e15afb735"
    sha256 cellar: :any,                 sonoma:        "d87feb37572f9c1d5add9eb80f3cae1dad1fc8e56ee1de7d2872bb060446242e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f689248c30d1be1bc90aee745f8b92784bf4e2224714a406cdc9ee98b7ac0803"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "50dfdf552ccbd177f4910f47b9b792ca806720127b0dcafc1b3a22a4dbeb535a"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
