# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "a52ad5df98250617689c12433dc97dfcecc3651a8cc8d1ec48cc65bb5121390e"
    sha256 cellar: :any,                 arm64_big_sur:  "93aeb2643bde547b3cf11ae4fb2d88bad6130cc1bd7ea5d7fb5db7483e9ebc21"
    sha256 cellar: :any,                 ventura:        "bfa7d6564a45e4edf524f13531bb704222ed8b8aa1efe6a9fe69f0a4e333c282"
    sha256 cellar: :any,                 monterey:       "03b856c02b2035fdb86662f0b167971102a7849c0dad9d46b47c1efee38bff58"
    sha256 cellar: :any,                 big_sur:        "d3eed8b5772b4a32386d7088b101f6265bfc9d945f7a992cfbbeb552b6593cc1"
    sha256 cellar: :any,                 catalina:       "429190f8a4bc2d935b1e17636a75ad5c0af4972467f6b6370fe96f8080234eb8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "593b7518f06a4e6765889c16e41c0b15971d1444cbf09f949748ef0a5d5f132b"
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
