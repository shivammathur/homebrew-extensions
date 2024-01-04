# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT56 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.1.tgz"
  sha256 "d028f0654f83e842cb54a7530942363a526fb0da439771c7a052de6821c381ea"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "c71806d7167fb4a9fafe499930753291bae7aa2860af41c304bc9d233bca4e3e"
    sha256 cellar: :any,                 arm64_ventura:  "c302d75a3dfebdc1881cc2ad2284c1cc0826e86fc07d17c4e1dce56059d2b6d5"
    sha256 cellar: :any,                 arm64_monterey: "3b99bb3a6ddd582afaca88c9c08bbb644fd87b7186478b842b827b9ed09c1b2b"
    sha256 cellar: :any,                 ventura:        "ce96bc5b895e93a30dc37b253d5125001dd9fa0a04572112d41702cd89659562"
    sha256 cellar: :any,                 monterey:       "8731bee8e498931fb0f0b4ab970b70a4375f95db1168e869c98c3440c9e9a1ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0fd76d98808d55f3b128b141481bc77fc203e6c30184997861956287bc38f1c5"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
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
