# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "481225472fda4332ba9614bf0d3e7e93a3cae86fbd3787100e318c080cdcbee8"
    sha256 cellar: :any,                 arm64_ventura:  "cbff113da7c06fdb384b4e09930718892a9cf56214668894abb488bf8eaca76d"
    sha256 cellar: :any,                 arm64_monterey: "1f971ce700ec5550bf786322c9f2999a305cec6068351f5a929cd989aa9e5620"
    sha256 cellar: :any,                 ventura:        "c1ec4f63490055b8578b0532b9612410ab3d6e82b267ac4b41c42d1999e1870e"
    sha256 cellar: :any,                 monterey:       "a8f68209873a27180fc0d4fa28ae63b71a5234e5db4eae55de703923509ea7f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "efc12b75d5de2971db7becfb5a4295f0bf755f9563269747bc759bfa122949b7"
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
