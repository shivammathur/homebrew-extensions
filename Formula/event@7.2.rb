# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_ventura:  "b2cb8edd170b5051bbe1786084cbe149f9fb331fc23870c473141a71dcf16e7b"
    sha256 cellar: :any,                 arm64_monterey: "2c4a3cb9b6595461952122bc0ac0af9c277c733021e44d81cdee200afc19d98a"
    sha256 cellar: :any,                 arm64_big_sur:  "3a13da63f0a51b039661183b53ee23e33e4849334f6fb958ecf65c40e4514c98"
    sha256 cellar: :any,                 ventura:        "217dc24765df7df4da7a64fa8191a14a91af4b1d7b163ad040350fd47db4495a"
    sha256 cellar: :any,                 monterey:       "d12451e9fbaf049af15c9a1aeaaadab951e4bcfb5eea3d140715fbaa05c7e551"
    sha256 cellar: :any,                 big_sur:        "21005981e03f16f650cdb9526d010f1300dd3fceeef20817f78b129f5f280f8b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "12e6a95b17f605d83070bfde49be40aadec60f6ff6bee356c47907d84d534c9e"
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
