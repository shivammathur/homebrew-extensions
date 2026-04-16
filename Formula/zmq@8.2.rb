# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT82 < AbstractPhpExtension
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
    rebuild 8
    sha256 cellar: :any,                 arm64_tahoe:   "b1a07427bb14061c9ccc128a329ca385cee3a839b949b107140febcc07bc2187"
    sha256 cellar: :any,                 arm64_sequoia: "7ed2294f9d3c7f6537b7e5e924fc54f72fad7b34abd1871f00e2cafe49798acf"
    sha256 cellar: :any,                 arm64_sonoma:  "5f467498e7e3e96e88b5f3933cc7ca7bd843b1930f598d3646406c24a906fe2c"
    sha256 cellar: :any,                 sonoma:        "edf3da878096258463a4e902323c67b9cbe0f240e92d5ef23fcc1fb9e7e4ae86"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8f900e6373db3598334412a44bf39f26eb0e3dc001ff189364140658ae9eb637"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d6c9f0353435fa1588b9121b4641b456144b35634806930213a880c5c7bd512e"
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
