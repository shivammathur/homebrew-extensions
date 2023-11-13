# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT56 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.0.8.tgz"
  sha256 "e3e91edd3dc15e0969b9254cc3626ae07825e39bf26d61b49935f66f603d7b6b"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "53001ee114f30c9066f8ece35ee063e65e4f1620b534ae5e54a28a7a28a1584a"
    sha256 cellar: :any,                 arm64_monterey: "a3462058680cd0aa0deccdb14e59d83f3bc316d04aaade10b343bfd55cf3165a"
    sha256 cellar: :any,                 arm64_big_sur:  "6b5668abd815faade53d0be907d0610142f1d8006ca1cfb26d6b82e9c3ad36c4"
    sha256 cellar: :any,                 ventura:        "4b7d539731eb6ea3b0cf6bece4037d5e98936ce34a78d21c4233c2ded270b007"
    sha256 cellar: :any,                 monterey:       "83fb1f75f32783043b22159f46f0c731f1d5d86745f7cb8247c891a7f2fdb320"
    sha256 cellar: :any,                 big_sur:        "f5cd00788d17f575ad0a92851748a5b3e1b7ff587d95a8b6f029cd51b0a2ccec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0c4b824c77c04eae1a562b472598e3e9e1af06dc3889babee2ceefc53e521a72"
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
