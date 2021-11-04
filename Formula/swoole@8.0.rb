# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT80 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.1.tar.gz"
  sha256 "7501aa0d6dc9ef197dbfa79bff070e751560a15107c976872ec363fee328b0f4"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "1e4e9576f522a2d7ca13bf97a1058028c9503c4b60812fa6567053deeb68e0e6"
    sha256 cellar: :any,                 big_sur:       "4ec2849467362a8db31ee4c7003648a2caa59eec020cb32ce3ed871b13c6ceeb"
    sha256 cellar: :any,                 catalina:      "0fddd3f4eb1fa812689f0c870d9bcbf84c904be0e5e29684fff5912e688da199"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fe75f8be3127666488280d8a61a1e1735c6a0ca581cf25f0bf0800c4c5323ee9"
  end

  def install
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
