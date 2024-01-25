# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "1de3683692b470b73d0fe33e2829c91c2ce715d3cb9c155b9710a30e95e2f984"
    sha256 cellar: :any,                 arm64_ventura:  "5aa876aa0b9c4025b0dddd50f86e53f6abcc651b4fa532bf465bf68060e484c7"
    sha256 cellar: :any,                 arm64_monterey: "b82a93fbcbdfb93f7e186b8bc16eccca11c0200418f473d4e30efcfa2fa854e1"
    sha256 cellar: :any,                 ventura:        "91ab6c93c92c2a1a8940cd0141686d24182a04be28877d51792b9db124db38c6"
    sha256 cellar: :any,                 monterey:       "dfb653354dc872e4f8de6f9411bf4b9be1b2da79cbb77e3e757c663cf2de8a1b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b1c6cb0e92efb4bc16731e6f7c26aaf616ac3e95bee3b379aad5ebd04c26ed5"
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
