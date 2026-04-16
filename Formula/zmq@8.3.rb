# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT83 < AbstractPhpExtension
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
    rebuild 7
    sha256 cellar: :any,                 arm64_tahoe:   "c5cc81745fe4d280bf7cdec1a089963ef924d203b0c537263728abea628c8f13"
    sha256 cellar: :any,                 arm64_sequoia: "b8e9a70cf4c7cf1f6faf61f4f233792a15bd9b032025d90ce13bf40bcd978537"
    sha256 cellar: :any,                 arm64_sonoma:  "e265fbea9888f13a42086f4a5e11117b6deea061f890a9de1958c468d0e8fed4"
    sha256 cellar: :any,                 sonoma:        "eecd97b4f244eff2b96811dcc3ff352978151a8c35c00d0145f4d40fb177120b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4ff907f075853dee73bedabc71ed64e1e302aaabb97806ba8e48e922e9b4daec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa5ab4119dcff5f857b88ff7470cb9409ea8c121698e0273f71f8ed06683d007"
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
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
