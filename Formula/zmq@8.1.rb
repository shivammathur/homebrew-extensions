# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT81 < AbstractPhpExtension
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
    rebuild 14
    sha256 cellar: :any,                 arm64_sequoia:  "175bef87e7b3f3fef8fa1fafe2298de980d2ce8dfc26c3a3d12526b17006ee9c"
    sha256 cellar: :any,                 arm64_sonoma:   "caaa6436ea3321587cc7988bb93ed1a15fac530c201153a9a0037cb8821440a0"
    sha256 cellar: :any,                 arm64_ventura:  "7a26b637dad37046d9125a466b8b5c473cd62d4af45f8d53a8289b394dbf7700"
    sha256 cellar: :any,                 arm64_monterey: "d24b4167bc59f5e11120764ecb2751f81422dcbce27d0d81885c27d7af89471c"
    sha256 cellar: :any,                 ventura:        "e7b1b71e41c980dc8919e2e9967bc2c1b38cf9bca3d8628a2eb31e19a476aa15"
    sha256 cellar: :any,                 monterey:       "e2e7426614855b263c48eb309a68ec6ebb0fd7d916d230a3ce07988f336af366"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c33d070bfe3db68a68cade95c3c2f8c4a33c535505ede1def69248ac5a784953"
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
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
