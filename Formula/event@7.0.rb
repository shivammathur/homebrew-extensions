# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT70 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "8207254e245cb54bb43c4028a1e44ce9f8deab625ca37774b683516fa0f1cba0"
    sha256 cellar: :any,                 arm64_big_sur:  "b41387b72382b8d4c6319e6c1b9aa7156e54815cb67d7e4fc93aee3f17c8c74f"
    sha256 cellar: :any,                 ventura:        "584d6af94d5e3d2f3c7ec805afde4e353872e5e70654aba27dce5100818fc87c"
    sha256 cellar: :any,                 monterey:       "25d58b79dbf38ecb651d60e7f0f4ffeae80c660c4c7a0b2dca43c274aed9c754"
    sha256 cellar: :any,                 big_sur:        "70b42ebb9912eab00b8ba28f56823a279f35de06c0eea72e038da7a27ca28331"
    sha256 cellar: :any,                 catalina:       "0d2054621b6ea441717029c40c6b057f45b57d3e15c14f9664e1a5c4a9dc36f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a1a169a94b97a77f5fbde7cfe7384c84d98e116b15c6e45214205dce36a2bed3"
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
