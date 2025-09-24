# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "bdacaada42c3ff68a117fdc6648dd73b52dedcbbea1ba171f8ecf1b53a8bed46"
    sha256 cellar: :any,                 arm64_sequoia: "6c8013646a0ac63ff6dbf48f24fda3fef6617476a9635a91af078e2ff37555f9"
    sha256 cellar: :any,                 arm64_sonoma:  "d6d9e8136056a1e55da0e2feedc1698eec8ed35052cff96ea7ba2c1d514b1b90"
    sha256 cellar: :any,                 sonoma:        "15948a3b48bcec3ebc0112a9e9f612071cc098c0248897de42127cdb89a66744"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "41768e22dc91716cd480600f004187531047550c61b3afadea74c6cbef77d86c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6c0c875e5b9a700b8d5c729c1f4483e9b47b9140f8dfc8af3aced4df9438971c"
  end

  depends_on "zeromq"

  on_macos do
    depends_on "czmq"
  end

  def install
    ENV["PKG_CONFIG"] = "#{HOMEBREW_PREFIX}/bin/pkg-config"
    args = %W[
      prefix=#{prefix}
    ]
    on_macos do
      args << "--with-czmq=#{Formula["czmq"].opt_prefix}"
    end
    inreplace "package.xml", "@PACKAGE_VERSION@", version.to_s
    inreplace "php-zmq.spec", "@PACKAGE_VERSION@", version.to_s
    inreplace "php_zmq.h", "@PACKAGE_VERSION@", version.to_s
    inreplace "zmq.c", "zend_exception_get_default()", "zend_ce_exception"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
