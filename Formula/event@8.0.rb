# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT80 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "ec7a589e3fcafb3a4cfd6e0766f65cb8b45545376f0ebac21b11df494a14b3c7"
    sha256 cellar: :any,                 arm64_ventura:  "4d09eb77d7bcec2d98e5642feeb06a4a37da73aa537e32c68a4716e2c6301f8c"
    sha256 cellar: :any,                 arm64_monterey: "cd2242a3232bd7e5e3af82d92851febcab0b50b28970e8d2167c3a66571c68c4"
    sha256 cellar: :any,                 ventura:        "d37ee6d1ac501d0c8ca6ab53771d17d397fc540a0cc41fe4b8890aeef3625778"
    sha256 cellar: :any,                 monterey:       "14f9c6a0dd039698a7dd1adbe8580088b7e91c61133802b38fa40ffe28f11c81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7cf175b381cda50639b1a4fd84642f47679661ea8cebd19c4aba6e4163f12df1"
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
