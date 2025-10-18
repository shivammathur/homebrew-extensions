# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "fa3fe33ce9be467fff0816192f3b8d6b2bbc4da8201754661780495d5b154811"
    sha256 cellar: :any,                 arm64_sonoma:   "0f668bf90d6734e79d464bf344f1edb8a8af3563baa6c84314b096d721363f15"
    sha256 cellar: :any,                 arm64_ventura:  "f09334254758ff99ac7e114f378039acbbf99608f89455d00ad505a1bfc5d7e7"
    sha256 cellar: :any,                 arm64_monterey: "2b3127da7c28374802b57cda71f063d576e57a3f593d763559f64d52b6b0f9e4"
    sha256 cellar: :any,                 sonoma:         "d2952503b8eefc580e53cc1daca5ead757313d13084453d96ca88dfb452cc7d0"
    sha256 cellar: :any,                 ventura:        "f8e5e88fafb90693923a8f66743b198e3fbb39e597c24ec2e8ada38d20eed661"
    sha256 cellar: :any,                 monterey:       "9c3b8f2f94d1cade1e3c1f84e66756c42324b7d1f08f4f59320690813b4961b5"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "3030ba472208f6473170b4605b63cb795c6e76458e472221ca48401afef05093"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7147490050c9a8486ba6a1c7d3a47bf284461ef4014ab424a9613b9896cff593"
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
