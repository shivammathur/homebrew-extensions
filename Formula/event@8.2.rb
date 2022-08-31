# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.0.8.tgz"
  sha256 "e3e91edd3dc15e0969b9254cc3626ae07825e39bf26d61b49935f66f603d7b6b"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "680f89c1b86fe839b57f885fc2ab3fab8981ab305779d2cc94e1dfa2063b585d"
    sha256 cellar: :any,                 arm64_big_sur:  "86586b5a163d5b3e055e32e2a8da0c1912d654798beb8680004535a62f882e28"
    sha256 cellar: :any,                 monterey:       "f1790e91af0d832373aa34c679d5cfe6e0feb7ccc3479c2aded24c1fc1c4fc68"
    sha256 cellar: :any,                 big_sur:        "5b691bfb7a95750bf3d07e75be07be5ced21c196e5ae1bf9a4c1703c8e2ef326"
    sha256 cellar: :any,                 catalina:       "111c6228fbe1955a38e480f73f506bb62cab24a16bbf29d655320b0ff3087c8b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c8b20429c87cf05d9ce76e1c01495f700fc7fb9cbbf1b78963eeb16432df4460"
  end

  depends_on "libevent"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
      --with-event-libevent-dir=#{Formula["libevent"].opt_prefix}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
