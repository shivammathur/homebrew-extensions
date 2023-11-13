# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT83 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.0.8.tgz"
  sha256 "e3e91edd3dc15e0969b9254cc3626ae07825e39bf26d61b49935f66f603d7b6b"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "cdec6382ace2cfc00be317318d745a358b20caf7c3eafa756b933b35c6065e6e"
    sha256 cellar: :any,                 arm64_monterey: "565ce4fd376650282cd820b862646f4ebac20bb1c2f6c5721bc0b24c6f96d685"
    sha256 cellar: :any,                 arm64_big_sur:  "41db21f9ffebf1ed33761fdc0e619fcd80c9104b0363e71a005119312ca30e9f"
    sha256 cellar: :any,                 ventura:        "44ed0f2e6daa078b8121cafc1c0f249bf2f542588e6b0a294798d6d0e9b6c8f2"
    sha256 cellar: :any,                 monterey:       "a86d7a009a3560c614469c96872855808a19cf21aab68e2e6f3f78d564d18656"
    sha256 cellar: :any,                 big_sur:        "07a18e665374cfaf534f44e611b072026fa721e554cccbc5e23b5a8d8639a922"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8532e6986eb074d2b9a176d70696df67e5bc795901533f05b054a10f9c75d96b"
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
