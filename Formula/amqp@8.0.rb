# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT80 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "83204ba65b6aac62fb71381b57cb8262b879e727ec13687e74cfb25687e7602c"
    sha256 cellar: :any,                 arm64_sonoma:   "9baf8cbbd4b5147fe76086ffe02df8641fd4845806fde5eb82abb23ded5e92ba"
    sha256 cellar: :any,                 arm64_ventura:  "fc25b6fc67b3354b3809d0bff4312fe52842202c30b913be93866fd09a49af25"
    sha256 cellar: :any,                 arm64_monterey: "4534512ecd49687b9b4a704917a93425cfb052db144ce4757ff22f37061516e7"
    sha256 cellar: :any,                 ventura:        "61237e27e18f198728b2bd60da6659be2d3d6d141252bbf2dc5bf266bfe5da99"
    sha256 cellar: :any,                 monterey:       "99fe60bf2d8a145e4a9b100f82e9446979601541c6299369006a211daf1926f0"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "0ea27eead6dcbe2c8370200952b47e61132e0fc8fc48ebfc4919a70d1c731210"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f42a55415c86ee852b6aa3fe16cf356a78aca93f1d0a905baeb83986fc2df1e2"
  end

  depends_on "rabbitmq-c"

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    Dir.chdir "amqp-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
