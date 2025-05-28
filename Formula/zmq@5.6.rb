# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT56 < AbstractPhpExtension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://github.com/zeromq/php-zmq/archive/43464c42a6a47efdf8b7cab03c62f1622fb5d3c6.tar.gz"
  sha256 "cbf1d005cea35b9215e2830a0e673b2edd8b526203f731de7a7bf8f590a60298"
  version "1.1.3"
  head "https://github.com/zeromq/php-zmq.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "6e562718b008a3042417d527f60c29ecd14e33253d4b6b824e2b9e9c7cd287b5"
    sha256 cellar: :any,                 arm64_sonoma:   "8540fef04111d24dc9d5241e6c4e4d6d5bff327866cc7a313e584c7fccf220c2"
    sha256 cellar: :any,                 arm64_ventura:  "9eb09ab61deeeb26fc19e4f0dec0de8d4ebb336cddd90a02eb8542ec96f05009"
    sha256 cellar: :any,                 arm64_monterey: "5394c0545c513555f50a19cf3e505ec359cffbac23363a0a2bf12d757330a8f5"
    sha256 cellar: :any,                 ventura:        "9f052e95c6e1d462e9e293d1306c779631f4d2f409cf0e3632ed34baef10f553"
    sha256 cellar: :any,                 monterey:       "bac5c8ae6b07a9fe16c895d6d550f3713d21becf7ee221dcbc402c3724de0028"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "df6abf4b1545629859f49a4f773b5b7a344e2c51ab11c15bdc0c4a272d95872f"
  end

  depends_on "zeromq"

  on_macos do
    depends_on "czmq"
  end

  def install
    ENV["PKG_CONFIG"] = "#{HOMEBREW_PREFIX}/bin/pkg-config"
    ENV.append "PKG_CONFIG_PATH", "#{Formula["zeromq"].opt_prefix}/lib/pkgconfig"
    args = %W[
      prefix=#{prefix}
    ]
    on_macos do
      args << "--with-czmq=#{Formula["czmq"].opt_prefix}"
    end
    inreplace "package.xml", "@PACKAGE_VERSION@", version.to_s
    inreplace "php-zmq.spec", "@PACKAGE_VERSION@", version.to_s
    inreplace "php_zmq.h", "@PACKAGE_VERSION@", version.to_s
    safe_phpize
    system "./configure", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
