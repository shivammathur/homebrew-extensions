# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT73 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "a009aa6675d605e428f4b1d2606c7826cca9e7c5db3e3fb48e9148943d8d2ed3"
    sha256 cellar: :any,                 arm64_ventura:  "cb298c0f654fb1df087911c9eac07e9061de525fba6d3149185c9910010012c7"
    sha256 cellar: :any,                 arm64_monterey: "98070336d67e7f400c120a13c6e5b483c3733794dec3a12ab00768e09c7cfdbc"
    sha256 cellar: :any,                 ventura:        "e6ec6c1835773d0db2fbafcefcea4bc1fdcd1e95a77058f895127932fbbce7ca"
    sha256 cellar: :any,                 monterey:       "aaa85a854afcc2b3d8b86f713300fb14a01ec355777c56075843168adfe6abf4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "484a2a3d260a0b60a969a835ae927288080cc507908bbf4e362d9183f840a3db"
  end

  depends_on "zeromq"

  on_macos do
    depends_on "czmq"
  end

  def install
    ENV["PKG_CONFIG"] = "#{HOMEBREW_PREFIX}/bin/pkg-config"
    ENV.append "PKG_CONFIG_PATH", "#{Formula["libsodium"].opt_prefix}/lib/pkgconfig"
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
