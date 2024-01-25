# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT80 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "d98f6b0d217b4eaac0393783d2932f25a98888c5b10d7aed60fac9e712974e77"
    sha256 cellar: :any,                 arm64_ventura:  "46220db6542a01cf9b590fbf7b8ccd48601b311694147ab0abd552127a8c0ac8"
    sha256 cellar: :any,                 arm64_monterey: "b6c3ccf5d06adb7aacffda1d1b806aa74f77643a7d2676f7b76870190bf146e7"
    sha256 cellar: :any,                 ventura:        "3db27763025fbcdcf7772ea1e43483bc91a31b7417746916a9cb769c35d2e241"
    sha256 cellar: :any,                 monterey:       "dfb68429d1eaa07634562e1e173abe70813d3d326c2bdbdc2a2a87c8dcc641d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8c79ec9f6a8901b0220e181f52a7bb33fb00aa5b8298692a85798c27420251ad"
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
