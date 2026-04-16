# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT73 < AbstractPhpExtension
  init
  desc "Zmq PHP extension"
  homepage "https://github.com/zeromq/php-zmq"
  url "https://github.com/zeromq/php-zmq/archive/616b6c64ffd3866ed038615494306dd464ab53fc.tar.gz"
  sha256 "5cb6e5857623cb173ad89fa600529e71328361906127604297b6c4ffd1349f88"
  version "1.1.3"
  head "https://github.com/zeromq/php-zmq.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_tahoe:   "9d54e716f1652efab1eb87514e2a0ee331d5a63b8a3ce9db2c7312e596061958"
    sha256 cellar: :any,                 arm64_sequoia: "609792c486c435e3430c46d091953204dd51d72fbec1703d627795929c40f94b"
    sha256 cellar: :any,                 arm64_sonoma:  "d9556858dc963f7abcb8129291984315e5c507ebb141bb68af42d1b500a4a2db"
    sha256 cellar: :any,                 sonoma:        "4f5acbb17da7199197acc86914b0b20ca8f56e561242a07066aae88e31bd7765"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3499b095a5be6fe5821743b051d553062a91496d86412d0cd6f5ae2d410f07b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "23675767197f54c6a4bdfd1374795802878f897dcdbb4ae01c7c780ab307a7c2"
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
    safe_phpize
    system "./configure", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
