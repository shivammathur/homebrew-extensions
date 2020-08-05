require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XdebugAT56 < AbstractPhp56Extension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://pecl.php.net/get/xdebug-2.5.5.tgz"
  sha256 "72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4"
  head "https://github.com/xdebug/xdebug.git"
  license "The Xdebug License"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "3eea5844b9e987012467545329d4e0d7a00caf194a46378a0ce9384c3dd122f9" => :catalina
  end

  def install
    Dir.chdir "xdebug-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file
  end
end
