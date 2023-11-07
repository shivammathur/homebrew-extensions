# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT82 < AbstractPhpExtension
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
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "c9595fc2a68d098ac8778eaf9936b87a5d8cd9ffe77eb23cf0bf3555754c2eec"
    sha256 cellar: :any,                 arm64_ventura:  "27ae15b78ab1d8e9045d6bacff0b20f78b609123e6cbe3362075ebee3de18244"
    sha256 cellar: :any,                 arm64_monterey: "1e0c04faa7baaf4b39b93b916a83ce8a099211479b5892fde804c2a23affcec8"
    sha256 cellar: :any,                 ventura:        "1a50ec863dd35205b8e41c1a77cca82e94d6217243f2ea75f41e8253241d81ef"
    sha256 cellar: :any,                 monterey:       "52d54714f163dd50f5424947d36230a785c3e4b2499685df5f097bb624df4870"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "75a771b441efcc56ca06a294bce68bde7dc6e7036c0d56b520467bbaeace801e"
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
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
