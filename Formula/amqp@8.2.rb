# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "c45f6b7765ea1ed09ba74d7f4c28e24bd13d46f15539c7a55aa10b0d5a99dc7c"
    sha256 cellar: :any,                 arm64_sonoma:   "1ff96debc807856eebd582af60e8f98a5c400bb60b4ec80cf8a372821f29f643"
    sha256 cellar: :any,                 arm64_ventura:  "720d3b0717e1dfbb8448e9f34193875676d4bf29247f1ac35df30f8ac86b7547"
    sha256 cellar: :any,                 arm64_monterey: "a9ebeee669ad748717b1f8027bef684718ed1370673f0d4e72d1a3406d243f2b"
    sha256 cellar: :any,                 ventura:        "fb15bb6c723567ace0e85e764551a20787ab1a8776370edbba26126df1fa46f9"
    sha256 cellar: :any,                 monterey:       "31c8197227d144f894caf0e8cd1bcfcf0a973c53319e838a714c3e7b865ec2b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6c297a58e2be74bb275be4c26fcdfc0b5f8e032d8300ab371ab2e7a1f8d8366"
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
