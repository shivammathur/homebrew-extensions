# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT74 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "eb5bf0e4de1665a87cb441a27d3bd703d1054c35ef5e8a609eb165a1dca5e134"
    sha256 cellar: :any,                 arm64_ventura:  "bb2fe270ad7ef113bc201277c2d128d4c195b1d8405b01a34ebbc13474ec3830"
    sha256 cellar: :any,                 arm64_monterey: "4a948e1fb28960e95e6c4bbf0831f8aa6f2860e2234ee4d1257fb6530dc1641b"
    sha256 cellar: :any,                 ventura:        "da93f9ea86e37f9f97e0cda86ef1c3579f8730eb37399fa19094c7889d627498"
    sha256 cellar: :any,                 monterey:       "300a28a9a2b00e41b70a221f72c66856df9e6f935620f4ecb0c03575b8ea6452"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "604daca44c605b45a23dc6ff5b9866e1410c071259c5248cbe62bdfc59fd3843"
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
