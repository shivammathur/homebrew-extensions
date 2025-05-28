# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT85 < AbstractPhpExtension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://github.com/zeromq/php-zmq/archive/43464c42a6a47efdf8b7cab03c62f1622fb5d3c6.tar.gz"
  sha256 "cbf1d005cea35b9215e2830a0e673b2edd8b526203f731de7a7bf8f590a60298"
  version "1.1.3"
  head "https://github.com/zeromq/php-zmq.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "fc18ce7dfa199140c253d5290792b9017348fb8edb9f9b135d1ac10d4f8acf0c"
    sha256 cellar: :any,                 arm64_sonoma:  "1f0c0b035a5025769cfd48981a9a1f301d5c5b98ba44caf6be91c30559af95a9"
    sha256 cellar: :any,                 arm64_ventura: "dc3878bef1ffe0c25e19cd78ba7548701cea051be4e58751fa06573b83a3749b"
    sha256 cellar: :any,                 ventura:       "24e8ab123df39f54c0fdce5aeb42f9558fae029f1c22d5d48778235d79043720"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "534405529c1e5ea644d7937a09d1d72c3fb506ac72ca7279bb50494d0b5d907e"
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
      --with-zmq=#{Formula["zeromq"].opt_prefix}
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
