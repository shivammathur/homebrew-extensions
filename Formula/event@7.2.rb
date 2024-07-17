# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT72 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.4.tgz"
  sha256 "5c4caa73bc2dceee31092ff9192139df28e9a80f1147ade0dfe869db2e4ddfd3"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "c4ee30be0400b8bc7086d7ce502baf67ac588dae0d2e5be9c081322729f19b36"
    sha256 cellar: :any,                 arm64_ventura:  "eacf15cceeb8b6f75700c4c9fcc32a70742169a3c0693942594fa4ac820eef8b"
    sha256 cellar: :any,                 arm64_monterey: "5cadea0b8e8fd58fddbce038c3608e5690305e5975aadf163232d647446081b1"
    sha256 cellar: :any,                 ventura:        "f6c4a2580c3edfd9546766c06a78387a3c0f746112d3a0a08462bf32afb2a6a0"
    sha256 cellar: :any,                 monterey:       "ddbde1d28d59bea49803d31981235216a9475002267b2931e2eec053e8764354"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "951fbe84dd364d287a1d4058d0552854febf985f2bc411c93f6cba5d2303fd8b"
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
