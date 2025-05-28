# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "abaaf8fc3ae654dee6422e7567fd81fed1071b2a8b39421ffed42d7bd60dc880"
    sha256 cellar: :any,                 arm64_sonoma:   "2d36d80fbd36d59990179482cb3ed32be6c4d4458b292e692e4bf2f49b9495f8"
    sha256 cellar: :any,                 arm64_ventura:  "1cf86a17340e9130ec16a1eaed38a13caed5fa4646d1c9fc3d7f061e57d4b63e"
    sha256 cellar: :any,                 arm64_monterey: "e74234c2018129dae098725b8b147484d89addfbe458877fe4b0609ad51724b4"
    sha256 cellar: :any,                 ventura:        "59d0f978089b26ba143e8df57380ee315ecff00ca85300dff4b799377f666c8b"
    sha256 cellar: :any,                 monterey:       "88ba5f228465f48e7ff45ca47ed7fc5e789f2ce9783846106ff65105eeea4efe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8b0aedcf6329319895a25ff5b4db7bd9d7f095b03794aa3a40a892ead43c1b3c"
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
    safe_phpize
    system "./configure", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
