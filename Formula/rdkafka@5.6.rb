# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT56 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-4.1.2.tgz"
  sha256 "8ae04c240ce810bc08c07ea09f90daf9df72f0dde220df460985945a3ceec7fc"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "98d7e1a8bb2119418dcd577a35fcc7420a6b920ec4f955e238f33d1b65352ad7"
    sha256 cellar: :any,                 arm64_big_sur:  "ca03c5c32288a9bcc50f0ccf9ac121fe250ff585310e21759263a8586975f68a"
    sha256 cellar: :any,                 ventura:        "a81fc33c1dcddc95e8b34177da64ee751838a3277c72b43c4a8bc53cda2c6243"
    sha256 cellar: :any,                 monterey:       "7d5947c630a101d010e0355adcabec10acaf5bdfa52bd99560ef28cf014d408f"
    sha256 cellar: :any,                 big_sur:        "e199d1c38ed1d90036732b1c7af705db2096d57c095b22957a2069ee1fb64208"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4c3637a5a40ddda51cb7cefe45b248b00834441955dd2df0612102ea89858b3f"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
