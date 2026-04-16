# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zmq Extension
class ZmqAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "07db6e87d2020287af013f170aaa950fd5e051ad7421727ca68cb418fa91ca8f"
    sha256 cellar: :any,                 arm64_sequoia: "501365c31cfdb600b59cb12bb59e631c2c977dbee9b76cb0b7d721f70cb88194"
    sha256 cellar: :any,                 arm64_sonoma:  "bc218286c550c8e81f37b7297a236519ced5b7cad971ec2f462134ec65930108"
    sha256 cellar: :any,                 sonoma:        "2389dcbe0ba5de8656e5162c9824a9bc955253861ebf92909b1e1c7f8c3b4fdc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "81f7db0ddd6f630fbec32768108082b7fb3921137ee893d97cca007aeff2088a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4ad0328ed81e5bf0cd4a52bf3ac2a7a7472f9fc461da3804c42f91a52cae820"
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
