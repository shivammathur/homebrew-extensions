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

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "b4f13acb8d6045623296f99b1b656748f250f0b04b5f430bd64ea42079b31545"
    sha256 cellar: :any,                 arm64_sonoma:   "300fada8c790c0410792cfed769baa842c28029f375dff140512dc31424f90b4"
    sha256 cellar: :any,                 arm64_ventura:  "8b29546bf132a9e6acf3f2d9e4bb1f430ed92ae973514b946d27492c67aee831"
    sha256 cellar: :any,                 arm64_monterey: "d3ac6a5be87d2ebffa5173077427f27f97dddbf46fa76017a4cd57fbe67a1adf"
    sha256 cellar: :any,                 ventura:        "53f42d4caf02bb13d90a376c3ab1adf9a35bec6436a38fb2d24b7ab543cd8050"
    sha256 cellar: :any,                 monterey:       "4c0760756eb3e2a28252954718f814303f062d45248e4aab8a66441837a35e9f"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "a42b472b649d9c2763604a2cb4422d57cf511a3f247f23e0baccd7853adeb721"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2d30b4059a4aa1df6ac597df5d45d9b14916108a9fdd10d30f9377af4fe41b8a"
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
