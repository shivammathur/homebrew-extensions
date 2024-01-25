# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT74 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "f0068633b8b0ed05e1107a732ba54288a2b51537ee34be710b1ef375fa10776d"
    sha256 cellar: :any,                 arm64_ventura:  "3024ca985b1caf75b54976a17c8f34371506ee769c4948e7596c461e71334784"
    sha256 cellar: :any,                 arm64_monterey: "f718e0a0692f1cf1421e1671e385ee005813e6bceb0b7126041c639e07321134"
    sha256 cellar: :any,                 ventura:        "c66780eb02927ff996ea2d365bc9175042799679c4bdc04cc5c996a1758918d7"
    sha256 cellar: :any,                 monterey:       "e4f2ce7b9df16101fc0123d23647cb6f2fec1177e80d88ab94c1bde2ecc344f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6877aeedc03dbe7c88812030aae0dd6dd3c3b6d230a8f9d2f2aa0b627c09d58f"
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
