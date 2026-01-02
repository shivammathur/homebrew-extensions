# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "5382fee0c4b171ae6466c48a3f9cb1f3f5dfddef09de8932718fd9b5a1dc04e1"
    sha256 cellar: :any,                 arm64_sequoia: "ea4d7d34d387c2fbaf731367f6f7ad57016763b148f3086caabacd085b8ea414"
    sha256 cellar: :any,                 arm64_sonoma:  "118f4aa4d81f455a9c04c30465ca096639e97f1f9609a01b9ad3b8d0b87e6af8"
    sha256 cellar: :any,                 sonoma:        "0ca809ccbd2a3ab7fdd817096b1f4ce57b7e1d3c99be9959ef0ff52f374d8f10"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "154537c665ef306c1c44ed66d3910925ec9bf3c6420a8f7e34aa4372670aef03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa200c17a2848c12045159de639e727ea6884bc4af7377d493218699efdc581c"
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
