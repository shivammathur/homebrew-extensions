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
    rebuild 1
    sha256 cellar: :any,                 arm64_sonoma:   "1bd49d9e94d61604128da016eaece704206d89034d50a1a5b542a490458324f6"
    sha256 cellar: :any,                 arm64_ventura:  "5fea696ba1920d321a7b80fde82c1b32535b1f831980132059ff83a2b8c4ced3"
    sha256 cellar: :any,                 arm64_monterey: "db2791baca539d22c9eac1f41d10c04817e131d17391efe588bec6401b6e7d0a"
    sha256 cellar: :any,                 ventura:        "ed24be7a288bd56c5b674421be117b37ee8a48b21b14876f671aa58fafb43a05"
    sha256 cellar: :any,                 monterey:       "f84873071aa4985674d15430affdf0b8cb3a7080d6a8558fb368cb55dafa3196"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6a3ad40f7eca12c172ac9de950ee961050a7f5c9d1dd963c8fe5c064873a7572"
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
