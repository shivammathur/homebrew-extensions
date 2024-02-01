# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT56 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "edd6fbcf00fd71e48fc17c184ab76b98b56e9db717814c7b5f13ff020491a312"
    sha256 cellar: :any,                 arm64_ventura:  "c62dc56f8a53ef516beb21cd6e8dbe2b3481fed7c3c52a81ebd7d4561d1bf6c4"
    sha256 cellar: :any,                 arm64_monterey: "cb607c6425c3e3c5312bd6ac4bb168bc108b9fca9865dbcb4bc45ce5e42c07d4"
    sha256 cellar: :any,                 ventura:        "cf1be3857856f55969e25c0d59a8da6395adafec7ab30ab97dad6effed3d195b"
    sha256 cellar: :any,                 monterey:       "5c1d65bf85d6835beb8bff6aa081aba7b883e8ca2da2246b578b26c683948980"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ef537ea6acf5cb81fcdee83e04f4b811ac254f5abf673c1ba8fb878c2bfef068"
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
