# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT84 < AbstractPhpExtension
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
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "dcb99a57a45ba7882930a5962de21c5346e7a40e217463701217142cb66f01d9"
    sha256 cellar: :any,                 arm64_ventura:  "45535a061a1b601f546d713712c8fc6f9c56de0a8872d93b2a51da48be2e4586"
    sha256 cellar: :any,                 arm64_monterey: "68daddf6917f169146c3b158f567b66d157051fb420ff1b77cfeb2284d6883ea"
    sha256 cellar: :any,                 ventura:        "7a9c6ea2010ffa9e0fa6304844522d14f9c59b757b952996d1520b31c9b92dd1"
    sha256 cellar: :any,                 monterey:       "7d63bb19addc62352858e3ee73eff3b8564d5faf524ffd130b5622f518a81112"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4eb1da4c84b9b3b3aafcf5888af42e70dd177b9bd106cf0d64437416fb32c83b"
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
