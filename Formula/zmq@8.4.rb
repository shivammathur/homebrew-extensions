# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "83afbaa0ecbb9f8c122c870f69feed62ea8c98adc283b9fbdc99b532b6c59972"
    sha256 cellar: :any,                 arm64_sequoia: "f83c6a1dac9eedbac3153b86a7d5895325916c9ef66b32405fe94c5b1de96a8e"
    sha256 cellar: :any,                 arm64_sonoma:  "7179aa634ab295985a6a62aff844a49679b2f0128a733db3d13dbe940cf56b09"
    sha256 cellar: :any,                 sonoma:        "2fb21607afb53a8330fa8ea6c4122554b017d36926cdcc72d366bc4bf359c05c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4bff931c72ad851d5899b7382f589463afece80fd3c79531dc67645677d7b100"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "375d5bdd666877cc9875957b8d04a49a41aa22058523d19e7ab23679952a3c2d"
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
