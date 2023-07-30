# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "fa797aa2f7a295b1fc8cbfa3992b18f0f748ef44e574fdeecdc6ac044b3a48c0"
    sha256 cellar: :any,                 arm64_big_sur:  "d59602a984c69b7506a09ba6a500e921d3c692774bdea6fd376bae5aa56a1fd0"
    sha256 cellar: :any,                 ventura:        "32460ccc2d9acd46f82ed9acc270a17a32b6fe15ec41d2fa28594b40ee772112"
    sha256 cellar: :any,                 monterey:       "312a28621ee527f1dca9a9bc3999f9d80389b5fb5349ec762a82baf867b13130"
    sha256 cellar: :any,                 big_sur:        "b97556a99a82d23995ac70a2268e337bc572436014d7dc577062d6d33b2bd7e8"
    sha256 cellar: :any,                 catalina:       "12491260c3f80b1ad076f8a0e6eccd661cce87b59db1b9e24a47d401d78f192b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "af4365136b356e39dc891490f3ea82938689afbece22d52db27b942fdd3d8982"
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
